// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Tag _$$_TagFromJson(Map<String, dynamic> json) => _$_Tag(
      tagId: json['tag_id'] as int?,
      tag: json['tag'] as String,
      gameId: json['game_id'] as int?,
      isVisibleToPicker: json['is_visible_to_picker'] == null
          ? true
          : _boolFromJson(json['is_visible_to_picker']),
    );

Map<String, dynamic> _$$_TagToJson(_$_Tag instance) => <String, dynamic>{
      'tag_id': instance.tagId,
      'tag': instance.tag,
      'game_id': instance.gameId,
      'is_visible_to_picker': _boolToJson(instance.isVisibleToPicker),
    };
