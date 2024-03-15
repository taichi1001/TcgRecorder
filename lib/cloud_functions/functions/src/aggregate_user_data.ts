import { admin, functions } from './init';
import { Deck, PublicUserData, Tag, UserRecord } from './interface/public_user_data';


// 午前4時に全てのユーザーのデータを集計する
export const aggregateUserData = functions.runWith({ timeoutSeconds: 540, memory: '4GB' }).region('asia-northeast1').pubsub.schedule('0 4 * * *').timeZone('Asia/Tokyo').onRun(async () => {
    // ステップ1: 全ユーザーのデータを取得
    const userSnapshots = await admin.firestore().collection("public_user_data").get();

    // 集計データコレクションの全データを削除
    const aggregatedDataRef = admin.firestore().collection("aggregated_data");
    const aggregatedDataSnapshot = await aggregatedDataRef.get();
    aggregatedDataSnapshot.forEach(doc => {
        doc.ref.delete();
    });

    console.log(`userSnapshotsの長さ: ${userSnapshots.docs.length}`);

    const processUserData = async (doc) => {
        const [gamesSnapshot, decksSnapshot, tagsSnapshot, recordsSnapshot] = await Promise.all([
            doc.ref.collection('games').get(),
            doc.ref.collection('decks').get(),
            doc.ref.collection('tags').get(),
            doc.ref.collection('records').get(),
        ]);

        const gamesData = gamesSnapshot.docs.map(doc => doc.data());
        const decksData = decksSnapshot.docs.map(doc => doc.data());
        const tagsData = tagsSnapshot.docs.map(doc => doc.data());
        const recordsData = recordsSnapshot.docs.map(doc => doc.data());

        const userData = doc.data();
        userData.games = gamesData;
        userData.decks = decksData;
        userData.tags = tagsData;
        userData.records = recordsData;
        return userData as PublicUserData;
    };

    // 全ユーザーの処理を平行化
    const userProcessPromises = userSnapshots.docs.map(doc => processUserData(doc));
    const allUserData = await Promise.all(userProcessPromises);

    let deckId = 0;
    let tagId = 0;
    let recordId = 0;

    const aggregateDeckList: Deck[] = [];
    const aggregateTagList: Tag[] = [];
    const aggregateRecordList: UserRecord[] = [];
    const skippedRecordList: UserRecord[] = [];

    // ステップ3: 集計
    // Mapオブジェクトを使用して、検索効率を向上させる
    const aggregateDeckMap = new Map<string, Deck>();
    const aggregateTagMap = new Map<string, Tag>();
    let totalRecordsCount = 0;
    let skippedRecordsCount = 0;
    for (const userData of allUserData) {
        const userGameMap = new Map<number, number>();
        for (const gamesN of userData.games) {
            for (const game of gamesN.games) {
                if (game.public_game_id !== undefined) {
                    userGameMap.set(game.game_id, game.public_game_id);
                }
            }
        }

        const userDeckMap = new Map<number, number>();
        for (const deckN of userData.decks) {
            for (const deck of deckN.decks) {
                const gameIdx = userGameMap.get(deck.game_id);
                if (gameIdx == null || gameIdx === undefined) continue;
                const deckKey = `${deck.deck}_${gameIdx}`;
                let aggregateDeck = aggregateDeckMap.get(deckKey);
                if (!aggregateDeck) {
                    aggregateDeck = { deck_id: deckId++, deck: deck.deck, game_id: gameIdx };
                    aggregateDeckMap.set(deckKey, aggregateDeck);
                    aggregateDeckList.push(aggregateDeck); // リストにも追加
                }
                userDeckMap.set(deck.deck_id, aggregateDeck.deck_id);
            }
        }

        const userTagMap = new Map<number, number>();
        for (const tagN of userData.tags) {
            for (const tag of tagN.tags) {
                const gameIdx = userGameMap.get(tag.game_id);
                if (gameIdx == null || gameIdx === undefined) continue;
                const tagKey = `${tag.tag}_${gameIdx}`;
                let aggregateTag = aggregateTagMap.get(tagKey);
                if (!aggregateTag) {
                    aggregateTag = { tag_id: tagId++, tag: tag.tag, game_id: gameIdx };
                    aggregateTagMap.set(tagKey, aggregateTag);
                    aggregateTagList.push(aggregateTag); // リストにも追加
                }
                userTagMap.set(tag.tag_id, aggregateTag.tag_id);
            }
        }
        for (const recordN of userData.records) {
            for (const record of recordN.records) {
                totalRecordsCount++;
                const game_id = userGameMap.get(record.game_id);
                const use_deck_id = userDeckMap.get(record.use_deck_id);
                const opponent_deck_id = userDeckMap.get(record.opponent_deck_id);

                // game_id、use_deck_id、opponent_deck_idがundefinedでないことを確認
                if (game_id !== undefined && use_deck_id !== undefined && opponent_deck_id !== undefined) {
                    let tag_ids: string | null = null;
                    if (record.tag_id && record.tag_id !== '') {
                        tag_ids = record.tag_id.split(',')
                            .map(id => userTagMap.get(parseInt(id)))
                            .filter(id => id !== undefined)
                            .join(',');
                    }
                    const newRecord: UserRecord = {
                        ...record,
                        game_id: game_id,
                        use_deck_id: use_deck_id,
                        opponent_deck_id: opponent_deck_id,
                        tag_id: tag_ids,
                        record_id: recordId++
                    };
                    aggregateRecordList.push(newRecord);
                } else {
                    skippedRecordsCount++;
                    const skippedRecord: UserRecord = {
                        ...record,

                    };
                    skippedRecordList.push(skippedRecord);
                }
            }
        }
    }

    console.log(`Total records processed: ${totalRecordsCount}`);
    console.log(`Records skipped due to undefined ID(s): ${skippedRecordsCount}`);

    // ステップ4: 集計データをFirestoreに保存
    await Promise.all([
        saveDataInChunks(aggregateDeckList, 'deckList', 10000),
        saveDataInChunks(aggregateTagList, 'tagList', 10000),
        saveDataInChunks(aggregateRecordList, 'recordList', 1500),
        saveDataInChunks(skippedRecordList, 'askippedRecordList', 1500),
    ]);
    console.log('Aggregation completed');
});



async function saveDataInChunks<T>(dataList: T[], dataLabel: string, chunkSize: number) {
    const promises: Promise<FirebaseFirestore.WriteResult>[] = [];
    for (let i = 0; i < dataList.length; i += chunkSize) {
        const chunk = dataList.slice(i, i + chunkSize);
        const docName = `${dataLabel}${Math.floor(i / chunkSize) + 1}`;
        const docData = { [dataLabel]: chunk };
        const promise = admin.firestore().collection('aggregated_data').doc(docName).set(docData);
        promises.push(promise);
    }
    await Promise.all(promises);
}