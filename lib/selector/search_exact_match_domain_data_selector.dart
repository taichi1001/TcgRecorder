
import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/domain_data.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/provider/select_domain_data_view_provider.dart';
import 'package:tcg_manager/selector/search_deck_list_selector.dart';
import 'package:tcg_manager/selector/search_tag_list_selector.dart';

final searchExactMatchDomainDataProvider = FutureProvider.autoDispose.family<DomainData?, DomainDataType>((ref, dataType) async {
  switch (dataType) {
    case DomainDataType.game:
      return null;
    case DomainDataType.deck:
      final deckList = await ref.watch(searchDeckListProvider.future);
      final searchText = ref.watch(selectDomainDataViewNotifierProvider(dataType).select((value) => value.searchText));
      if (searchText == '') return null;
      return deckList.where((deck) => deck.name == searchText).toList().firstOrNull;
    case DomainDataType.tag:
      final tagList = await ref.watch(searchTagListProvider.future);
      final searchText = ref.watch(selectDomainDataViewNotifierProvider(dataType).select((value) => value.searchText));
      if (searchText == '') return null;
      return tagList.where((tag) => tag.name == searchText).toList().firstOrNull;
    default:
      return null;
  }
});
