import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';

final gameDeckListProvider = FutureProvider.autoDispose<List<Deck>>((ref) async {
  final selectGame = ref.watch(selectGameNotifierProvider).selectGame;
  final allDeckList = await ref.watch(allDeckListProvider.future);
  final gameDeckList = allDeckList.where((deck) => deck.gameId! == selectGame!.gameId).toList();

  return gameDeckList;
});
