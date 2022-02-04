import 'package:freezed_annotation/freezed_annotation.dart';

part 'record_sort_state.freezed.dart';

enum Sort { date, save }
enum Order { ascending, descending }

@freezed
abstract class RecordSortState with _$RecordSortState {
  factory RecordSortState({
    @Default(Sort.date) Sort sort,
    @Default(Order.ascending) Order order,
  }) = _RecordSortState;
}
