import 'package:freezed_annotation/freezed_annotation.dart';

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
    @Default(true)
    @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'first_second')
        bool firstSecond,
    @Default(true)
    @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'win_loss')
        bool winLoss,
    String? memo,
  }) = _Record;
  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
}

bool _boolFromJson(int value) {
  return value == 0 ? false : true;
}

int _boolToJson(bool value) {
  return value ? 1 : 0;
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
