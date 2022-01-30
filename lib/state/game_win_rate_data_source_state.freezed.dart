// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game_win_rate_data_source_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$GameWinRateDataSourceStateTearOff {
  const _$GameWinRateDataSourceStateTearOff();

  _GameWinRateDataSourceState call(
      {GameWinRateDataSource? gameWinRateDataSource}) {
    return _GameWinRateDataSourceState(
      gameWinRateDataSource: gameWinRateDataSource,
    );
  }
}

/// @nodoc
const $GameWinRateDataSourceState = _$GameWinRateDataSourceStateTearOff();

/// @nodoc
mixin _$GameWinRateDataSourceState {
  GameWinRateDataSource? get gameWinRateDataSource =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameWinRateDataSourceStateCopyWith<GameWinRateDataSourceState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameWinRateDataSourceStateCopyWith<$Res> {
  factory $GameWinRateDataSourceStateCopyWith(GameWinRateDataSourceState value,
          $Res Function(GameWinRateDataSourceState) then) =
      _$GameWinRateDataSourceStateCopyWithImpl<$Res>;
  $Res call({GameWinRateDataSource? gameWinRateDataSource});
}

/// @nodoc
class _$GameWinRateDataSourceStateCopyWithImpl<$Res>
    implements $GameWinRateDataSourceStateCopyWith<$Res> {
  _$GameWinRateDataSourceStateCopyWithImpl(this._value, this._then);

  final GameWinRateDataSourceState _value;
  // ignore: unused_field
  final $Res Function(GameWinRateDataSourceState) _then;

  @override
  $Res call({
    Object? gameWinRateDataSource = freezed,
  }) {
    return _then(_value.copyWith(
      gameWinRateDataSource: gameWinRateDataSource == freezed
          ? _value.gameWinRateDataSource
          : gameWinRateDataSource // ignore: cast_nullable_to_non_nullable
              as GameWinRateDataSource?,
    ));
  }
}

/// @nodoc
abstract class _$GameWinRateDataSourceStateCopyWith<$Res>
    implements $GameWinRateDataSourceStateCopyWith<$Res> {
  factory _$GameWinRateDataSourceStateCopyWith(
          _GameWinRateDataSourceState value,
          $Res Function(_GameWinRateDataSourceState) then) =
      __$GameWinRateDataSourceStateCopyWithImpl<$Res>;
  @override
  $Res call({GameWinRateDataSource? gameWinRateDataSource});
}

/// @nodoc
class __$GameWinRateDataSourceStateCopyWithImpl<$Res>
    extends _$GameWinRateDataSourceStateCopyWithImpl<$Res>
    implements _$GameWinRateDataSourceStateCopyWith<$Res> {
  __$GameWinRateDataSourceStateCopyWithImpl(_GameWinRateDataSourceState _value,
      $Res Function(_GameWinRateDataSourceState) _then)
      : super(_value, (v) => _then(v as _GameWinRateDataSourceState));

  @override
  _GameWinRateDataSourceState get _value =>
      super._value as _GameWinRateDataSourceState;

  @override
  $Res call({
    Object? gameWinRateDataSource = freezed,
  }) {
    return _then(_GameWinRateDataSourceState(
      gameWinRateDataSource: gameWinRateDataSource == freezed
          ? _value.gameWinRateDataSource
          : gameWinRateDataSource // ignore: cast_nullable_to_non_nullable
              as GameWinRateDataSource?,
    ));
  }
}

/// @nodoc

class _$_GameWinRateDataSourceState implements _GameWinRateDataSourceState {
  _$_GameWinRateDataSourceState({this.gameWinRateDataSource});

  @override
  final GameWinRateDataSource? gameWinRateDataSource;

  @override
  String toString() {
    return 'GameWinRateDataSourceState(gameWinRateDataSource: $gameWinRateDataSource)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GameWinRateDataSourceState &&
            const DeepCollectionEquality()
                .equals(other.gameWinRateDataSource, gameWinRateDataSource));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(gameWinRateDataSource));

  @JsonKey(ignore: true)
  @override
  _$GameWinRateDataSourceStateCopyWith<_GameWinRateDataSourceState>
      get copyWith => __$GameWinRateDataSourceStateCopyWithImpl<
          _GameWinRateDataSourceState>(this, _$identity);
}

abstract class _GameWinRateDataSourceState
    implements GameWinRateDataSourceState {
  factory _GameWinRateDataSourceState(
          {GameWinRateDataSource? gameWinRateDataSource}) =
      _$_GameWinRateDataSourceState;

  @override
  GameWinRateDataSource? get gameWinRateDataSource;
  @override
  @JsonKey(ignore: true)
  _$GameWinRateDataSourceStateCopyWith<_GameWinRateDataSourceState>
      get copyWith => throw _privateConstructorUsedError;
}
