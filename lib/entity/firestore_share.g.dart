// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_share.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirestoreShareImpl _$$FirestoreShareImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$FirestoreShareImpl',
      json,
      ($checkedConvert) {
        final val = _$FirestoreShareImpl(
          game: $checkedConvert(
              'game', (v) => Game.fromJson(v as Map<String, dynamic>)),
          authorName: $checkedConvert('author_name', (v) => v as String),
          docName: $checkedConvert('doc_name', (v) => v as String),
          isShared: $checkedConvert('is_shared', (v) => v as bool? ?? true),
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
        'authorName': 'author_name',
        'docName': 'doc_name',
        'isShared': 'is_shared',
        'pendingUserList': 'pending_user_list',
        'shareUserList': 'share_user_list'
      },
    );

Map<String, dynamic> _$$FirestoreShareImplToJson(
        _$FirestoreShareImpl instance) =>
    <String, dynamic>{
      'game': instance.game.toJson(),
      'author_name': instance.authorName,
      'doc_name': instance.docName,
      'is_shared': instance.isShared,
      'pending_user_list':
          instance.pendingUserList.map((e) => e.toJson()).toList(),
      'share_user_list': instance.shareUserList.map((e) => e.toJson()).toList(),
    };
