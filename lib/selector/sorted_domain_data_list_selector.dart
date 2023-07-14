import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/domain_data.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/selector/sorted_deck_list_selector.dart';
import 'package:tcg_manager/selector/sorted_game_list_selector.dart';
import 'package:tcg_manager/selector/sorted_tag_list_selector.dart';

final sortedDomainDataListProvider = FutureProvider.autoDispose.family<List<DomainData>, DomainDataType>((ref, dataType) async {
  switch (dataType) {
    case DomainDataType.game:
      return await ref.watch(sortedGameListProvider.future);
    case DomainDataType.deck:
      return await ref.watch(sortedDeckListProvider.future);
    case DomainDataType.tag:
      return await ref.watch(sortedTagListProvider.future);
    default:
      return [];
  }
});
