// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'initial_game_registration_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InitialGameRegistrationState {
  Game? get initialGame => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InitialGameRegistrationStateCopyWith<InitialGameRegistrationState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InitialGameRegistrationStateCopyWith<$Res> {
  factory $InitialGameRegistrationStateCopyWith(
          InitialGameRegistrationState value,
          $Res Function(InitialGameRegistrationState) then) =
      _$InitialGameRegistrationStateCopyWithImpl<$Res,
          InitialGameRegistrationState>;
  @useResult
  $Res call({Game? initialGame});

  $GameCopyWith<$Res>? get initialGame;
}

/// @nodoc
class _$InitialGameRegistrationStateCopyWithImpl<$Res,
        $Val extends InitialGameRegistrationState>
    implements $InitialGameRegistrationStateCopyWith<$Res> {
  _$InitialGameRegistrationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initialGame = freezed,
  }) {
    return _then(_value.copyWith(
      initialGame: freezed == initialGame
          ? _value.initialGame
          : initialGame // ignore: cast_nullable_to_non_nullable
              as Game?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GameCopyWith<$Res>? get initialGame {
    if (_value.initialGame == null) {
      return null;
    }

    return $GameCopyWith<$Res>(_value.initialGame!, (value) {
      return _then(_value.copyWith(initialGame: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InitialGameRegistrationStateImplCopyWith<$Res>
    implements $InitialGameRegistrationStateCopyWith<$Res> {
  factory _$$InitialGameRegistrationStateImplCopyWith(
          _$InitialGameRegistrationStateImpl value,
          $Res Function(_$InitialGameRegistrationStateImpl) then) =
      __$$InitialGameRegistrationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Game? initialGame});

  @override
  $GameCopyWith<$Res>? get initialGame;
}

/// @nodoc
class __$$InitialGameRegistrationStateImplCopyWithImpl<$Res>
    extends _$InitialGameRegistrationStateCopyWithImpl<$Res,
        _$InitialGameRegistrationStateImpl>
    implements _$$InitialGameRegistrationStateImplCopyWith<$Res> {
  __$$InitialGameRegistrationStateImplCopyWithImpl(
      _$InitialGameRegistrationStateImpl _value,
      $Res Function(_$InitialGameRegistrationStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initialGame = freezed,
  }) {
    return _then(_$InitialGameRegistrationStateImpl(
      initialGame: freezed == initialGame
          ? _value.initialGame
          : initialGame // ignore: cast_nullable_to_non_nullable
              as Game?,
    ));
  }
}

/// @nodoc

class _$InitialGameRegistrationStateImpl
    implements _InitialGameRegistrationState {
  _$InitialGameRegistrationStateImpl({this.initialGame});

  @override
  final Game? initialGame;

  @override
  String toString() {
    return 'InitialGameRegistrationState(initialGame: $initialGame)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialGameRegistrationStateImpl &&
            (identical(other.initialGame, initialGame) ||
                other.initialGame == initialGame));
  }

  @override
  int get hashCode => Object.hash(runtimeType, initialGame);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialGameRegistrationStateImplCopyWith<
          _$InitialGameRegistrationStateImpl>
      get copyWith => __$$InitialGameRegistrationStateImplCopyWithImpl<
          _$InitialGameRegistrationStateImpl>(this, _$identity);
}

abstract class _InitialGameRegistrationState
    implements InitialGameRegistrationState {
  factory _InitialGameRegistrationState({final Game? initialGame}) =
      _$InitialGameRegistrationStateImpl;

  @override
  Game? get initialGame;
  @override
  @JsonKey(ignore: true)
  _$$InitialGameRegistrationStateImplCopyWith<
          _$InitialGameRegistrationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
