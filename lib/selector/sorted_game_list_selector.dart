import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/enum/sort.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/select_domain_data_view_provider.dart';

final sortedGameListProvider = FutureProvider.autoDispose<List<Game>>((ref) async {
  final gameList = await ref.watch(allGameListProvider.future);
  final sort = ref.watch(selectDomainDataViewNotifierProvider(DomainDataType.game).select((value) => value.sortType));
  if (sort == Sort.oldest) {
    gameList.sort((a, b) => a.id!.compareTo(b.id!));
  } else if (sort == Sort.newest) {
    gameList.sort((a, b) => -a.id!.compareTo(b.id!));
  } else if (sort == Sort.custom) {
    gameList.sort((a, b) {
      if (a.sortIndex == null) return -1;
      if (b.sortIndex == null) return -1;
      return a.sortIndex!.compareTo(b.sortIndex!);
    });
  }
  return gameList;
});
