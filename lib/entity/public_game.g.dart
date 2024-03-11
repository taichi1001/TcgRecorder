// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PublicGameImpl _$$PublicGameImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$PublicGameImpl',
      json,
      ($checkedConvert) {
        final val = _$PublicGameImpl(
          id: $checkedConvert('id', (v) => v as int),
          name: $checkedConvert('name', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$PublicGameImplToJson(_$PublicGameImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
