// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'initial_game_registration_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$InitialGameRegistrationStateTearOff {
  const _$InitialGameRegistrationStateTearOff();

  _InitialGameRegistrationState call({Game? initialGame}) {
    return _InitialGameRegistrationState(
      initialGame: initialGame,
    );
  }
}

/// @nodoc
const $InitialGameRegistrationState = _$InitialGameRegistrationStateTearOff();

/// @nodoc
mixin _$InitialGameRegistrationState {
  Game? get initialGame => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InitialGameRegistrationStateCopyWith<InitialGameRegistrationState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InitialGameRegistrationStateCopyWith<$Res> {
  factory $InitialGameRegistrationStateCopyWith(InitialGameRegistrationState value, $Res Function(InitialGameRegistrationState) then) =
      _$InitialGameRegistrationStateCopyWithImpl<$Res>;
  $Res call({Game? initialGame});

  $GameCopyWith<$Res>? get initialGame;
}

/// @nodoc
class _$InitialGameRegistrationStateCopyWithImpl<$Res> implements $InitialGameRegistrationStateCopyWith<$Res> {
  _$InitialGameRegistrationStateCopyWithImpl(this._value, this._then);

  final InitialGameRegistrationState _value;
  // ignore: unused_field
  final $Res Function(InitialGameRegistrationState) _then;

  @override
  $Res call({
    Object? initialGame = freezed,
  }) {
    return _then(_value.copyWith(
      initialGame: initialGame == freezed
          ? _value.initialGame
          : initialGame // ignore: cast_nullable_to_non_nullable
              as Game?,
    ));
  }

  @override
  $GameCopyWith<$Res>? get initialGame {
    if (_value.initialGame == null) {
      return null;
    }

    return $GameCopyWith<$Res>(_value.initialGame!, (value) {
      return _then(_value.copyWith(initialGame: value));
    });
  }
}

/// @nodoc
abstract class _$InitialGameRegistrationStateCopyWith<$Res> implements $InitialGameRegistrationStateCopyWith<$Res> {
  factory _$InitialGameRegistrationStateCopyWith(_InitialGameRegistrationState value, $Res Function(_InitialGameRegistrationState) then) =
      __$InitialGameRegistrationStateCopyWithImpl<$Res>;
  @override
  $Res call({Game? initialGame});

  @override
  $GameCopyWith<$Res>? get initialGame;
}

/// @nodoc
class __$InitialGameRegistrationStateCopyWithImpl<$Res> extends _$InitialGameRegistrationStateCopyWithImpl<$Res>
    implements _$InitialGameRegistrationStateCopyWith<$Res> {
  __$InitialGameRegistrationStateCopyWithImpl(_InitialGameRegistrationState _value, $Res Function(_InitialGameRegistrationState) _then)
      : super(_value, (v) => _then(v as _InitialGameRegistrationState));

  @override
  _InitialGameRegistrationState get _value => super._value as _InitialGameRegistrationState;

  @override
  $Res call({
    Object? initialGame = freezed,
  }) {
    return _then(_InitialGameRegistrationState(
      initialGame: initialGame == freezed
          ? _value.initialGame
          : initialGame // ignore: cast_nullable_to_non_nullable
              as Game?,
    ));
  }
}

/// @nodoc

class _$_InitialGameRegistrationState implements _InitialGameRegistrationState {
  _$_InitialGameRegistrationState({this.initialGame});

  @override
  final Game? initialGame;

  @override
  String toString() {
    return 'InitialGameRegistrationState(initialGame: $initialGame)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InitialGameRegistrationState &&
            const DeepCollectionEquality().equals(other.initialGame, initialGame));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(initialGame));

  @JsonKey(ignore: true)
  @override
  _$InitialGameRegistrationStateCopyWith<_InitialGameRegistrationState> get copyWith =>
      __$InitialGameRegistrationStateCopyWithImpl<_InitialGameRegistrationState>(this, _$identity);
}

abstract class _InitialGameRegistrationState implements InitialGameRegistrationState {
  factory _InitialGameRegistrationState({Game? initialGame}) = _$_InitialGameRegistrationState;

  @override
  Game? get initialGame;
  @override
  @JsonKey(ignore: true)
  _$InitialGameRegistrationStateCopyWith<_InitialGameRegistrationState> get copyWith => throw _privateConstructorUsedError;
}
