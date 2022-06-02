import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/enum/Sort.dart';
import 'package:tcg_manager/provider/record_list_view_provider.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';

final sortedRecordListProvider = StateProvider.autoDispose<List<Deck>>((ref) {
  final deckList = ref.watch(gameDeckListProvider);
  final sort = ref.watch(recordListViewNotifierProvider.select((value) => value.sort));

  if (sort == Sort.oldest) {
    deckList.sort((a, b) => a.deckId!.compareTo(b.deckId!));
  } else if (sort == Sort.newest) {
    deckList.sort((a, b) => -a.deckId!.compareTo(b.deckId!));
  }
  return deckList;
});
