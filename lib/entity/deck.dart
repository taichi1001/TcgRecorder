import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/entity/domain_data.dart';

part 'deck.freezed.dart';
part 'deck.g.dart';

@freezed
class Deck with _$Deck implements DomainData {
  factory Deck({
    @JsonKey(name: 'deck_id') int? id,
    @JsonKey(name: 'deck') required String name,
    int? gameId,
    @Default(true) @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson) bool isVisibleToPicker,
    int? sortIndex,
  }) = _Deck;
  factory Deck.fromJson(Map<String, dynamic> json) => _$DeckFromJson(json);
}

bool _boolFromJson(value) {
  return value == 0 ? false : true;
}

int _boolToJson(bool value) {
  return value ? 1 : 0;
}
