import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/selector/game_share_data_selector.dart';
import 'package:tcg_manager/selector/sorted_record_list_selector.dart';

final gameRecordListProvider = Provider.autoDispose<AsyncValue<List<Record>>>((ref) {
  final selectGame = ref.watch(selectGameNotifierProvider).selectGame;
  if (selectGame == null) return const AsyncValue.data([]);
  if (selectGame.isShare) {
    return ref.watch(gameRecordListStreamProvider);
  } else {
    return ref.watch(gameRecordListFutureProvider);
  }
});

final gameRecordListFutureProvider = FutureProvider.autoDispose<List<Record>>((ref) async {
  final selectGame = ref.watch(selectGameNotifierProvider).selectGame;
  if (selectGame == null) return [];
  final sortedRecordList = await ref.watch(sortedRecordListProvider.future);
  final gameRecordList = sortedRecordList.where((record) => record.gameId! == selectGame.id).toList();
  return gameRecordList;
});

final gameRecordListStreamProvider = StreamProvider.autoDispose<List<Record>>((ref) async* {
  final shareData = await ref.watch(gameShareDataRecordStreamProvider.future);
  yield shareData ?? [];
});
