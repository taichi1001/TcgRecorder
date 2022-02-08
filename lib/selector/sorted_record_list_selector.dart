import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/record_sort_provider.dart';
import 'package:tcg_manager/state/record_sort_state.dart';

final sortedRecordListProvider = StateProvider<List<Record>>((ref) {
  final recordList = ref.watch(allRecordListNotifierProvider).allRecordList;
  final order = ref.watch(recordSortNotifierProvider.select((value) => value.order));
  final sort = ref.watch(recordSortNotifierProvider.select((value) => value.sort));

  if (sort == Sort.date) {
    if (order == Order.descending) {
      recordList!.sort((a, b) {
        int result = a.date!.compareTo(b.date!);
        if (result == 0) {
          result = a.recordId!.compareTo(b.recordId!);
        }
        return result;
      });
    } else if (order == Order.ascending) {
      recordList!.sort((a, b) {
        int result = -a.date!.compareTo(b.date!);
        if (result == 0) {
          result = -a.recordId!.compareTo(b.recordId!);
        }
        return result;
      });
    }
  }
  if (recordList != null) return recordList;
  return List.empty();
});
