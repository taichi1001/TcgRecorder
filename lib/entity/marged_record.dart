import 'package:freezed_annotation/freezed_annotation.dart';

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
    required bool firstSecond,
    required bool winLoss,
    String? memo,
  }) = _MargedRecord;
}
