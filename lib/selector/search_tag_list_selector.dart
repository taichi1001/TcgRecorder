import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/provider/select_domain_data_view_provider.dart';
import 'package:tcg_manager/selector/game_tag_list_selector.dart';

final searchTagListProvider = FutureProvider.autoDispose<List<Tag>>((ref) async {
  final tagList = await ref.watch(gameTagListProvider.future);
  final searchText = ref.watch(selectDomainDataViewNotifierProvider(DomainDataType.tag).select((value) => value.searchText));
  if (searchText == '') return [];
  final result = tagList.where((tag) => tag.name.contains(searchText)).toList();
  return result;
});
