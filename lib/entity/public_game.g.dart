// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PublicGameImpl _$$PublicGameImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$PublicGameImpl',
      json,
      ($checkedConvert) {
        final val = _$PublicGameImpl(
          id: $checkedConvert('id', (v) => v as int),
          name: $checkedConvert('name', (v) => v as String),
          isVisibleToPicker: $checkedConvert(
              'is_visible_to_picker', (v) => v as bool? ?? true),
          sortIndex: $checkedConvert('sort_index', (v) => v as int?),
        );
        return val;
      },
      fieldKeyMap: const {
        'isVisibleToPicker': 'is_visible_to_picker',
        'sortIndex': 'sort_index'
      },
    );

Map<String, dynamic> _$$PublicGameImplToJson(_$PublicGameImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_visible_to_picker': instance.isVisibleToPicker,
      'sort_index': instance.sortIndex,
    };
