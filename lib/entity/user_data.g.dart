// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataImpl _$$UserDataImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$UserDataImpl',
      json,
      ($checkedConvert) {
        final val = _$UserDataImpl(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String?),
          iconPath: $checkedConvert('icon_path', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'iconPath': 'icon_path'},
    );

Map<String, dynamic> _$$UserDataImplToJson(_$UserDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon_path': instance.iconPath,
    };
