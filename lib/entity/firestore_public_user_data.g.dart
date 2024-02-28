// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_public_user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirestorePublicUserDataImpl _$$FirestorePublicUserDataImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$FirestorePublicUserDataImpl',
      json,
      ($checkedConvert) {
        final val = _$FirestorePublicUserDataImpl(
          uid: $checkedConvert('uid', (v) => v as String),
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
        );
        return val;
      },
      fieldKeyMap: const {
        'gameList': 'game_list',
        'deckList': 'deck_list',
        'tagList': 'tag_list',
        'recordList': 'record_list'
      },
    );

Map<String, dynamic> _$$FirestorePublicUserDataImplToJson(
        _$FirestorePublicUserDataImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'game_list': instance.gameList.map((e) => e.toJson()).toList(),
      'deck_list': instance.deckList.map((e) => e.toJson()).toList(),
      'tag_list': instance.tagList.map((e) => e.toJson()).toList(),
      'record_list': instance.recordList.map((e) => e.toJson()).toList(),
    };
