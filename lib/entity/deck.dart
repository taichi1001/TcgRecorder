import 'package:freezed_annotation/freezed_annotation.dart';

part 'deck.freezed.dart';
part 'deck.g.dart';

@freezed
class Deck with _$Deck {
  factory Deck({
    @JsonKey(name: 'deck_id') int? deckId,
    required String deck,
    @JsonKey(name: 'game_id') int? gameId,
    @Default(true) @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker') bool isVisibleToPicker,
    @JsonKey(name: 'sort_index') int? sortIndex,
  }) = _Deck;
  factory Deck.fromJson(Map<String, dynamic> json) => _$DeckFromJson(json);
}

bool _boolFromJson(value) {
  return value == 0 ? false : true;
}

int _boolToJson(bool value) {
  return value ? 1 : 0;
}
