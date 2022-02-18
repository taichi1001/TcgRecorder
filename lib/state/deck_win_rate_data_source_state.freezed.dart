// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'deck_win_rate_data_source_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DeckWinRateDataSourceStateTearOff {
  const _$DeckWinRateDataSourceStateTearOff();

  _DeckWinRateDataSourceState call(
      {DeckWinRateDataSource? deckWinRateDataSource}) {
    return _DeckWinRateDataSourceState(
      deckWinRateDataSource: deckWinRateDataSource,
    );
  }
}

/// @nodoc
const $DeckWinRateDataSourceState = _$DeckWinRateDataSourceStateTearOff();

/// @nodoc
mixin _$DeckWinRateDataSourceState {
  DeckWinRateDataSource? get deckWinRateDataSource =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeckWinRateDataSourceStateCopyWith<DeckWinRateDataSourceState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeckWinRateDataSourceStateCopyWith<$Res> {
  factory $DeckWinRateDataSourceStateCopyWith(DeckWinRateDataSourceState value,
          $Res Function(DeckWinRateDataSourceState) then) =
      _$DeckWinRateDataSourceStateCopyWithImpl<$Res>;
  $Res call({DeckWinRateDataSource? deckWinRateDataSource});
}

/// @nodoc
class _$DeckWinRateDataSourceStateCopyWithImpl<$Res>
    implements $DeckWinRateDataSourceStateCopyWith<$Res> {
  _$DeckWinRateDataSourceStateCopyWithImpl(this._value, this._then);

  final DeckWinRateDataSourceState _value;
  // ignore: unused_field
  final $Res Function(DeckWinRateDataSourceState) _then;

  @override
  $Res call({
    Object? deckWinRateDataSource = freezed,
  }) {
    return _then(_value.copyWith(
      deckWinRateDataSource: deckWinRateDataSource == freezed
          ? _value.deckWinRateDataSource
          : deckWinRateDataSource // ignore: cast_nullable_to_non_nullable
              as DeckWinRateDataSource?,
    ));
  }
}

/// @nodoc
abstract class _$DeckWinRateDataSourceStateCopyWith<$Res>
    implements $DeckWinRateDataSourceStateCopyWith<$Res> {
  factory _$DeckWinRateDataSourceStateCopyWith(
          _DeckWinRateDataSourceState value,
          $Res Function(_DeckWinRateDataSourceState) then) =
      __$DeckWinRateDataSourceStateCopyWithImpl<$Res>;
  @override
  $Res call({DeckWinRateDataSource? deckWinRateDataSource});
}

/// @nodoc
class __$DeckWinRateDataSourceStateCopyWithImpl<$Res>
    extends _$DeckWinRateDataSourceStateCopyWithImpl<$Res>
    implements _$DeckWinRateDataSourceStateCopyWith<$Res> {
  __$DeckWinRateDataSourceStateCopyWithImpl(_DeckWinRateDataSourceState _value,
      $Res Function(_DeckWinRateDataSourceState) _then)
      : super(_value, (v) => _then(v as _DeckWinRateDataSourceState));

  @override
  _DeckWinRateDataSourceState get _value =>
      super._value as _DeckWinRateDataSourceState;

  @override
  $Res call({
    Object? deckWinRateDataSource = freezed,
  }) {
    return _then(_DeckWinRateDataSourceState(
      deckWinRateDataSource: deckWinRateDataSource == freezed
          ? _value.deckWinRateDataSource
          : deckWinRateDataSource // ignore: cast_nullable_to_non_nullable
              as DeckWinRateDataSource?,
    ));
  }
}

/// @nodoc

class _$_DeckWinRateDataSourceState implements _DeckWinRateDataSourceState {
  _$_DeckWinRateDataSourceState({this.deckWinRateDataSource});

  @override
  final DeckWinRateDataSource? deckWinRateDataSource;

  @override
  String toString() {
    return 'DeckWinRateDataSourceState(deckWinRateDataSource: $deckWinRateDataSource)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeckWinRateDataSourceState &&
            const DeepCollectionEquality()
                .equals(other.deckWinRateDataSource, deckWinRateDataSource));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(deckWinRateDataSource));

  @JsonKey(ignore: true)
  @override
  _$DeckWinRateDataSourceStateCopyWith<_DeckWinRateDataSourceState>
      get copyWith => __$DeckWinRateDataSourceStateCopyWithImpl<
          _DeckWinRateDataSourceState>(this, _$identity);
}

abstract class _DeckWinRateDataSourceState
    implements DeckWinRateDataSourceState {
  factory _DeckWinRateDataSourceState(
          {DeckWinRateDataSource? deckWinRateDataSource}) =
      _$_DeckWinRateDataSourceState;

  @override
  DeckWinRateDataSource? get deckWinRateDataSource;
  @override
  @JsonKey(ignore: true)
  _$DeckWinRateDataSourceStateCopyWith<_DeckWinRateDataSourceState>
      get copyWith => throw _privateConstructorUsedError;
}
