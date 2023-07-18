import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/selector/game_share_data_selector.dart';

final gameTagListProvider = StreamProvider.autoDispose<List<Tag>>((ref) async* {
  ref.keepAlive();
  final selectGame = ref.watch(selectGameNotifierProvider).selectGame;
  if (selectGame == null) yield [];
  if (selectGame!.isShare) {
    yield await ref.watch(gameTagListStreamProvider.future);
  } else {
    yield await ref.watch(gameTagListFutureProvider.future);
  }
});

final gameTagListFutureProvider = FutureProvider.autoDispose<List<Tag>>((ref) async {
  final selectGame = ref.watch(selectGameNotifierProvider).selectGame;
  final allTagList = await ref.watch(allTagListProvider.future);
  if (selectGame == null) return [];
  final gameTagList = allTagList.where((tag) => tag.gameId! == selectGame.id).toList();
  return gameTagList;
});

final gameTagListStreamProvider = StreamProvider.autoDispose<List<Tag>>((ref) async* {
  final shareData = await ref.watch(gameShareDataTagStreamProvider.future);
  yield shareData ?? [];
});

final currentTagDeckListProvider = FutureProvider.family.autoDispose<List<Tag>, Game>((ref, selectTag) async {
  final allTagList = await ref.watch(allTagListProvider.future);
  return allTagList.where((tag) => tag.gameId! == selectTag.id).toList();
});
