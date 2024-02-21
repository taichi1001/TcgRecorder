// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShareUserImpl _$$ShareUserImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ShareUserImpl',
      json,
      ($checkedConvert) {
        final val = _$ShareUserImpl(
          id: $checkedConvert('id', (v) => v as String),
          roll: $checkedConvert(
              'roll',
              (v) =>
                  $enumDecodeNullable(_$AccessRollEnumMap, v) ??
                  AccessRoll.reader),
        );
        return val;
      },
    );

Map<String, dynamic> _$$ShareUserImplToJson(_$ShareUserImpl instance) =>
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
