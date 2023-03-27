// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserData _$$_UserDataFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$_UserData',
      json,
      ($checkedConvert) {
        final val = _$_UserData(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String?),
          iconPath: $checkedConvert('icon_path', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'iconPath': 'icon_path'},
    );

Map<String, dynamic> _$$_UserDataToJson(_$_UserData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon_path': instance.iconPath,
    };
