import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/enum/sort.dart';
import 'package:tcg_manager/provider/select_domain_data_view_provider.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';

final sortedDeckListProvider = FutureProvider.autoDispose<List<Deck>>((ref) async {
  final deckList = await ref.watch(gameDeckListProvider.future);
  final deckListCopy = [...deckList];
  final sort = ref.watch(selectDomainDataViewNotifierProvider(DomainDataType.deck).select((value) => value.sortType));
  if (sort == Sort.oldest) {
    deckListCopy.sort((a, b) => a.id!.compareTo(b.id!));
  } else if (sort == Sort.newest) {
    deckListCopy.sort((a, b) => -a.id!.compareTo(b.id!));
  } else if (sort == Sort.custom) {
    deckListCopy.sort((a, b) {
      if (a.sortIndex == null) return -1;
      if (b.sortIndex == null) return -1;
      return a.sortIndex!.compareTo(b.sortIndex!);
    });
  }
  return deckListCopy;
});
