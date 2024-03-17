import { admin, functions } from './init';
import { AggregatedData, Deck, PublicUserData, Tag, UserRecord } from './interface/public_user_data';


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

    const aggregateDeckMap = new Map<string, Deck>();
    const aggregateTagMap = new Map<string, Tag>();
    const aggregatedDataMap = new Map<number, AggregatedData>();

    let deckId = 0;
    let tagId = 0;
    let recordId = 0;

    for (const userData of allUserData) {
        const userGameMap = new Map<number, number>();
        const userDeckMap = new Map<number, number>();
        const userTagMap = new Map<number, number>();

        // ゲームIDのマッピングを設定
        for (const gamesN of userData.games) {
            for (const game of gamesN.games) {
                if (game.public_game_id !== undefined) {
                    userGameMap.set(game.game_id, game.public_game_id);
                    if (!aggregatedDataMap.has(game.public_game_id)) {
                        aggregatedDataMap.set(game.public_game_id, { decks: [], tags: [], records: [] });
                    }
                }
            }
        }

        // デッキの集計とユーザーデッキマップの設定
        for (const deckN of userData.decks) {
            for (const deck of deckN.decks) {
                const publicGameId = userGameMap.get(deck.game_id);
                if (publicGameId == null) continue;
                const deckKey = `${deck.deck}_${publicGameId}`;
                if (!aggregateDeckMap.has(deckKey)) {
                    const aggregateDeck = { deck_id: deckId++, deck: deck.deck, game_id: publicGameId };
                    aggregateDeckMap.set(deckKey, aggregateDeck);
                    aggregatedDataMap.get(publicGameId)?.decks.push(aggregateDeck);
                }
                const aggregateDeck = aggregateDeckMap.get(deckKey);
                if (aggregateDeck) {
                    userDeckMap.set(deck.deck_id, aggregateDeck.deck_id);
                }
            }
        }

        // タグの集計とユーザータグマップの設定
        for (const tagN of userData.tags) {
            for (const tag of tagN.tags) {
                const publicGameId = userGameMap.get(tag.game_id);
                if (publicGameId == null) continue;
                const tagKey = `${tag.tag}_${publicGameId}`;
                if (!aggregateTagMap.has(tagKey)) {
                    const aggregateTag = { tag_id: tagId++, tag: tag.tag, game_id: publicGameId };
                    aggregateTagMap.set(tagKey, aggregateTag);
                    aggregatedDataMap.get(publicGameId)?.tags.push(aggregateTag);
                }
                const aggregateTag = aggregateTagMap.get(tagKey);
                if (aggregateTag) {
                    userTagMap.set(tag.tag_id, aggregateTag.tag_id);
                }
            }
        }

        // レコードの集計
        for (const recordN of userData.records) {
            for (const record of recordN.records) {
                const publicGameId = userGameMap.get(record.game_id);
                if (publicGameId == null) continue;
                const useDeckId = userDeckMap.get(record.use_deck_id);
                const opponentDeckId = userDeckMap.get(record.opponent_deck_id);
                if (useDeckId !== undefined && opponentDeckId !== undefined) {
                    const newRecord: UserRecord = {
                        ...record,
                        game_id: publicGameId,
                        use_deck_id: useDeckId,
                        opponent_deck_id: opponentDeckId,
                        record_id: recordId++
                    };
                    aggregatedDataMap.get(publicGameId)?.records.push(newRecord);
                }
            }
        }
    }

    // ステップ4: 集計データをFirestoreに保存
    saveAllAggregatedData(aggregatedDataMap);
    console.log('Aggregation completed');
});



// Firestore にデータをチャンクサイズに基づいて保存する関数
async function saveAllAggregatedData(aggregatedDataMap: Map<number, AggregatedData>) {
    const promises: Promise<void>[] = [];

    aggregatedDataMap.forEach((aggregatedData, gameId) => {
        // デッキデータを保存
        promises.push(saveDataInChunks(aggregatedData.decks, gameId, 'decks', 10000));
        // タグデータを保存
        promises.push(saveDataInChunks(aggregatedData.tags, gameId, 'tags', 10000));
        // レコードデータを保存
        promises.push(saveDataInChunks(aggregatedData.records, gameId, 'records', 1500));
    });

    await Promise.all(promises);
}

// 指定されたデータをチャンクサイズに基づいて Firestore に保存する関数
async function saveDataInChunks(dataArray: any[], gameId: number, dataName: string, chunkSize: number) {
    const promises: Promise<any>[] = []; // または Promise<any>[]
    for (let i = 0; i < dataArray.length; i += chunkSize) {
        const chunk = dataArray.slice(i, i + chunkSize);
        const docId = `${dataName}${i / chunkSize}`;
        const docRef = admin.firestore().collection('aggregated_data').doc(gameId.toString()).collection(dataName).doc(docId);
        promises.push(docRef.set({ [dataName]: chunk }));
    }
    await Promise.all(promises);
}