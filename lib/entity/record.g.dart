// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Record _$$_RecordFromJson(Map<String, dynamic> json) => _$_Record(
      recordId: json['record_id'] as int?,
      gameId: json['game_id'] as int?,
      tagId: json['tag_id'] as int?,
      useDeckId: json['use_deck_id'] as int?,
      opponentDeckId: json['opponent_deck_id'] as int?,
      date: _dateTimeFromJson(json['date'] as String),
      firstSecond: json['first_second'] == null
          ? true
          : _boolFromJson(json['first_second'] as int),
      winLoss: json['win_loss'] == null
          ? true
          : _boolFromJson(json['win_loss'] as int),
      memo: json['memo'] as String?,
    );

Map<String, dynamic> _$$_RecordToJson(_$_Record instance) => <String, dynamic>{
      'record_id': instance.recordId,
      'game_id': instance.gameId,
      'tag_id': instance.tagId,
      'use_deck_id': instance.useDeckId,
      'opponent_deck_id': instance.opponentDeckId,
      'date': _dateTimeToJson(instance.date),
      'first_second': _boolToJson(instance.firstSecond),
      'win_loss': _boolToJson(instance.winLoss),
      'memo': instance.memo,
    };
