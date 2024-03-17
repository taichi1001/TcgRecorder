import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/entity/domain_data.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
class Game with _$Game implements DomainData {
  factory Game({
    @JsonKey(name: 'game_id') int? id,
    @JsonKey(name: 'game') required String name,
    @JsonKey(name: 'public_game_id') int? publicGameId,
    @Default(true) @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson) bool isVisibleToPicker,
    @Default(false) @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson) bool isShare,
    int? sortIndex,
  }) = _Game;
  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}

bool _boolFromJson(value) {
  return value == 0 ? false : true;
}

int _boolToJson(bool value) {
  return value ? 1 : 0;
}
