import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/repository/firestore_share_data_repository.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';

final firestoreControllerProvider = Provider.autoDispose<FirestoreController>((ref) => FirestoreController(ref));

/// Firesore全般の処理や、複数ドキュメントにまたがる処理を行うクラス
class FirestoreController {
  FirestoreController(this.ref);

  final Ref ref;

  Future initShareGame(Game game, String user) async {
    final shareRepository = ref.read(firestoreShareRepository);
    final shareDataRepository = ref.read(firestoreShareDataRepository);
    await shareRepository.initGame(game, user);
    await shareDataRepository.initGame(game, user);
  }

  Future deleteShareGame(String shareDocName) async {
    final shareRepository = ref.read(firestoreShareRepository);
    final shareDataRepository = ref.read(firestoreShareDataRepository);
    await shareRepository.deleteShare(shareDocName);
    await shareDataRepository.deleteShareData(shareDocName);
    await _deleteAllImage(shareDocName);
  }

  Future _deleteAllImage(String docName) async {
    final firebaseRef = FirebaseStorage.instance.ref().child('share_data/$docName');
    final list = await firebaseRef.listAll();
    for (final item in list.items) {
      await item.delete();
    }
  }
}
