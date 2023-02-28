// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Deck _$$_DeckFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$_Deck',
      json,
      ($checkedConvert) {
        final val = _$_Deck(
          deckId: $checkedConvert('deck_id', (v) => v as int?),
          deck: $checkedConvert('deck', (v) => v as String),
          gameId: $checkedConvert('game_id', (v) => v as int?),
          isVisibleToPicker: $checkedConvert('is_visible_to_picker',
              (v) => v == null ? true : _boolFromJson(v)),
          sortIndex: $checkedConvert('sort_index', (v) => v as int?),
        );
        return val;
      },
      fieldKeyMap: const {
        'deckId': 'deck_id',
        'gameId': 'game_id',
        'isVisibleToPicker': 'is_visible_to_picker',
        'sortIndex': 'sort_index'
      },
    );

Map<String, dynamic> _$$_DeckToJson(_$_Deck instance) => <String, dynamic>{
      'deck_id': instance.deckId,
      'deck': instance.deck,
      'game_id': instance.gameId,
      'is_visible_to_picker': _boolToJson(instance.isVisibleToPicker),
      'sort_index': instance.sortIndex,
    };
