import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';

part 'record.freezed.dart';
part 'record.g.dart';

@freezed
class Record with _$Record {
  factory Record({
    @JsonKey(name: 'record_id') int? recordId,
    @JsonKey(name: 'game_id') int? gameId,
    @JsonKey(name: 'tag_id') int? tagId,
    @JsonKey(name: 'use_deck_id') int? useDeckId,
    @JsonKey(name: 'opponent_deck_id') int? opponentDeckId,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) DateTime? date,
    @Default(FirstSecond.first)
    @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson, name: 'first_second')
        FirstSecond firstSecond,
    @Default(WinLoss.win) @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson, name: 'win_loss') WinLoss winLoss,
    String? memo,
  }) = _Record;
  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
}

FirstSecond _firstSecondFromJson(int value) {
  return value == 1 ? FirstSecond.first : FirstSecond.second;
}

int _firstSecondToJson(FirstSecond value) {
  return value == FirstSecond.first ? 1 : 0;
}

WinLoss _winLossFromJson(int value) {
  switch (value) {
    case 0:
      return WinLoss.loss;
    case 1:
      return WinLoss.win;
    case 2:
      return WinLoss.draw;
    default:
      throw Exception();
  }
}

int _winLossToJson(WinLoss value) {
  switch (value) {
    case WinLoss.loss:
      return 0;
    case WinLoss.win:
      return 1;
    case WinLoss.draw:
      return 2;

    default:
      throw Exception();
  }
}

DateTime _dateTimeFromJson(String value) {
  return DateTime.parse(value).toLocal();
}

String _dateTimeToJson(DateTime? value) {
  if (value == null) {
    return DateTime.now().toUtc().toIso8601String();
  }
  return value.toUtc().toIso8601String();
}
