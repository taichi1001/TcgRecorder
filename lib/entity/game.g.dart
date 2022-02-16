// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Game _$$_GameFromJson(Map<String, dynamic> json) => _$_Game(
      gameId: json['game_id'] as int?,
      game: json['game'] as String,
      isVisibleToPicker: json['is_visible_to_picker'] == null
          ? true
          : _boolFromJson(json['is_visible_to_picker']),
    );

Map<String, dynamic> _$$_GameToJson(_$_Game instance) => <String, dynamic>{
      'game_id': instance.gameId,
      'game': instance.game,
      'is_visible_to_picker': _boolToJson(instance.isVisibleToPicker),
    };
