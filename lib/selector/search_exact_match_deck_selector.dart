import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/provider/select_deck_view_provider.dart';
import 'package:tcg_manager/selector/search_deck_list_selector.dart';

final searchExactMatchDeckProvider = FutureProvider.autoDispose<Deck?>((ref) async {
  final deckList = await ref.watch(searchDeckListProvider.future);
  final searchText = ref.watch(selectDeckViewNotifierProvider.select((value) => value.searchText));
  if (searchText == '') return null;
  final result = deckList.where((deck) => deck.deck == searchText).toList().firstOrNull;
  return result;
});
