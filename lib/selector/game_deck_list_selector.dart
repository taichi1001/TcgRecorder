import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/selector/game_share_data_selector.dart';

final gameDeckListProvider = Provider.autoDispose<AsyncValue<List<Deck>>>((ref) {
  ref.keepAlive();
  final selectGame = ref.watch(selectGameNotifierProvider.select((value) => value.selectGame));
  if (selectGame == null) return const AsyncValue.data([]);
  if (selectGame.isShare) {
    return ref.watch(gameDeckListStreamProvider);
  } else {
    return ref.watch(gameDeckListFutureProvider);
  }
});

final gameDeckListFutureProvider = FutureProvider.autoDispose<List<Deck>>((ref) async {
  final selectGame = ref.watch(selectGameNotifierProvider.select((value) => value.selectGame));
  final allDeckList = await ref.watch(allDeckListProvider.future);
  if (selectGame == null) return [];
  final gameDeckList = allDeckList.where((deck) => deck.gameId! == selectGame.id).toList();
  return gameDeckList;
});

final gameDeckListStreamProvider = StreamProvider.autoDispose<List<Deck>>((ref) async* {
  final shareData = await ref.watch(gameShareDataStreamProvider.future);
  yield shareData == null ? [] : shareData.deckList;
});

final currentGameDeckListProvider = FutureProvider.family.autoDispose<List<Deck>, Game>((ref, selectGame) async {
  final allDeckList = await ref.watch(allDeckListProvider.future);
  return allDeckList.where((deck) => deck.gameId! == selectGame.id).toList();
});
