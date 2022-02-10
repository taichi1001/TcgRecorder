import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/entity/record.dart';

part 'record_list_state.freezed.dart';

@freezed
abstract class RecordListState with _$RecordListState {
  factory RecordListState({
    List<Record>? allRecordList,
    @Default(false) bool isLoaded,
  }) = _RecordListState;
}
