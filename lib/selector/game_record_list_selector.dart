import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/entity/record.dart';
import 'package:tcg_recorder2/provider/record_list_provider.dart';
import 'package:tcg_recorder2/provider/select_game_provider.dart';

final gameRecordListProvider = StateProvider<List<Record>>((ref) {
  final selectGame = ref.watch(selectGameNotifierProvider).selectGame;
  final allRecordList = ref.watch(allRecordListNotifierProvider).allRecordList;
  final gameRecordList =
      allRecordList?.where((record) => record.gameId! == selectGame!.gameId).toList();

  if (gameRecordList != null) return gameRecordList;
  return List.empty();
});
