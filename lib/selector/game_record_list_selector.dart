import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/selector/sorted_record_list_selector.dart';

final gameRecordListProvider = StateProvider.autoDispose<List<Record>>((ref) {
  final selectGame = ref.watch(selectGameNotifierProvider).selectGame;
  final sortedRecordList = ref.watch(sortedRecordListProvider);
  final gameRecordList = sortedRecordList.where((record) => record.gameId! == selectGame!.gameId).toList();
  return gameRecordList;
});
