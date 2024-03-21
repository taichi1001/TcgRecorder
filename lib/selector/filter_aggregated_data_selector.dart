import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/provider/record_list_view_provider.dart';
import 'package:tcg_manager/repository/firestore_aggregated_data_repository.dart';
import 'package:tcg_manager/state/record_list_view_state.dart';

// フィルター処理を非同期で行うための関数
Future<List<Record>> _filterRecords(List<Record> records, RecordListViewState filter) async {
  return compute(_filterRecordsIsolate, {'records': records, 'filter': filter});
}

// Isolateで実行するフィルター処理の関数
List<Record> _filterRecordsIsolate(Map<String, dynamic> params) {
  List<Record> records = params['records'];
  RecordListViewState filter = params['filter'];

  // filter.startDateとfilter.endDateを事前にDateTime型で用意
  final startDate = filter.startDate != null ? DateTime(filter.startDate!.year, filter.startDate!.month, filter.startDate!.day) : null;
  final endDate = filter.endDate != null ? DateTime(filter.endDate!.year, filter.endDate!.month, filter.endDate!.day) : null;

  // filter.startTimeとfilter.endTimeの比較用に、比較基準のDateTimeを用意
  final startTime = filter.startTime;
  final endTime = filter.endTime;

  // 全てのフィルター条件を一度のループでチェック
  var filteredList = records.where((record) {
    final recordDate = record.date!;
    final compareDate = DateTime(recordDate.year, recordDate.month, recordDate.day);
    final compareTime = DateTime(1994, 10, 1, recordDate.hour, recordDate.minute);

    // 日付のフィルタリング条件をチェック
    if (startDate != null && !(compareDate.isAtSameMomentAs(startDate) || compareDate.isAfter(startDate))) {
      return false;
    }
    if (endDate != null && !(compareDate.isAtSameMomentAs(endDate) || compareDate.isBefore(endDate))) {
      return false;
    }

    // 時間のフィルタリング条件をチェック
    if (startTime != null && endTime != null) {
      final startResult = compareTime.compareTo(startTime);
      final endResult = compareTime.compareTo(endTime);
      if (!(startResult >= 0 && endResult <= 0)) {
        return false;
      }
    }

    return true;
  }).toList();

  return filteredList;
}

final filterAggregatedDataProvider = FutureProvider.family.autoDispose<AggregatedData, int>((ref, id) async {
  final aggregatedData = await ref.watch(aggregatedDataProvider(id).future);
  final filter = ref.watch(recordListViewNotifierProvider);

  // フィルター処理を非同期で実行
  final filteredList = await _filterRecords(aggregatedData.records, filter);

  return AggregatedData(decks: aggregatedData.decks, tags: aggregatedData.tags, records: filteredList);
});
