// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Deck _$$_DeckFromJson(Map<String, dynamic> json) => _$_Deck(
      deckId: json['deck_id'] as int?,
      deck: json['deck'] as String,
      gameId: json['game_id'] as int?,
      isVisibleToPicker: json['is_visible_to_picker'] == null
          ? true
          : _boolFromJson(json['is_visible_to_picker']),
      sortIndex: json['sort_index'] as int?,
    );

Map<String, dynamic> _$$_DeckToJson(_$_Deck instance) => <String, dynamic>{
      'deck_id': instance.deckId,
      'deck': instance.deck,
      'game_id': instance.gameId,
      'is_visible_to_picker': _boolToJson(instance.isVisibleToPicker),
      'sort_index': instance.sortIndex,
    };
