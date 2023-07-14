import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/provider/select_domain_data_view_provider.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';

final searchDeckListProvider = FutureProvider.autoDispose<List<Deck>>((ref) async {
  final deckList = await ref.watch(gameDeckListProvider.future);
  final searchText = ref.watch(selectDomainDataViewNotifierProvider(DomainDataType.deck).select((value) => value.searchText));
  if (searchText == '') return [];
  final result = deckList.where((deck) => deck.name.contains(searchText)).toList();
  return result;
});
