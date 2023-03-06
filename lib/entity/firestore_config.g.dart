// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FirestoreConfig _$$_FirestoreConfigFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_FirestoreConfig',
      json,
      ($checkedConvert) {
        final val = _$_FirestoreConfig(
          android: $checkedConvert('android', (v) => v as String),
          ios: $checkedConvert('ios', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_FirestoreConfigToJson(_$_FirestoreConfig instance) =>
    <String, dynamic>{
      'android': instance.android,
      'ios': instance.ios,
    };
