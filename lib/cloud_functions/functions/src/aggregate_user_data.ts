import { admin, functions } from './init';
import { Deck, Game, PublicUserData, Tag, UserRecord } from './interface/public_user_data';

// 午前4時に全てのユーザーのデータを集計する
export const aggregateUserData = functions.runWith({ timeoutSeconds: 540, memory: '2GB' }).region('asia-northeast1').pubsub.schedule('0 4 * * *').timeZone('Asia/Tokyo').onRun(async () => {
    // ステップ1: 全ユーザーのデータを取得
    const allUserData: PublicUserData[] = [];
    const userSnapshots = await admin.firestore().collection("public_user_data").get();

    // 集計データコレクションの全データを削除
    const aggregatedDataRef = admin.firestore().collection("aggregated_data");
    const aggregatedDataSnapshot = await aggregatedDataRef.get();
    aggregatedDataSnapshot.forEach(doc => {
        doc.ref.delete();
    });

    console.log(`userSnapshotsの長さ: ${userSnapshots.docs.length}`);
    for (const doc of userSnapshots.docs) {

        // サブコレクションからドキュメントを取得
        const gamesSnapshot = await doc.ref.collection('games').get();
        const decksSnapshot = await doc.ref.collection('decks').get();
        const tagsSnapshot = await doc.ref.collection('tags').get();
        const recordsSnapshot = await doc.ref.collection('records').get();
        const gamesData = gamesSnapshot.docs.map(doc => doc.data());
        const decksData = decksSnapshot.docs.map(doc => doc.data());
        const tagsData = tagsSnapshot.docs.map(doc => doc.data());
        const recordsData = recordsSnapshot.docs.map(doc => doc.data());

        // 必要に応じてユーザーデータにゲームデータを統合
        const userData = doc.data();
        userData.games = gamesData;
        userData.decks = decksData;
        userData.tags = tagsData;
        userData.records = recordsData;
        allUserData.push(userData as PublicUserData);
    }

    let gameId = 0;
    let deckId = 0;
    let tagId = 0;
    let recordId = 0;

    const aggregateGameList: Game[] = [];
    const aggregateDeckList: Deck[] = [];
    const aggregateTagList: Tag[] = [];
    const aggregateRecordList: UserRecord[] = [];
    // ステップ2: 一意なゲームのリストを作成
    for (const userData of allUserData) {
        for (const gamesN of userData.games) {
            for (const game of gamesN.games) {
                if (!aggregateGameList.some(item => item.game === game.game)) {
                    const newGame: Game = { game_id: gameId++, game: game.game, };
                    aggregateGameList.push(newGame);
                }
            }
        }
    }


    // ステップ3: 集計
    for (const userData of allUserData) {
        const userGameMap: { [key: number]: number } = {};
        for (const gamesN of userData.games) {
            for (const game of gamesN.games) {
                const aggregateGame = aggregateGameList.find(item => item.game === game.game);
                userGameMap[game.game_id] = aggregateGame!.game_id;
            }
        }

        const userDeckMap: { [key: number]: number } = {};
        for (const deckN of userData.decks) {
            for (const deck of deckN.decks) {
                const gameIdx = userGameMap[deck.game_id];
                if (gameIdx == null || gameIdx === undefined) continue;
                if (!aggregateDeckList.some(item => item.deck === deck.deck && item.game_id === gameIdx)) {
                    const newDeck: Deck = { deck_id: deckId++, deck: deck.deck, game_id: gameIdx }
                    userDeckMap[deck.deck_id] = newDeck.deck_id;
                    aggregateDeckList.push(newDeck);
                } else {
                    const deckIdx = aggregateDeckList.find(item => item.deck === deck.deck && item.game_id === gameIdx)!.deck_id;
                    userDeckMap[deck.deck_id] = deckIdx;
                }
            }
        }

        const userTagMap: { [key: number]: number } = {};
        for (const tagN of userData.tags) {
            for (const tag of tagN.tags) {
                const gameIdx = userGameMap[tag.game_id];
                if (gameIdx == null || gameIdx === undefined) continue;
                if (!aggregateTagList.some(item => item.tag === tag.tag && item.game_id === gameIdx)) {
                    const newTag: Tag = { tag_id: tagId++, tag: tag.tag, game_id: gameIdx };
                    userTagMap[tag.tag_id] = newTag.tag_id;
                    aggregateTagList.push(newTag);
                } else {
                    const tagIdx = aggregateTagList.find(item => item.tag === tag.tag && item.game_id === gameIdx)!.tag_id;
                    userTagMap[tag.tag_id] = tagIdx;
                }
            }
        }
        for (const recordN of userData.records) {
            for (const record of recordN.records) {
                const newRecord: UserRecord = {
                    author: record.author,
                    bo: record.bo,
                    date: record.date,
                    first_match_first_second: record.first_match_first_second,
                    first_match_win_loss: record.first_match_win_loss,
                    first_second: record.first_second,
                    game_id: userGameMap[record.game_id],
                    image_path: record.image_path,
                    memo: record.memo,
                    opponent_deck_id: userDeckMap[record.opponent_deck_id],
                    record_id: recordId++,
                    second_match_first_second: record.second_match_first_second,
                    second_match_win_loss: record.second_match_win_loss,
                    tag_id: record.tag_id && record.tag_id !== '' ? record.tag_id.split(',').map(id => userTagMap[parseInt(id)]).join(',') : null,
                    third_match_first_second: record.third_match_first_second,
                    third_match_win_loss: record.third_match_win_loss,
                    use_deck_id: userDeckMap[record.use_deck_id],
                    win_loss: record.win_loss,
                };
                if (!Object.values(newRecord).some(value => value === undefined)) {
                    aggregateRecordList.push(newRecord);
                }
            }
        }
    }

    // ステップ4: 集計データをFirestoreに保存
    await saveDataInChunks(aggregateGameList, 'gameList', 10000);
    await saveDataInChunks(aggregateDeckList, 'deckList', 10000);
    await saveDataInChunks(aggregateTagList, 'tagList', 10000);
    await saveDataInChunks(aggregateRecordList, 'recordList', 1500);
    console.log('Aggregation completed');
});

async function saveDataInChunks<T>(dataList: T[], dataLabel: string, chunkSize: number) {
    for (let i = 0; i < dataList.length; i += chunkSize) {
        const chunk = dataList.slice(i, i + chunkSize);
        const docName = `${dataLabel}${Math.floor(i / chunkSize) + 1}`;
        const docData = { [dataLabel]: chunk };
        await admin.firestore().collection('aggregated_data').doc(docName).set(docData);
    }
}
