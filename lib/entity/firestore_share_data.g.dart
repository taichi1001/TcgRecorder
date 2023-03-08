// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_share_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FirestoreShareData _$$_FirestoreShareDataFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_FirestoreShareData',
      json,
      ($checkedConvert) {
        final val = _$_FirestoreShareData(
          game: $checkedConvert(
              'game', (v) => Game.fromJson(v as Map<String, dynamic>)),
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
        'deckList': 'deck_list',
        'tagList': 'tag_list',
        'recordList': 'record_list'
      },
    );

Map<String, dynamic> _$$_FirestoreShareDataToJson(
        _$_FirestoreShareData instance) =>
    <String, dynamic>{
      'game': instance.game.toJson(),
      'deck_list': instance.deckList.map((e) => e.toJson()).toList(),
      'tag_list': instance.tagList.map((e) => e.toJson()).toList(),
      'record_list': instance.recordList.map((e) => e.toJson()).toList(),
    };
