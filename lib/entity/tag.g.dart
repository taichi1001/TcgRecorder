// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TagImpl _$$TagImplFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$TagImpl',
      json,
      ($checkedConvert) {
        final val = _$TagImpl(
          id: $checkedConvert('tag_id', (v) => v as int?),
          name: $checkedConvert('tag', (v) => v as String),
          gameId: $checkedConvert('game_id', (v) => v as int?),
          isVisibleToPicker: $checkedConvert('is_visible_to_picker',
              (v) => v == null ? true : _boolFromJson(v)),
          sortIndex: $checkedConvert('sort_index', (v) => v as int?),
        );
        return val;
      },
      fieldKeyMap: const {
        'id': 'tag_id',
        'name': 'tag',
        'gameId': 'game_id',
        'isVisibleToPicker': 'is_visible_to_picker',
        'sortIndex': 'sort_index'
      },
    );

Map<String, dynamic> _$$TagImplToJson(_$TagImpl instance) => <String, dynamic>{
      'tag_id': instance.id,
      'tag': instance.name,
      'game_id': instance.gameId,
      'is_visible_to_picker': _boolToJson(instance.isVisibleToPicker),
      'sort_index': instance.sortIndex,
    };
