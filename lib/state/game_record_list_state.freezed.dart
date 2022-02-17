// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game_record_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$GameRecordListStateTearOff {
  const _$GameRecordListStateTearOff();

  _GameRecordListState call({List<Record>? gameRecordList}) {
    return _GameRecordListState(
      gameRecordList: gameRecordList,
    );
  }
}

/// @nodoc
const $GameRecordListState = _$GameRecordListStateTearOff();

/// @nodoc
mixin _$GameRecordListState {
  List<Record>? get gameRecordList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameRecordListStateCopyWith<GameRecordListState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameRecordListStateCopyWith<$Res> {
  factory $GameRecordListStateCopyWith(GameRecordListState value, $Res Function(GameRecordListState) then) =
      _$GameRecordListStateCopyWithImpl<$Res>;
  $Res call({List<Record>? gameRecordList});
}

/// @nodoc
class _$GameRecordListStateCopyWithImpl<$Res> implements $GameRecordListStateCopyWith<$Res> {
  _$GameRecordListStateCopyWithImpl(this._value, this._then);

  final GameRecordListState _value;
  // ignore: unused_field
  final $Res Function(GameRecordListState) _then;

  @override
  $Res call({
    Object? gameRecordList = freezed,
  }) {
    return _then(_value.copyWith(
      gameRecordList: gameRecordList == freezed
          ? _value.gameRecordList
          : gameRecordList // ignore: cast_nullable_to_non_nullable
              as List<Record>?,
    ));
  }
}

/// @nodoc
abstract class _$GameRecordListStateCopyWith<$Res> implements $GameRecordListStateCopyWith<$Res> {
  factory _$GameRecordListStateCopyWith(_GameRecordListState value, $Res Function(_GameRecordListState) then) =
      __$GameRecordListStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Record>? gameRecordList});
}

/// @nodoc
class __$GameRecordListStateCopyWithImpl<$Res> extends _$GameRecordListStateCopyWithImpl<$Res>
    implements _$GameRecordListStateCopyWith<$Res> {
  __$GameRecordListStateCopyWithImpl(_GameRecordListState _value, $Res Function(_GameRecordListState) _then)
      : super(_value, (v) => _then(v as _GameRecordListState));

  @override
  _GameRecordListState get _value => super._value as _GameRecordListState;

  @override
  $Res call({
    Object? gameRecordList = freezed,
  }) {
    return _then(_GameRecordListState(
      gameRecordList: gameRecordList == freezed
          ? _value.gameRecordList
          : gameRecordList // ignore: cast_nullable_to_non_nullable
              as List<Record>?,
    ));
  }
}

/// @nodoc

class _$_GameRecordListState implements _GameRecordListState {
  _$_GameRecordListState({this.gameRecordList});

  @override
  final List<Record>? gameRecordList;

  @override
  String toString() {
    return 'GameRecordListState(gameRecordList: $gameRecordList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GameRecordListState &&
            const DeepCollectionEquality().equals(other.gameRecordList, gameRecordList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(gameRecordList));

  @JsonKey(ignore: true)
  @override
  _$GameRecordListStateCopyWith<_GameRecordListState> get copyWith =>
      __$GameRecordListStateCopyWithImpl<_GameRecordListState>(this, _$identity);
}

abstract class _GameRecordListState implements GameRecordListState {
  factory _GameRecordListState({List<Record>? gameRecordList}) = _$_GameRecordListState;

  @override
  List<Record>? get gameRecordList;
  @override
  @JsonKey(ignore: true)
  _$GameRecordListStateCopyWith<_GameRecordListState> get copyWith => throw _privateConstructorUsedError;
}
