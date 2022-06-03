import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/enum/Sort.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/record_list_view_provider.dart';

final sortedRecordListProvider = StateProvider.autoDispose<List<Record>>((ref) {
  final recordList = ref.watch(allRecordListNotifierProvider).allRecordList;
  final sort = ref.watch(recordListViewNotifierProvider.select((value) => value.sort));
  if (sort == Sort.oldest) {
    recordList!.sort((a, b) {
      int result = a.date!.compareTo(b.date!);
      if (result == 0) {
        result = a.recordId!.compareTo(b.recordId!);
      }
      return result;
    });
  } else if (sort == Sort.newest) {
    recordList!.sort((a, b) {
      int result = -a.date!.compareTo(b.date!);
      if (result == 0) {
        result = -a.recordId!.compareTo(b.recordId!);
      }
      return result;
    });
  }
  if (recordList != null) return recordList;
  return List.empty();
});
