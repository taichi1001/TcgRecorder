import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/firestore_share.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/repository/firestore_share_data_repository.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';

// share_dataのrecordを監視するStream
final gameShareDataDeckStreamProvider = StreamProvider.autoDispose((ref) async* {
  final selectFirestoreShare = await ref.watch(gameFirestoreShareStreamProvider.future);
  if (selectFirestoreShare == null) {
    yield null;
  } else {
    final shareData = await ref.watch(firestoreShareDataDeckProvider(selectFirestoreShare.docName).future);
    yield shareData;
  }
});

// share_dataのrecordを監視するStream
final gameShareDataTagStreamProvider = StreamProvider.autoDispose((ref) async* {
  final selectFirestoreShare = await ref.watch(gameFirestoreShareStreamProvider.future);
  if (selectFirestoreShare == null) {
    yield null;
  } else {
    final shareData = await ref.watch(firestoreShareDataTagProvider(selectFirestoreShare.docName).future);
    yield shareData;
  }
});

// share_dataのrecordを監視するStream
final gameShareDataRecordStreamProvider = StreamProvider.autoDispose((ref) async* {
  final selectFirestoreShare = await ref.watch(gameFirestoreShareStreamProvider.future);
  if (selectFirestoreShare == null) {
    yield null;
  } else {
    final shareData = await ref.watch(firestoreShareDataRecordProvider(selectFirestoreShare.docName).future);
    yield shareData;
  }
});

final gameFirestoreShareStreamProvider = StreamProvider.autoDispose<FirestoreShare?>((ref) async* {
  final selectGame = ref.watch(selectGameNotifierProvider).selectGame;
  if (selectGame == null || !selectGame.isShare) {
    yield null;
  } else {
    final hostGameList = await ref.watch(hostShareProvider.future);
    final guestGameList = await ref.watch(guestShareProvider.future);
    final shareGameList = [...hostGameList, ...guestGameList];
    // TODO ローカルDBのゲームにpublic_game_idを追加したことが原因で、shareにあるgameと不整合が起こっているため修正必要
    // とりあえずfirestore側のデータを修正して対応した。
    yield shareGameList.firstWhereOrNull((element) => element.game == selectGame);
  }
});

final isShareGame = Provider.autoDispose<bool>((ref) {
  final isShare = ref.watch(selectGameNotifierProvider.select((value) => value.selectGame?.isShare));
  return (isShare == null || !isShare) ? false : true;
});
