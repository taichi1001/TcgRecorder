import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/domain_data.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/repository/firestore_public_game_repository.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';
import 'package:tcg_manager/selector/recently_use_deck_selector.dart';
import 'package:tcg_manager/selector/recently_use_tag_selector.dart';
import 'package:tcg_manager/selector/search_deck_list_selector.dart';
import 'package:tcg_manager/selector/search_game_list_selector.dart';
import 'package:tcg_manager/selector/search_tag_list_selector.dart';
import 'package:tcg_manager/selector/sorted_deck_list_selector.dart';
import 'package:tcg_manager/selector/sorted_game_list_selector.dart';
import 'package:tcg_manager/selector/sorted_tag_list_selector.dart';

class SelectDomainViewInfo {
  const SelectDomainViewInfo({
    required this.gameDomainDataList,
    required this.searchDomainDataList,
    required this.recentlyUseDomainDataList,
    required this.publicGameDomainDataList,
    required this.hostGameList,
    required this.guestGameList,
  });

  final List<DomainData> gameDomainDataList;
  final List<DomainData> searchDomainDataList;
  final List<DomainData> recentlyUseDomainDataList;
  final List<DomainData> publicGameDomainDataList;
  final List<Game> hostGameList;
  final List<Game> guestGameList;
}

final selectDomainViewInfoProvider = FutureProvider.autoDispose.family<SelectDomainViewInfo, DomainDataType>((ref, dataType) async {
  switch (dataType) {
    case DomainDataType.game:
      final gameList = await ref.watch(sortedGameListProvider.future);
      final searchGameList = await ref.watch(searchGameListProvider.future);
      final hostShareList = await ref.watch(hostShareProvider.future);
      final hostShareGameList = hostShareList.map((e) => e.game).toList();
      final guestShareList = await ref.watch(guestShareProvider.future);
      final guestShareGameList = guestShareList.map((e) => e.game).toList();
      final publicGameList = await ref.watch(publicGameListProvider.future);
      return SelectDomainViewInfo(
        gameDomainDataList: gameList,
        searchDomainDataList: searchGameList,
        recentlyUseDomainDataList: [],
        publicGameDomainDataList: publicGameList,
        hostGameList: hostShareGameList,
        guestGameList: guestShareGameList,
      );
    case DomainDataType.deck:
      final gameDeckList = await ref.watch(sortedDeckListProvider.future);
      final searchDeckList = await ref.watch(searchDeckListProvider.future);
      final recentlyUseDeckList = await ref.watch(recentlyUseDeckProvider.future);
      return SelectDomainViewInfo(
        gameDomainDataList: gameDeckList,
        searchDomainDataList: searchDeckList,
        recentlyUseDomainDataList: recentlyUseDeckList,
        publicGameDomainDataList: [],
        hostGameList: [],
        guestGameList: [],
      );
    case DomainDataType.tag:
      final gameTagList = await ref.watch(sortedTagListProvider.future);
      final searchTagList = await ref.watch(searchTagListProvider.future);
      final recentlyUseTagList = await ref.watch(recentlyUseTagProvider.future);
      return SelectDomainViewInfo(
        gameDomainDataList: gameTagList,
        searchDomainDataList: searchTagList,
        recentlyUseDomainDataList: recentlyUseTagList,
        publicGameDomainDataList: [],
        hostGameList: [],
        guestGameList: [],
      );

    default:
      return const SelectDomainViewInfo(
        gameDomainDataList: [],
        searchDomainDataList: [],
        recentlyUseDomainDataList: [],
        publicGameDomainDataList: [],
        hostGameList: [],
        guestGameList: [],
      );
  }
});
