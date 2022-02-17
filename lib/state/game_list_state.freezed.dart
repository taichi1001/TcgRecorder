// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$GameListStateTearOff {
  const _$GameListStateTearOff();

  _GameListState call({List<Game>? allGameList}) {
    return _GameListState(
      allGameList: allGameList,
    );
  }
}

/// @nodoc
const $GameListState = _$GameListStateTearOff();

/// @nodoc
mixin _$GameListState {
  List<Game>? get allGameList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameListStateCopyWith<GameListState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameListStateCopyWith<$Res> {
  factory $GameListStateCopyWith(GameListState value, $Res Function(GameListState) then) = _$GameListStateCopyWithImpl<$Res>;
  $Res call({List<Game>? allGameList});
}

/// @nodoc
class _$GameListStateCopyWithImpl<$Res> implements $GameListStateCopyWith<$Res> {
  _$GameListStateCopyWithImpl(this._value, this._then);

  final GameListState _value;
  // ignore: unused_field
  final $Res Function(GameListState) _then;

  @override
  $Res call({
    Object? allGameList = freezed,
  }) {
    return _then(_value.copyWith(
      allGameList: allGameList == freezed
          ? _value.allGameList
          : allGameList // ignore: cast_nullable_to_non_nullable
              as List<Game>?,
    ));
  }
}

/// @nodoc
abstract class _$GameListStateCopyWith<$Res> implements $GameListStateCopyWith<$Res> {
  factory _$GameListStateCopyWith(_GameListState value, $Res Function(_GameListState) then) = __$GameListStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Game>? allGameList});
}

/// @nodoc
class __$GameListStateCopyWithImpl<$Res> extends _$GameListStateCopyWithImpl<$Res> implements _$GameListStateCopyWith<$Res> {
  __$GameListStateCopyWithImpl(_GameListState _value, $Res Function(_GameListState) _then)
      : super(_value, (v) => _then(v as _GameListState));

  @override
  _GameListState get _value => super._value as _GameListState;

  @override
  $Res call({
    Object? allGameList = freezed,
  }) {
    return _then(_GameListState(
      allGameList: allGameList == freezed
          ? _value.allGameList
          : allGameList // ignore: cast_nullable_to_non_nullable
              as List<Game>?,
    ));
  }
}

/// @nodoc

class _$_GameListState implements _GameListState {
  _$_GameListState({this.allGameList});

  @override
  final List<Game>? allGameList;

  @override
  String toString() {
    return 'GameListState(allGameList: $allGameList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GameListState &&
            const DeepCollectionEquality().equals(other.allGameList, allGameList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(allGameList));

  @JsonKey(ignore: true)
  @override
  _$GameListStateCopyWith<_GameListState> get copyWith => __$GameListStateCopyWithImpl<_GameListState>(this, _$identity);
}

abstract class _GameListState implements GameListState {
  factory _GameListState({List<Game>? allGameList}) = _$_GameListState;

  @override
  List<Game>? get allGameList;
  @override
  @JsonKey(ignore: true)
  _$GameListStateCopyWith<_GameListState> get copyWith => throw _privateConstructorUsedError;
}
