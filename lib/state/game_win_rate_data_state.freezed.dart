// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game_win_rate_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$GameWinRateDataStateTearOff {
  const _$GameWinRateDataStateTearOff();

  _GameWinRateDataState call({List<WinRateData>? winRateDataList}) {
    return _GameWinRateDataState(
      winRateDataList: winRateDataList,
    );
  }
}

/// @nodoc
const $GameWinRateDataState = _$GameWinRateDataStateTearOff();

/// @nodoc
mixin _$GameWinRateDataState {
  List<WinRateData>? get winRateDataList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameWinRateDataStateCopyWith<GameWinRateDataState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameWinRateDataStateCopyWith<$Res> {
  factory $GameWinRateDataStateCopyWith(GameWinRateDataState value,
          $Res Function(GameWinRateDataState) then) =
      _$GameWinRateDataStateCopyWithImpl<$Res>;
  $Res call({List<WinRateData>? winRateDataList});
}

/// @nodoc
class _$GameWinRateDataStateCopyWithImpl<$Res>
    implements $GameWinRateDataStateCopyWith<$Res> {
  _$GameWinRateDataStateCopyWithImpl(this._value, this._then);

  final GameWinRateDataState _value;
  // ignore: unused_field
  final $Res Function(GameWinRateDataState) _then;

  @override
  $Res call({
    Object? winRateDataList = freezed,
  }) {
    return _then(_value.copyWith(
      winRateDataList: winRateDataList == freezed
          ? _value.winRateDataList
          : winRateDataList // ignore: cast_nullable_to_non_nullable
              as List<WinRateData>?,
    ));
  }
}

/// @nodoc
abstract class _$GameWinRateDataStateCopyWith<$Res>
    implements $GameWinRateDataStateCopyWith<$Res> {
  factory _$GameWinRateDataStateCopyWith(_GameWinRateDataState value,
          $Res Function(_GameWinRateDataState) then) =
      __$GameWinRateDataStateCopyWithImpl<$Res>;
  @override
  $Res call({List<WinRateData>? winRateDataList});
}

/// @nodoc
class __$GameWinRateDataStateCopyWithImpl<$Res>
    extends _$GameWinRateDataStateCopyWithImpl<$Res>
    implements _$GameWinRateDataStateCopyWith<$Res> {
  __$GameWinRateDataStateCopyWithImpl(
      _GameWinRateDataState _value, $Res Function(_GameWinRateDataState) _then)
      : super(_value, (v) => _then(v as _GameWinRateDataState));

  @override
  _GameWinRateDataState get _value => super._value as _GameWinRateDataState;

  @override
  $Res call({
    Object? winRateDataList = freezed,
  }) {
    return _then(_GameWinRateDataState(
      winRateDataList: winRateDataList == freezed
          ? _value.winRateDataList
          : winRateDataList // ignore: cast_nullable_to_non_nullable
              as List<WinRateData>?,
    ));
  }
}

/// @nodoc

class _$_GameWinRateDataState implements _GameWinRateDataState {
  _$_GameWinRateDataState({this.winRateDataList});

  @override
  final List<WinRateData>? winRateDataList;

  @override
  String toString() {
    return 'GameWinRateDataState(winRateDataList: $winRateDataList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GameWinRateDataState &&
            const DeepCollectionEquality()
                .equals(other.winRateDataList, winRateDataList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(winRateDataList));

  @JsonKey(ignore: true)
  @override
  _$GameWinRateDataStateCopyWith<_GameWinRateDataState> get copyWith =>
      __$GameWinRateDataStateCopyWithImpl<_GameWinRateDataState>(
          this, _$identity);
}

abstract class _GameWinRateDataState implements GameWinRateDataState {
  factory _GameWinRateDataState({List<WinRateData>? winRateDataList}) =
      _$_GameWinRateDataState;

  @override
  List<WinRateData>? get winRateDataList;
  @override
  @JsonKey(ignore: true)
  _$GameWinRateDataStateCopyWith<_GameWinRateDataState> get copyWith =>
      throw _privateConstructorUsedError;
}
