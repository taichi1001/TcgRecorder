// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Game _$$_GameFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$_Game',
      json,
      ($checkedConvert) {
        final val = _$_Game(
          id: $checkedConvert('game_id', (v) => v as int?),
          name: $checkedConvert('game', (v) => v as String),
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
        'isVisibleToPicker': 'is_visible_to_picker',
        'isShare': 'is_share',
        'sortIndex': 'sort_index'
      },
    );

Map<String, dynamic> _$$_GameToJson(_$_Game instance) => <String, dynamic>{
      'game_id': instance.id,
      'game': instance.name,
      'is_visible_to_picker': _boolToJson(instance.isVisibleToPicker),
      'is_share': _boolToJson(instance.isShare),
      'sort_index': instance.sortIndex,
    };
