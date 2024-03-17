// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameImpl _$$GameImplFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$GameImpl',
      json,
      ($checkedConvert) {
        final val = _$GameImpl(
          id: $checkedConvert('game_id', (v) => v as int?),
          name: $checkedConvert('game', (v) => v as String),
          publicGameId: $checkedConvert('public_game_id', (v) => v as int?),
          isVisibleToPicker: $checkedConvert('is_visible_to_picker',
              (v) => v == null ? true : _boolFromJson(v)),
          isShare: $checkedConvert(
              'is_share', (v) => v == null ? false : _boolFromJson(v)),
          sortIndex: $checkedConvert('sort_index', (v) => v as int?),
        );
        return val;
      },
      fieldKeyMap: const {
        'id': 'game_id',
        'name': 'game',
        'publicGameId': 'public_game_id',
        'isVisibleToPicker': 'is_visible_to_picker',
        'isShare': 'is_share',
        'sortIndex': 'sort_index'
      },
    );

Map<String, dynamic> _$$GameImplToJson(_$GameImpl instance) =>
    <String, dynamic>{
      'game_id': instance.id,
      'game': instance.name,
      'public_game_id': instance.publicGameId,
      'is_visible_to_picker': _boolToJson(instance.isVisibleToPicker),
      'is_share': _boolToJson(instance.isShare),
      'sort_index': instance.sortIndex,
    };
