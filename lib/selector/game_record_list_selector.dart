import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/selector/game_share_data_selector.dart';

final gameRecordListProvider = StreamProvider.autoDispose<List<Record>>((ref) async* {
  final selectGame = ref.watch(selectGameNotifierProvider).selectGame;
  if (selectGame == null) yield const [];
  if (selectGame!.isShare) {
    yield await ref.watch(gameRecordListStreamProvider.future);
  } else {
    yield await ref.watch(gameRecordListFutureProvider.future);
  }
});

final gameRecordListFutureProvider = FutureProvider.autoDispose<List<Record>>((ref) async {
  final selectGame = ref.watch(selectGameNotifierProvider).selectGame;
  if (selectGame == null) return [];
  final allRecordList = await ref.watch(allRecordListProvider.future);
  final gameRecordList = allRecordList.where((record) => record.gameId! == selectGame.id).toList();
  return gameRecordList;
});

final gameRecordListStreamProvider = StreamProvider.autoDispose<List<Record>>((ref) async* {
  final shareData = await ref.watch(gameShareDataRecordStreamProvider.future);
  yield shareData ?? [];
});
