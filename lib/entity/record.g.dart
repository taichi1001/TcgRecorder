// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecordImpl _$$RecordImplFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$RecordImpl',
      json,
      ($checkedConvert) {
        final val = _$RecordImpl(
          id: $checkedConvert('record_id', (v) => v as int?),
          gameId: $checkedConvert('game_id', (v) => v as int?),
          tagId: $checkedConvert('tag_id',
              (v) => v == null ? const [] : _intListFromJson(v as String?)),
          useDeckId: $checkedConvert('use_deck_id', (v) => v as int?),
          opponentDeckId: $checkedConvert('opponent_deck_id', (v) => v as int?),
          date: $checkedConvert('date', (v) => _dateTimeFromJson(v as String)),
          bo: $checkedConvert(
              'bo', (v) => v == null ? BO.bo1 : _boFromJson(v as int)),
          firstSecond: $checkedConvert(
              'first_second',
              (v) => v == null
                  ? FirstSecond.first
                  : _firstSecondFromJson(v as int)),
          firstMatchFirstSecond: $checkedConvert('first_match_first_second',
              (v) => _nullableFirstSecondFromJson(v as int?)),
          secondMatchFirstSecond: $checkedConvert('second_match_first_second',
              (v) => _nullableFirstSecondFromJson(v as int?)),
          thirdMatchFirstSecond: $checkedConvert('third_match_first_second',
              (v) => _nullableFirstSecondFromJson(v as int?)),
          winLoss: $checkedConvert('win_loss',
              (v) => v == null ? WinLoss.win : _winLossFromJson(v as int)),
          firstMatchWinLoss: $checkedConvert('first_match_win_loss',
              (v) => _nullableWinLossFromJson(v as int?)),
          secondMatchWinLoss: $checkedConvert('second_match_win_loss',
              (v) => _nullableWinLossFromJson(v as int?)),
          thirdMatchWinLoss: $checkedConvert('third_match_win_loss',
              (v) => _nullableWinLossFromJson(v as int?)),
          memo: $checkedConvert('memo', (v) => v as String?),
          author: $checkedConvert('author', (v) => v as String?),
          imagePath: $checkedConvert(
              'image_path', (v) => _stringListFromJson(v as String?)),
        );
        return val;
      },
      fieldKeyMap: const {
        'id': 'record_id',
        'gameId': 'game_id',
        'tagId': 'tag_id',
        'useDeckId': 'use_deck_id',
        'opponentDeckId': 'opponent_deck_id',
        'firstSecond': 'first_second',
        'firstMatchFirstSecond': 'first_match_first_second',
        'secondMatchFirstSecond': 'second_match_first_second',
        'thirdMatchFirstSecond': 'third_match_first_second',
        'winLoss': 'win_loss',
        'firstMatchWinLoss': 'first_match_win_loss',
        'secondMatchWinLoss': 'second_match_win_loss',
        'thirdMatchWinLoss': 'third_match_win_loss',
        'imagePath': 'image_path'
      },
    );

Map<String, dynamic> _$$RecordImplToJson(_$RecordImpl instance) =>
    <String, dynamic>{
      'record_id': instance.id,
      'game_id': instance.gameId,
      'tag_id': _intListToJson(instance.tagId),
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
          _nullableFirstSecondToJson(instance.thirdMatchFirstSecond),
      'win_loss': _winLossToJson(instance.winLoss),
      'first_match_win_loss':
          _nullableWinLossToJson(instance.firstMatchWinLoss),
      'second_match_win_loss':
          _nullableWinLossToJson(instance.secondMatchWinLoss),
      'third_match_win_loss':
          _nullableWinLossToJson(instance.thirdMatchWinLoss),
      'memo': instance.memo,
      'author': instance.author,
      'image_path': _stringListToJson(instance.imagePath),
    };
