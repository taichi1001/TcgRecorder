import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
class Game with _$Game {
  factory Game({
    @JsonKey(name: 'game_id') int? gameId,
    required String game,
    @Default(true) @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker') bool isVisibleToPicker,
  }) = _Game;
  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}

bool _boolFromJson(value) {
  return value == 0 ? false : true;
}

int _boolToJson(bool value) {
  return value ? 1 : 0;
}
