// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeckImpl _$$DeckImplFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$DeckImpl',
      json,
      ($checkedConvert) {
        final val = _$DeckImpl(
          id: $checkedConvert('deck_id', (v) => v as int?),
          name: $checkedConvert('deck', (v) => v as String),
          gameId: $checkedConvert('game_id', (v) => v as int?),
          isVisibleToPicker: $checkedConvert('is_visible_to_picker',
              (v) => v == null ? true : _boolFromJson(v)),
          sortIndex: $checkedConvert('sort_index', (v) => v as int?),
        );
        return val;
      },
      fieldKeyMap: const {
        'id': 'deck_id',
        'name': 'deck',
        'gameId': 'game_id',
        'isVisibleToPicker': 'is_visible_to_picker',
        'sortIndex': 'sort_index'
      },
    );

Map<String, dynamic> _$$DeckImplToJson(_$DeckImpl instance) =>
    <String, dynamic>{
      'deck_id': instance.id,
      'deck': instance.name,
      'game_id': instance.gameId,
      'is_visible_to_picker': _boolToJson(instance.isVisibleToPicker),
      'sort_index': instance.sortIndex,
    };
