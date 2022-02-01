import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/entity/record.dart';

part 'game_record_list_state.freezed.dart';

@freezed
abstract class GameRecordListState with _$GameRecordListState {
  factory GameRecordListState({
    List<Record>? gameRecordList,
  }) = _GameRecordListState;
}
