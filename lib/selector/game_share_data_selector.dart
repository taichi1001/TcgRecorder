import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/firestore_share.dart';
import 'package:tcg_manager/entity/firestore_share_data.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/repository/firestore_share_data_repository.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';

final gameShareDataStreamProvider = StreamProvider.autoDispose<FirestoreShareData?>((ref) async* {
  final selectFirestoreShare = await ref.watch(gameFirestoreShareStreamProvider.future);
  if (selectFirestoreShare == null) {
    yield null;
  } else {
    final shareData = await ref.watch(firestoreShareDataProvider(selectFirestoreShare.docName).future);
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
    yield shareGameList.firstWhere((element) => element.game == selectGame);
  }
});

final isShareGame = Provider.autoDispose<bool>((ref) {
  final isShare = ref.watch(selectGameNotifierProvider.select((value) => value.selectGame?.isShare));
  return (isShare == null || !isShare) ? false : true;
});
