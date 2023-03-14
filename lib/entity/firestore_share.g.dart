// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_share.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FirestoreShare _$$_FirestoreShareFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_FirestoreShare',
      json,
      ($checkedConvert) {
        final val = _$_FirestoreShare(
          game: $checkedConvert(
              'game', (v) => Game.fromJson(v as Map<String, dynamic>)),
          ownerName: $checkedConvert('owner_name', (v) => v as String),
          docName: $checkedConvert('doc_name', (v) => v as String),
          pendingUserList: $checkedConvert(
              'pending_user_list',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map(
                          (e) => ShareUser.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
          shareUserList: $checkedConvert(
              'share_user_list',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map(
                          (e) => ShareUser.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
        );
        return val;
      },
      fieldKeyMap: const {
        'ownerName': 'owner_name',
        'docName': 'doc_name',
        'pendingUserList': 'pending_user_list',
        'shareUserList': 'share_user_list'
      },
    );

Map<String, dynamic> _$$_FirestoreShareToJson(_$_FirestoreShare instance) =>
    <String, dynamic>{
      'game': instance.game.toJson(),
      'owner_name': instance.ownerName,
      'doc_name': instance.docName,
      'pending_user_list':
          instance.pendingUserList.map((e) => e.toJson()).toList(),
      'share_user_list': instance.shareUserList.map((e) => e.toJson()).toList(),
    };
