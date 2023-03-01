import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/enum/sort.dart';
import 'package:tcg_manager/provider/select_domain_data_view_provider.dart';
import 'package:tcg_manager/selector/game_tag_list_selector.dart';

final sortedTagListProvider = FutureProvider.autoDispose<List<Tag>>((ref) async {
  final tagList = await ref.watch(gameTagListProvider.future);
  final sort = ref.watch(selectDomainDataViewNotifierProvider(DomainDataType.tag).select((value) => value.sortType));
  if (sort == Sort.oldest) {
    tagList.sort((a, b) => a.id!.compareTo(b.id!));
  } else if (sort == Sort.newest) {
    tagList.sort((a, b) => -a.id!.compareTo(b.id!));
  } else if (sort == Sort.custom) {
    tagList.sort((a, b) {
      if (a.sortIndex == null) return -1;
      if (b.sortIndex == null) return -1;
      return a.sortIndex!.compareTo(b.sortIndex!);
    });
  }
  return tagList;
});
