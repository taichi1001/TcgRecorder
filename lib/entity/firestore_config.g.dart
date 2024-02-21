// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirestoreConfigImpl _$$FirestoreConfigImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$FirestoreConfigImpl',
      json,
      ($checkedConvert) {
        final val = _$FirestoreConfigImpl(
          android: $checkedConvert('android', (v) => v as String),
          ios: $checkedConvert('ios', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$FirestoreConfigImplToJson(
        _$FirestoreConfigImpl instance) =>
    <String, dynamic>{
      'android': instance.android,
      'ios': instance.ios,
    };
