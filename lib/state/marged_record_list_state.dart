import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/entity/marged_record.dart';

part 'marged_record_list_state.freezed.dart';

@freezed
abstract class MargedRecordListState with _$MargedRecordListState {
  factory MargedRecordListState({
    List<MargedRecord>? margedRecordList,
  }) = _MargedRecordListState;
}
