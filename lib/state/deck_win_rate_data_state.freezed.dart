// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'deck_win_rate_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DeckWinRateDataStateTearOff {
  const _$DeckWinRateDataStateTearOff();

  _DeckWinRateDataState call({List<WinRateData>? winRateDataList}) {
    return _DeckWinRateDataState(
      winRateDataList: winRateDataList,
    );
  }
}

/// @nodoc
const $DeckWinRateDataState = _$DeckWinRateDataStateTearOff();

/// @nodoc
mixin _$DeckWinRateDataState {
  List<WinRateData>? get winRateDataList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeckWinRateDataStateCopyWith<DeckWinRateDataState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeckWinRateDataStateCopyWith<$Res> {
  factory $DeckWinRateDataStateCopyWith(DeckWinRateDataState value, $Res Function(DeckWinRateDataState) then) =
      _$DeckWinRateDataStateCopyWithImpl<$Res>;
  $Res call({List<WinRateData>? winRateDataList});
}

/// @nodoc
class _$DeckWinRateDataStateCopyWithImpl<$Res> implements $DeckWinRateDataStateCopyWith<$Res> {
  _$DeckWinRateDataStateCopyWithImpl(this._value, this._then);

  final DeckWinRateDataState _value;
  // ignore: unused_field
  final $Res Function(DeckWinRateDataState) _then;

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
abstract class _$DeckWinRateDataStateCopyWith<$Res> implements $DeckWinRateDataStateCopyWith<$Res> {
  factory _$DeckWinRateDataStateCopyWith(_DeckWinRateDataState value, $Res Function(_DeckWinRateDataState) then) =
      __$DeckWinRateDataStateCopyWithImpl<$Res>;
  @override
  $Res call({List<WinRateData>? winRateDataList});
}

/// @nodoc
class __$DeckWinRateDataStateCopyWithImpl<$Res> extends _$DeckWinRateDataStateCopyWithImpl<$Res>
    implements _$DeckWinRateDataStateCopyWith<$Res> {
  __$DeckWinRateDataStateCopyWithImpl(_DeckWinRateDataState _value, $Res Function(_DeckWinRateDataState) _then)
      : super(_value, (v) => _then(v as _DeckWinRateDataState));

  @override
  _DeckWinRateDataState get _value => super._value as _DeckWinRateDataState;

  @override
  $Res call({
    Object? winRateDataList = freezed,
  }) {
    return _then(_DeckWinRateDataState(
      winRateDataList: winRateDataList == freezed
          ? _value.winRateDataList
          : winRateDataList // ignore: cast_nullable_to_non_nullable
              as List<WinRateData>?,
    ));
  }
}

/// @nodoc

class _$_DeckWinRateDataState implements _DeckWinRateDataState {
  _$_DeckWinRateDataState({this.winRateDataList});

  @override
  final List<WinRateData>? winRateDataList;

  @override
  String toString() {
    return 'DeckWinRateDataState(winRateDataList: $winRateDataList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeckWinRateDataState &&
            const DeepCollectionEquality().equals(other.winRateDataList, winRateDataList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(winRateDataList));

  @JsonKey(ignore: true)
  @override
  _$DeckWinRateDataStateCopyWith<_DeckWinRateDataState> get copyWith =>
      __$DeckWinRateDataStateCopyWithImpl<_DeckWinRateDataState>(this, _$identity);
}

abstract class _DeckWinRateDataState implements DeckWinRateDataState {
  factory _DeckWinRateDataState({List<WinRateData>? winRateDataList}) = _$_DeckWinRateDataState;

  @override
  List<WinRateData>? get winRateDataList;
  @override
  @JsonKey(ignore: true)
  _$DeckWinRateDataStateCopyWith<_DeckWinRateDataState> get copyWith => throw _privateConstructorUsedError;
}
