import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/state/input_view_state.dart';

part 'marged_record.freezed.dart';

@freezed
class MargedRecord with _$MargedRecord {
  factory MargedRecord({
    required int recordId,
    required String game,
    @Default('分類無し') String? tag,
    required String useDeck,
    required String opponentDeck,
    required DateTime date,
    required FirstSecond firstSecond,
    required WinLoss winLoss,
    String? memo,
  }) = _MargedRecord;
}
