// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserInfoSettingsState {
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get iconPath => throw _privateConstructorUsedError;
  bool get isPhoneAuth => throw _privateConstructorUsedError;
  bool get isPremium => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserInfoSettingsStateCopyWith<UserInfoSettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoSettingsStateCopyWith<$Res> {
  factory $UserInfoSettingsStateCopyWith(UserInfoSettingsState value,
          $Res Function(UserInfoSettingsState) then) =
      _$UserInfoSettingsStateCopyWithImpl<$Res, UserInfoSettingsState>;
  @useResult
  $Res call(
      {String id,
      String? name,
      String? iconPath,
      bool isPhoneAuth,
      bool isPremium});
}

/// @nodoc
class _$UserInfoSettingsStateCopyWithImpl<$Res,
        $Val extends UserInfoSettingsState>
    implements $UserInfoSettingsStateCopyWith<$Res> {
  _$UserInfoSettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? iconPath = freezed,
    Object? isPhoneAuth = null,
    Object? isPremium = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      iconPath: freezed == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String?,
      isPhoneAuth: null == isPhoneAuth
          ? _value.isPhoneAuth
          : isPhoneAuth // ignore: cast_nullable_to_non_nullable
              as bool,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserInfoSettingsStateCopyWith<$Res>
    implements $UserInfoSettingsStateCopyWith<$Res> {
  factory _$$_UserInfoSettingsStateCopyWith(_$_UserInfoSettingsState value,
          $Res Function(_$_UserInfoSettingsState) then) =
      __$$_UserInfoSettingsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? name,
      String? iconPath,
      bool isPhoneAuth,
      bool isPremium});
}

/// @nodoc
class __$$_UserInfoSettingsStateCopyWithImpl<$Res>
    extends _$UserInfoSettingsStateCopyWithImpl<$Res, _$_UserInfoSettingsState>
    implements _$$_UserInfoSettingsStateCopyWith<$Res> {
  __$$_UserInfoSettingsStateCopyWithImpl(_$_UserInfoSettingsState _value,
      $Res Function(_$_UserInfoSettingsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? iconPath = freezed,
    Object? isPhoneAuth = null,
    Object? isPremium = null,
  }) {
    return _then(_$_UserInfoSettingsState(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      iconPath: freezed == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String?,
      isPhoneAuth: null == isPhoneAuth
          ? _value.isPhoneAuth
          : isPhoneAuth // ignore: cast_nullable_to_non_nullable
              as bool,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_UserInfoSettingsState implements _UserInfoSettingsState {
  _$_UserInfoSettingsState(
      {required this.id,
      this.name,
      this.iconPath,
      this.isPhoneAuth = false,
      this.isPremium = false});

  @override
  final String id;
  @override
  final String? name;
  @override
  final String? iconPath;
  @override
  @JsonKey()
  final bool isPhoneAuth;
  @override
  @JsonKey()
  final bool isPremium;

  @override
  String toString() {
    return 'UserInfoSettingsState(id: $id, name: $name, iconPath: $iconPath, isPhoneAuth: $isPhoneAuth, isPremium: $isPremium)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserInfoSettingsState &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.iconPath, iconPath) ||
                other.iconPath == iconPath) &&
            (identical(other.isPhoneAuth, isPhoneAuth) ||
                other.isPhoneAuth == isPhoneAuth) &&
            (identical(other.isPremium, isPremium) ||
                other.isPremium == isPremium));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, iconPath, isPhoneAuth, isPremium);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserInfoSettingsStateCopyWith<_$_UserInfoSettingsState> get copyWith =>
      __$$_UserInfoSettingsStateCopyWithImpl<_$_UserInfoSettingsState>(
          this, _$identity);
}

abstract class _UserInfoSettingsState implements UserInfoSettingsState {
  factory _UserInfoSettingsState(
      {required final String id,
      final String? name,
      final String? iconPath,
      final bool isPhoneAuth,
      final bool isPremium}) = _$_UserInfoSettingsState;

  @override
  String get id;
  @override
  String? get name;
  @override
  String? get iconPath;
  @override
  bool get isPhoneAuth;
  @override
  bool get isPremium;
  @override
  @JsonKey(ignore: true)
  _$$_UserInfoSettingsStateCopyWith<_$_UserInfoSettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}
