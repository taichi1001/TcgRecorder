import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';

final gameDeckListProvider = StateProvider<List<Deck>>((ref) {
  final selectGame = ref.watch(selectGameNotifierProvider).selectGame;
  final allDeckList = ref.watch(allDeckListNotifierProvider).allDeckList;
  final gameDeckList = allDeckList?.where((deck) => deck.gameId! == selectGame!.gameId).toList();

  if (gameDeckList != null) return gameDeckList;
  return List.empty();
});
