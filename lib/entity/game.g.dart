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
          gameId: $checkedConvert('game_id', (v) => v as int?),
          game: $checkedConvert('game', (v) => v as String),
          isVisibleToPicker: $checkedConvert('is_visible_to_picker',
              (v) => v == null ? true : _boolFromJson(v)),
        );
        return val;
      },
      fieldKeyMap: const {
        'gameId': 'game_id',
        'isVisibleToPicker': 'is_visible_to_picker'
      },
    );

Map<String, dynamic> _$$_GameToJson(_$_Game instance) => <String, dynamic>{
      'game_id': instance.gameId,
      'game': instance.game,
      'is_visible_to_picker': _boolToJson(instance.isVisibleToPicker),
    };
