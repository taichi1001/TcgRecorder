import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/provider/select_deck_view_provider.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';

final searchDeckListProvider = FutureProvider.autoDispose<List<Deck>>((ref) async {
  final deckList = await ref.watch(gameDeckListProvider.future);
  final searchText = ref.watch(selectDeckViewNotifierProvider.select((value) => value.searchText));
  if (searchText == '') return [];
  final result = deckList.where((deck) => deck.deck.contains(searchText)).toList();
  return result;
});