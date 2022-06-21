import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/enum/sort.dart';
import 'package:tcg_manager/provider/select_deck_view_provider.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';

final sortedRecordListProvider = StateProvider.autoDispose<List<Deck>>((ref) {
  final deckList = ref.watch(gameDeckListProvider);
  final sort = ref.watch(selectDeckViewNotifierProvider.select((value) => value.sortType));
  if (sort == Sort.oldest) {
    deckList.sort((a, b) => a.deckId!.compareTo(b.deckId!));
  } else if (sort == Sort.newest) {
    deckList.sort((a, b) => -a.deckId!.compareTo(b.deckId!));
  }
  return deckList;
});
