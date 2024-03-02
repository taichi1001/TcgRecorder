import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';

// firebase-adminの初期化
admin.initializeApp();

// 監視: deleted_usersコレクションにドキュメントが追加された場合
export const onDeleteUser = functions
  .region('asia-northeast1')
  .firestore.document("deleted_users/{docId}")
  .onCreate(async (snap, context) => {
    const deleteDocument = snap.data();
    const uid = deleteDocument.uid;

    // Firebase Authからユーザーを削除する
    await admin.auth().deleteUser(uid);

    // shareコレクション内のドキュメント名にuidを含むドキュメントを削除する
    const shareSnapshot = await admin.firestore().collection("share").get();
    const shareDataSnapshot = await admin.firestore().collection("share_data").get();
    const countersDocSnapshot = await admin.firestore().collection("counters").get();
    const batch = admin.firestore().batch();

    const deletedDocumentNames: string[] = [];
    shareSnapshot.docs.forEach((doc) => {
      if (doc.data().author_name == uid) {
        batch.delete(doc.ref);
        deletedDocumentNames.push(doc.id);
      }
    });

    for (const doc of shareDataSnapshot.docs) {
      if (deletedDocumentNames.includes(doc.id)) {
        // サブコレクションを削除する
        const subcollections = await doc.ref.listCollections();
        for (const subcollection of subcollections) {
          const subcollectionSnapshot = await subcollection.get();
          subcollectionSnapshot.docs.forEach((subDoc) => {
            batch.delete(subDoc.ref);
          });
        }

        // ドキュメントを削除する
        batch.delete(doc.ref);
      }
    }

    countersDocSnapshot.docs.forEach((doc) => {
      if (doc.id.includes(uid)) {
        batch.delete
        batch.delete(doc.ref);
      }
    });

    await batch.commit();

    const bucket = admin.storage().bucket();

    // users/{uid}フォルダの削除
    const userFolderPath = `user/${uid}`;
    const [userFiles] = await bucket.getFiles({ prefix: userFolderPath });
    const userDeletePromises = userFiles.map(file => file.delete());

    // user_profile/{uid}フォルダの削除
    const userProfileFolderPath = `user_profile/${uid}`;
    const [userProfileFiles] = await bucket.getFiles({ prefix: userProfileFolderPath });
    const userProfileDeletePromises = userProfileFiles.map(file => file.delete());

    // share/{uid}-*フォルダの削除
    const [allFiles] = await bucket.getFiles();
    const shareFiles = allFiles.filter(file => {
      const folderPath = file.name.split('/').slice(0, -1).join('/');
      return folderPath.startsWith(`share_data/${uid}-`);
    });

    const shareDeletePromises = shareFiles.map(file => file.delete());

    // 両方のフォルダの削除を待つ
    await Promise.all([...userDeletePromises, ...userProfileDeletePromises, ...shareDeletePromises]);
  });


// 午前4時に全てのユーザーのデータを集計する
export const aggregateUserData = functions.region('asia-northeast1').pubsub.schedule('0 4 * * *').timeZone('Asia/Tokyo').onRun(async () => {
  // ステップ1: 全ユーザーのデータを取得
  const allUserData: any[] = [];
  const userSnapshots = await admin.firestore().collection('public_user_data').get();
  userSnapshots.forEach(doc => {
    allUserData.push(doc.data());
  });

  // ステップ2: 一意なゲームとデッキのマップ作成
  const gameMap: { [key: string]: number } = {};
  let gameId = 0;
  const deckMap: { [key: string]: number } = {};
  let deckId = 0;

  for (const userData of allUserData) {
    for (const game of userData['gameList']) {
      if (!gameMap.hasOwnProperty(game['name'])) {
        gameMap[game['name']] = gameId++;
      }
    }
    for (const deck of userData['deckList']) {
      const uniqueKey = deck['name'] + deck['game_id'];
      if (!deckMap.hasOwnProperty(uniqueKey)) {
        deckMap[uniqueKey] = deckId++;
      }
    }
  }

  // ステップ3: 集計
  const aggregatedGames: any[] = [];
  const aggregatedDecks: any[] = [];
  const aggregatedRecords: any[] = [];
  let recordId = 0;

  for (const userData of allUserData) {
    for (const game of userData['gameList']) {
      if (!aggregatedGames.some(item => item['name'] === game['name'])) {
        aggregatedGames.push({ 'id': gameMap[game['name']], 'name': game['name'] });
      }
    }

    const userDeckMap: { [key: number]: number } = {};
    for (const deck of userData['deckList']) {
      const gameIdx = gameMap[userData['gameList'][deck['game_id']]['name']];
      const existingDeck = aggregatedDecks.find(item => item['name'] === deck['name'] && item['game_id'] === gameIdx);

      if (existingDeck) {
        userDeckMap[deck['id']] = existingDeck['id'];
      } else {
        const newId = deckId++;
        userDeckMap[deck['id']] = newId;
        aggregatedDecks.push({ 'id': newId, 'game_id': gameIdx, 'name': deck['name'] });
      }
    }

    for (const record of userData['recordList']) {
      aggregatedRecords.push({
        'id': recordId++,
        'gameId': gameMap[userData['gameList'][record['gameId']]['name']],
        'userDeckId': userDeckMap[record['useDeckId']],
        'opponentDeckId': userDeckMap[record['opponentDeckId']],
      });
    }
  }

  // ステップ4: 集計データをFirestoreに保存
  await admin.firestore().collection('aggregated_data').doc('result').set({
    'gameList': aggregatedGames,
    'deckList': aggregatedDecks,
    'recordList': aggregatedRecords,
  });

  console.log('Aggregation completed');
});