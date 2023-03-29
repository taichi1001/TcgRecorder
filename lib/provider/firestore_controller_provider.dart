import 'package:hooks_riverpod/hooks_riverpod.dart';

final firestoreControllerProvider = Provider.autoDispose<FirestoreController>((ref) => FirestoreController(ref));

/// Firesore全般の処理や、複数ドキュメントにまたがる処理を行うクラス
class FirestoreController {
  FirestoreController(this.ref);

  final Ref ref;

  // TODO 共有データ初期化用関数作成

  // TODO 共有データ全削除用関数作成

  // TODO counter操作用関数委譲してくる
}
