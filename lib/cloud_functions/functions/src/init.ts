import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';

// firebase-adminの初期化
admin.initializeApp();

export { admin, functions };