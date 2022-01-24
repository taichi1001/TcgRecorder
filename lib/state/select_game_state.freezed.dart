// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'select_game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SelectGameStateTearOff {
  const _$SelectGameStateTearOff();

  _SelectGameState call({Game? selectGame}) {
    return _SelectGameState(
      selectGame: selectGame,
    );
  }
}

/// @nodoc
const $SelectGameState = _$SelectGameStateTearOff();

/// @nodoc
mixin _$SelectGameState {
  Game? get selectGame => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectGameStateCopyWith<SelectGameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectGameStateCopyWith<$Res> {
  factory $SelectGameStateCopyWith(
          SelectGameState value, $Res Function(SelectGameState) then) =
      _$SelectGameStateCopyWithImpl<$Res>;
  $Res call({Game? selectGame});

  $GameCopyWith<$Res>? get selectGame;
}

/// @nodoc
class _$SelectGameStateCopyWithImpl<$Res>
    implements $SelectGameStateCopyWith<$Res> {
  _$SelectGameStateCopyWithImpl(this._value, this._then);

  final SelectGameState _value;
  // ignore: unused_field
  final $Res Function(SelectGameState) _then;

  @override
  $Res call({
    Object? selectGame = freezed,
  }) {
    return _then(_value.copyWith(
      selectGame: selectGame == freezed
          ? _value.selectGame
          : selectGame // ignore: cast_nullable_to_non_nullable
              as Game?,
    ));
  }

  @override
  $GameCopyWith<$Res>? get selectGame {
    if (_value.selectGame == null) {
      return null;
    }

    return $GameCopyWith<$Res>(_value.selectGame!, (value) {
      return _then(_value.copyWith(selectGame: value));
    });
  }
}

/// @nodoc
abstract class _$SelectGameStateCopyWith<$Res>
    implements $SelectGameStateCopyWith<$Res> {
  factory _$SelectGameStateCopyWith(
          _SelectGameState value, $Res Function(_SelectGameState) then) =
      __$SelectGameStateCopyWithImpl<$Res>;
  @override
  $Res call({Game? selectGame});

  @override
  $GameCopyWith<$Res>? get selectGame;
}

/// @nodoc
class __$SelectGameStateCopyWithImpl<$Res>
    extends _$SelectGameStateCopyWithImpl<$Res>
    implements _$SelectGameStateCopyWith<$Res> {
  __$SelectGameStateCopyWithImpl(
      _SelectGameState _value, $Res Function(_SelectGameState) _then)
      : super(_value, (v) => _then(v as _SelectGameState));

  @override
  _SelectGameState get _value => super._value as _SelectGameState;

  @override
  $Res call({
    Object? selectGame = freezed,
  }) {
    return _then(_SelectGameState(
      selectGame: selectGame == freezed
          ? _value.selectGame
          : selectGame // ignore: cast_nullable_to_non_nullable
              as Game?,
    ));
  }
}

/// @nodoc

class _$_SelectGameState implements _SelectGameState {
  _$_SelectGameState({this.selectGame});

  @override
  final Game? selectGame;

  @override
  String toString() {
    return 'SelectGameState(selectGame: $selectGame)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SelectGameState &&
            const DeepCollectionEquality()
                .equals(other.selectGame, selectGame));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(selectGame));

  @JsonKey(ignore: true)
  @override
  _$SelectGameStateCopyWith<_SelectGameState> get copyWith =>
      __$SelectGameStateCopyWithImpl<_SelectGameState>(this, _$identity);
}

abstract class _SelectGameState implements SelectGameState {
  factory _SelectGameState({Game? selectGame}) = _$_SelectGameState;

  @override
  Game? get selectGame;
  @override
  @JsonKey(ignore: true)
  _$SelectGameStateCopyWith<_SelectGameState> get copyWith =>
      throw _privateConstructorUsedError;
}
