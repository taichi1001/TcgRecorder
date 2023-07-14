// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firebase_auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FirebaseAuthState {
  User? get user => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FirebaseAuthStateCopyWith<FirebaseAuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirebaseAuthStateCopyWith<$Res> {
  factory $FirebaseAuthStateCopyWith(
          FirebaseAuthState value, $Res Function(FirebaseAuthState) then) =
      _$FirebaseAuthStateCopyWithImpl<$Res, FirebaseAuthState>;
  @useResult
  $Res call({User? user});
}

/// @nodoc
class _$FirebaseAuthStateCopyWithImpl<$Res, $Val extends FirebaseAuthState>
    implements $FirebaseAuthStateCopyWith<$Res> {
  _$FirebaseAuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FirebaseAuthStateCopyWith<$Res>
    implements $FirebaseAuthStateCopyWith<$Res> {
  factory _$$_FirebaseAuthStateCopyWith(_$_FirebaseAuthState value,
          $Res Function(_$_FirebaseAuthState) then) =
      __$$_FirebaseAuthStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({User? user});
}

/// @nodoc
class __$$_FirebaseAuthStateCopyWithImpl<$Res>
    extends _$FirebaseAuthStateCopyWithImpl<$Res, _$_FirebaseAuthState>
    implements _$$_FirebaseAuthStateCopyWith<$Res> {
  __$$_FirebaseAuthStateCopyWithImpl(
      _$_FirebaseAuthState _value, $Res Function(_$_FirebaseAuthState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(_$_FirebaseAuthState(
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc

class _$_FirebaseAuthState implements _FirebaseAuthState {
  _$_FirebaseAuthState({this.user});

  @override
  final User? user;

  @override
  String toString() {
    return 'FirebaseAuthState(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FirebaseAuthState &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FirebaseAuthStateCopyWith<_$_FirebaseAuthState> get copyWith =>
      __$$_FirebaseAuthStateCopyWithImpl<_$_FirebaseAuthState>(
          this, _$identity);
}

abstract class _FirebaseAuthState implements FirebaseAuthState {
  factory _FirebaseAuthState({final User? user}) = _$_FirebaseAuthState;

  @override
  User? get user;
  @override
  @JsonKey(ignore: true)
  _$$_FirebaseAuthStateCopyWith<_$_FirebaseAuthState> get copyWith =>
      throw _privateConstructorUsedError;
}
