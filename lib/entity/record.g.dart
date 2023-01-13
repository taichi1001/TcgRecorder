// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Record _$$_RecordFromJson(Map<String, dynamic> json) => _$_Record(
      recordId: json['record_id'] as int?,
      gameId: json['game_id'] as int?,
      tagId: _stringToInt(json['tag_id'] as String?),
      useDeckId: json['use_deck_id'] as int?,
      opponentDeckId: json['opponent_deck_id'] as int?,
      date: _dateTimeFromJson(json['date'] as String),
      bo: json['bo'] == null ? BO.bo1 : _boFromJson(json['bo'] as int),
      firstSecond: json['first_second'] == null
          ? FirstSecond.first
          : _firstSecondFromJson(json['first_second'] as int),
      firstMatchFirstSecond: _nullableFirstSecondFromJson(
          json['first_match_first_second'] as int?),
      secondMatchFirstSecond: _nullableFirstSecondFromJson(
          json['second_match_first_second'] as int?),
      thiredMatchFirstSecond: _nullableFirstSecondFromJson(
          json['third_match_first_second'] as int?),
      winLoss: json['win_loss'] == null
          ? WinLoss.win
          : _winLossFromJson(json['win_loss'] as int),
      firstMatchWinLoss:
          _nullableWinLossFromJson(json['first_match_win_loss'] as int?),
      secondMatchWinLoss:
          _nullableWinLossFromJson(json['second_match_win_loss'] as int?),
      thirdMatchWinLoss:
          _nullableWinLossFromJson(json['third_match_win_loss'] as int?),
      memo: json['memo'] as String?,
      imagePath: _stringListFromJson(json['image_path'] as String?),
    );

Map<String, dynamic> _$$_RecordToJson(_$_Record instance) => <String, dynamic>{
      'record_id': instance.recordId,
      'game_id': instance.gameId,
      'tag_id': _intToString(instance.tagId),
      'use_deck_id': instance.useDeckId,
      'opponent_deck_id': instance.opponentDeckId,
      'date': _dateTimeToJson(instance.date),
      'bo': _boToJson(instance.bo),
      'first_second': _firstSecondToJson(instance.firstSecond),
      'first_match_first_second':
          _nullableFirstSecondToJson(instance.firstMatchFirstSecond),
      'second_match_first_second':
          _nullableFirstSecondToJson(instance.secondMatchFirstSecond),
      'third_match_first_second':
          _nullableFirstSecondToJson(instance.thiredMatchFirstSecond),
      'win_loss': _winLossToJson(instance.winLoss),
      'first_match_win_loss':
          _nullableWinLossToJson(instance.firstMatchWinLoss),
      'second_match_win_loss':
          _nullableWinLossToJson(instance.secondMatchWinLoss),
      'third_match_win_loss':
          _nullableWinLossToJson(instance.thirdMatchWinLoss),
      'memo': instance.memo,
      'image_path': _stringListToJson(instance.imagePath),
    };
