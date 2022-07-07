import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';

final gameTagListProvider = FutureProvider.autoDispose<List<Tag>>((ref) async {
  final selectGame = ref.watch(selectGameNotifierProvider).selectGame;
  final allTagList = await ref.watch(allTagListProvider.future);
  final gameTagList = allTagList.where((tag) => tag.gameId! == selectGame!.gameId).toList();

  return gameTagList;
});
