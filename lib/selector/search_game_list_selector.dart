import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/select_domain_data_view_provider.dart';

final searchGameListProvider = FutureProvider.autoDispose<List<Game>>((ref) async {
  final gameList = await ref.watch(allGameListProvider.future);
  final searchText = ref.watch(selectDomainDataViewNotifierProvider(DomainDataType.game).select((value) => value.searchText));
  if (searchText == '') return [];
  final result = gameList.where((game) => game.name.contains(searchText)).toList();
  return result;
});
