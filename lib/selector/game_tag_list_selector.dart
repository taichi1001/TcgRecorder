import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';

final gameTagListProvider = StateProvider<List<Tag>>((ref) {
  final selectGame = ref.watch(selectGameNotifierProvider).selectGame;
  final allTagList = ref.watch(allTagListNotifierProvider).allTagList;
  final gameTagList = allTagList?.where((tag) => tag.gameId! == selectGame!.gameId).toList();

  if (gameTagList != null) return gameTagList;
  return List.empty();
});
