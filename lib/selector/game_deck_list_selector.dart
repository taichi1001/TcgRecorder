import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';

final gameDeckListProvider = FutureProvider.autoDispose<List<Deck>>((ref) async {
  final selectGame = ref.watch(selectGameNotifierProvider.select((value) => value.selectGame));
  final allDeckList = await ref.watch(allDeckListProvider.future);
  if (selectGame == null) return [];
  final gameDeckList = allDeckList.where((deck) => deck.gameId! == selectGame.id).toList();
  return gameDeckList;
});

final currentGameDeckListProvider = FutureProvider.family.autoDispose<List<Deck>, Game>((ref, selectGame) async {
  final allDeckList = await ref.watch(allDeckListProvider.future);
  return allDeckList.where((deck) => deck.gameId! == selectGame.id).toList();
});
