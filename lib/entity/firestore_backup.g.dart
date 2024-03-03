// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_backup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirestoreBackupImpl _$$FirestoreBackupImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$FirestoreBackupImpl',
      json,
      ($checkedConvert) {
        final val = _$FirestoreBackupImpl(
          gameList: $checkedConvert(
              'game_list',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => Game.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
          deckList: $checkedConvert(
              'deck_list',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => Deck.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
          tagList: $checkedConvert(
              'tag_list',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
          recordList: $checkedConvert(
              'record_list',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => Record.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
          lastBackup: $checkedConvert('last_backup',
              (v) => v == null ? null : DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'gameList': 'game_list',
        'deckList': 'deck_list',
        'tagList': 'tag_list',
        'recordList': 'record_list',
        'lastBackup': 'last_backup'
      },
    );

Map<String, dynamic> _$$FirestoreBackupImplToJson(
        _$FirestoreBackupImpl instance) =>
    <String, dynamic>{
      'game_list': instance.gameList.map((e) => e.toJson()).toList(),
      'deck_list': instance.deckList.map((e) => e.toJson()).toList(),
      'tag_list': instance.tagList.map((e) => e.toJson()).toList(),
      'record_list': instance.recordList.map((e) => e.toJson()).toList(),
      'last_backup': instance.lastBackup?.toIso8601String(),
    };
