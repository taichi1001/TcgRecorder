// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'share_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ShareUser _$ShareUserFromJson(Map<String, dynamic> json) {
  return _ShareUser.fromJson(json);
}

/// @nodoc
mixin _$ShareUser {
  String get id => throw _privateConstructorUsedError;
  AccessRoll get roll => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShareUserCopyWith<ShareUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShareUserCopyWith<$Res> {
  factory $ShareUserCopyWith(ShareUser value, $Res Function(ShareUser) then) =
      _$ShareUserCopyWithImpl<$Res, ShareUser>;
  @useResult
  $Res call({String id, AccessRoll roll});
}

/// @nodoc
class _$ShareUserCopyWithImpl<$Res, $Val extends ShareUser>
    implements $ShareUserCopyWith<$Res> {
  _$ShareUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roll = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      roll: null == roll
          ? _value.roll
          : roll // ignore: cast_nullable_to_non_nullable
              as AccessRoll,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShareUserImplCopyWith<$Res>
    implements $ShareUserCopyWith<$Res> {
  factory _$$ShareUserImplCopyWith(
          _$ShareUserImpl value, $Res Function(_$ShareUserImpl) then) =
      __$$ShareUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, AccessRoll roll});
}

/// @nodoc
class __$$ShareUserImplCopyWithImpl<$Res>
    extends _$ShareUserCopyWithImpl<$Res, _$ShareUserImpl>
    implements _$$ShareUserImplCopyWith<$Res> {
  __$$ShareUserImplCopyWithImpl(
      _$ShareUserImpl _value, $Res Function(_$ShareUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roll = null,
  }) {
    return _then(_$ShareUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      roll: null == roll
          ? _value.roll
          : roll // ignore: cast_nullable_to_non_nullable
              as AccessRoll,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShareUserImpl implements _ShareUser {
  _$ShareUserImpl({required this.id, required this.roll});

  factory _$ShareUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShareUserImplFromJson(json);

  @override
  final String id;
  @override
  final AccessRoll roll;

  @override
  String toString() {
    return 'ShareUser(id: $id, roll: $roll)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShareUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roll, roll) || other.roll == roll));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, roll);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShareUserImplCopyWith<_$ShareUserImpl> get copyWith =>
      __$$ShareUserImplCopyWithImpl<_$ShareUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShareUserImplToJson(
      this,
    );
  }
}

abstract class _ShareUser implements ShareUser {
  factory _ShareUser(
      {required final String id,
      required final AccessRoll roll}) = _$ShareUserImpl;

  factory _ShareUser.fromJson(Map<String, dynamic> json) =
      _$ShareUserImpl.fromJson;

  @override
  String get id;
  @override
  AccessRoll get roll;
  @override
  @JsonKey(ignore: true)
  _$$ShareUserImplCopyWith<_$ShareUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
