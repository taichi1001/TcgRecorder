import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/provider/record_list_view_provider.dart';
import 'package:tcg_manager/selector/sorted_record_list_selector.dart';

final filterRecordListProvider = FutureProvider.autoDispose<List<Record>>((ref) async {
  final recordList = await ref.watch(sortedRecordListProvider.future);
  final filter = ref.watch(recordListViewNotifierProvider);

  var filterdList = recordList;

  if (filter.startDate != null) {
    filterdList = filterdList.where((record) {
      final compareDate = DateTime(record.date!.year, record.date!.month, record.date!.day);
      if (compareDate.isAtSameMomentAs(filter.startDate!) || compareDate.isAfter(filter.startDate!)) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  if (filter.endDate != null) {
    filterdList = filterdList.where((record) {
      final compareDate = DateTime(record.date!.year, record.date!.month, record.date!.day);
      if (compareDate.isAtSameMomentAs(filter.endDate!) || compareDate.isBefore(filter.endDate!)) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  if (filter.startTime != null && filter.endTime != null) {
    filterdList = filterdList.where((record) {
      final recordDate = record.date;
      final compareDate = DateTime(1994, 10, 1, recordDate!.hour, recordDate.minute);
      final startResult = compareDate.compareTo(filter.startTime!);
      final endResult = compareDate.compareTo(filter.endTime!);
      if ((startResult == 1 || startResult == 0) && (endResult == -1 || endResult == 0)) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  if (filter.useDeck != null) {
    filterdList = filterdList.where((record) => record.useDeckId == filter.useDeck!.id).toList();
  }

  if (filter.opponentDeck != null) {
    filterdList = filterdList.where((record) => record.opponentDeckId == filter.opponentDeck!.id).toList();
  }

  if (filter.tagList.isNotEmpty) {
    List<Record> newFilterdList = [];
    for (final record in filterdList) {
      List<bool> judgeList = [];
      for (final tag in filter.tagList) {
        var i = 0;
        for (final tagId in record.tagId) {
          if (tagId == tag.id) {
            judgeList.add(true);
            break;
          } else {
            i++;
            if (i == record.tagId.length) {
              judgeList.add(false);
            }
          }
        }
      }
      if (judgeList.toSet().toList().length == 1 && judgeList.toSet().toList()[0]) {
        newFilterdList.add(record);
      }
    }
    filterdList = newFilterdList;
  }
  return filterdList;
});
