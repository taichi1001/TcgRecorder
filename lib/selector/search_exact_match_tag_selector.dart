import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/provider/select_tag_view_provider.dart';
import 'package:tcg_manager/selector/search_tag_list_selector.dart';

final searchExactMatchTagProvider = FutureProvider.autoDispose<Tag?>((ref) async {
  final tagList = await ref.watch(searchTagListProvider.future);
  final searchText = ref.watch(selectTagViewNotifierProvider.select((value) => value.searchText));
  if (searchText == '') return null;
  final result = tagList.where((tag) => tag.tag == searchText).toList().firstOrNull;
  return result;
});
