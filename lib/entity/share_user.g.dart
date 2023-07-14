// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ShareUser _$$_ShareUserFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$_ShareUser',
      json,
      ($checkedConvert) {
        final val = _$_ShareUser(
          id: $checkedConvert('id', (v) => v as String),
          roll: $checkedConvert(
              'roll', (v) => $enumDecode(_$AccessRollEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_ShareUserToJson(_$_ShareUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roll': _$AccessRollEnumMap[instance.roll]!,
    };

const _$AccessRollEnumMap = {
  AccessRoll.author: 'author',
  AccessRoll.owner: 'owner',
  AccessRoll.writer: 'writer',
  AccessRoll.reader: 'reader',
};
