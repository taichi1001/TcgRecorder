import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/provider/select_tag_view_provider.dart';
import 'package:tcg_manager/selector/game_tag_list_selector.dart';

final searchTagListProvider = FutureProvider.autoDispose<List<Tag>>((ref) async {
  final tagList = await ref.watch(gameTagListProvider.future);
  final searchText = ref.watch(selectTagViewNotifierProvider.select((value) => value.searchText));
  if (searchText == '') return [];
  final result = tagList.where((tag) => tag.tag.contains(searchText)).toList();
  return result;
});
