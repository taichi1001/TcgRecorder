import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

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

  shareSnapshot.docs.forEach((doc) => {
    if (doc.id.includes(uid)) {
      batch.delete(doc.ref);
    }
  });

  for (const doc of shareDataSnapshot.docs) {
    if (doc.id.includes(uid)) {
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