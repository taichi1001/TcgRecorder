import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/enum/sort.dart';
import 'package:tcg_manager/provider/record_list_view_provider.dart';
import 'package:tcg_manager/selector/game_record_list_selector.dart';
import 'package:tcg_manager/selector/game_share_data_selector.dart';

final sortedRecordListProvider = FutureProvider.autoDispose<List<Record>>((ref) async {
  final recordList = await ref.watch(gameRecordListProvider.future);
  final sort = ref.watch(recordListViewNotifierProvider.select((value) => value.sort));
  if (sort == Sort.oldest) {
    recordList.sort((a, b) {
      int result = a.date!.compareTo(b.date!);
      if (result == 0) {
        result = a.id!.compareTo(b.id!);
      }
      return result;
    });
  } else if (sort == Sort.newest) {
    recordList.sort((a, b) {
      int result = -a.date!.compareTo(b.date!);
      if (result == 0) {
        result = -a.id!.compareTo(b.id!);
      }
      return result;
    });
  }
  return recordList;
});

final sortedRecordListStreamProvider = StreamProvider.autoDispose<List<Record>>((ref) async* {
  final recordList = await ref.watch(gameShareDataRecordStreamProvider.future);
  final sort = ref.watch(recordListViewNotifierProvider.select((value) => value.sort));
  if (recordList == null) {
    yield [];
  }
  if (sort == Sort.oldest) {
    recordList!.sort((a, b) {
      int result = a.date!.compareTo(b.date!);
      if (result == 0) {
        result = a.id!.compareTo(b.id!);
      }
      return result;
    });
  } else if (sort == Sort.newest) {
    recordList!.sort((a, b) {
      int result = -a.date!.compareTo(b.date!);
      if (result == 0) {
        result = -a.id!.compareTo(b.id!);
      }
      return result;
    });
  }
  yield recordList!;
});
