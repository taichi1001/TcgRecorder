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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_ShareUserCopyWith<$Res> implements $ShareUserCopyWith<$Res> {
  factory _$$_ShareUserCopyWith(
          _$_ShareUser value, $Res Function(_$_ShareUser) then) =
      __$$_ShareUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, AccessRoll roll});
}

/// @nodoc
class __$$_ShareUserCopyWithImpl<$Res>
    extends _$ShareUserCopyWithImpl<$Res, _$_ShareUser>
    implements _$$_ShareUserCopyWith<$Res> {
  __$$_ShareUserCopyWithImpl(
      _$_ShareUser _value, $Res Function(_$_ShareUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roll = null,
  }) {
    return _then(_$_ShareUser(
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
class _$_ShareUser implements _ShareUser {
  _$_ShareUser({required this.id, required this.roll});

  factory _$_ShareUser.fromJson(Map<String, dynamic> json) =>
      _$$_ShareUserFromJson(json);

  @override
  final String id;
  @override
  final AccessRoll roll;

  @override
  String toString() {
    return 'ShareUser(id: $id, roll: $roll)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShareUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roll, roll) || other.roll == roll));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, roll);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShareUserCopyWith<_$_ShareUser> get copyWith =>
      __$$_ShareUserCopyWithImpl<_$_ShareUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ShareUserToJson(
      this,
    );
  }
}

abstract class _ShareUser implements ShareUser {
  factory _ShareUser(
      {required final String id,
      required final AccessRoll roll}) = _$_ShareUser;

  factory _ShareUser.fromJson(Map<String, dynamic> json) =
      _$_ShareUser.fromJson;

  @override
  String get id;
  @override
  AccessRoll get roll;
  @override
  @JsonKey(ignore: true)
  _$$_ShareUserCopyWith<_$_ShareUser> get copyWith =>
      throw _privateConstructorUsedError;
}
