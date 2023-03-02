import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/domain_data.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/selector/recently_use_deck_selector.dart';
import 'package:tcg_manager/selector/recently_use_tag_selector.dart';
import 'package:tcg_manager/selector/search_deck_list_selector.dart';
import 'package:tcg_manager/selector/search_game_list_selector.dart';
import 'package:tcg_manager/selector/search_tag_list_selector.dart';
import 'package:tcg_manager/selector/sorted_deck_list_selector.dart';
import 'package:tcg_manager/selector/sorted_tag_list_selector.dart';

class SelectDomainViewInfo {
  const SelectDomainViewInfo({
    required this.gameDomainDataList,
    required this.searchDomainDataList,
    required this.recentlyUseDomainDataList,
  });

  final List<DomainData> gameDomainDataList;
  final List<DomainData> searchDomainDataList;
  final List<DomainData> recentlyUseDomainDataList;
}

final selectDomainViewInfoProvider = FutureProvider.autoDispose.family<SelectDomainViewInfo, DomainDataType>((ref, dataType) async {
  switch (dataType) {
    case DomainDataType.game:
      final gameList = await ref.watch(allGameListProvider.future);
      final searchGameList = await ref.watch(searchGameListProvider.future);
      // final recentlyUseTagList = await ref.watch(recentlyUseDeckProvider.future);
      return SelectDomainViewInfo(
        gameDomainDataList: gameList,
        searchDomainDataList: searchGameList,
        recentlyUseDomainDataList: [],
      );
    case DomainDataType.deck:
      final gameDeckList = await ref.watch(sortedDeckListProvider.future);
      final searchDeckList = await ref.watch(searchDeckListProvider.future);
      final recentlyUseDeckList = await ref.watch(recentlyUseDeckProvider.future);
      return SelectDomainViewInfo(
        gameDomainDataList: gameDeckList,
        searchDomainDataList: searchDeckList,
        recentlyUseDomainDataList: recentlyUseDeckList,
      );
    case DomainDataType.tag:
      final gameTagList = await ref.watch(sortedTagListProvider.future);
      final searchTagList = await ref.watch(searchTagListProvider.future);
      final recentlyUseTagList = await ref.watch(recentlyUseTagProvider.future);
      return SelectDomainViewInfo(
        gameDomainDataList: gameTagList,
        searchDomainDataList: searchTagList,
        recentlyUseDomainDataList: recentlyUseTagList,
      );

    default:
      return const SelectDomainViewInfo(
        gameDomainDataList: [],
        searchDomainDataList: [],
        recentlyUseDomainDataList: [],
      );
  }
});
