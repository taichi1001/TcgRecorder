// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'deck_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DeckListStateTearOff {
  const _$DeckListStateTearOff();

  _DeckListState call({List<Deck>? allDeckList}) {
    return _DeckListState(
      allDeckList: allDeckList,
    );
  }
}

/// @nodoc
const $DeckListState = _$DeckListStateTearOff();

/// @nodoc
mixin _$DeckListState {
  List<Deck>? get allDeckList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeckListStateCopyWith<DeckListState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeckListStateCopyWith<$Res> {
  factory $DeckListStateCopyWith(DeckListState value, $Res Function(DeckListState) then) =
      _$DeckListStateCopyWithImpl<$Res>;
  $Res call({List<Deck>? allDeckList});
}

/// @nodoc
class _$DeckListStateCopyWithImpl<$Res> implements $DeckListStateCopyWith<$Res> {
  _$DeckListStateCopyWithImpl(this._value, this._then);

  final DeckListState _value;
  // ignore: unused_field
  final $Res Function(DeckListState) _then;

  @override
  $Res call({
    Object? allDeckList = freezed,
  }) {
    return _then(_value.copyWith(
      allDeckList: allDeckList == freezed
          ? _value.allDeckList
          : allDeckList // ignore: cast_nullable_to_non_nullable
              as List<Deck>?,
    ));
  }
}

/// @nodoc
abstract class _$DeckListStateCopyWith<$Res> implements $DeckListStateCopyWith<$Res> {
  factory _$DeckListStateCopyWith(_DeckListState value, $Res Function(_DeckListState) then) =
      __$DeckListStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Deck>? allDeckList});
}

/// @nodoc
class __$DeckListStateCopyWithImpl<$Res> extends _$DeckListStateCopyWithImpl<$Res>
    implements _$DeckListStateCopyWith<$Res> {
  __$DeckListStateCopyWithImpl(_DeckListState _value, $Res Function(_DeckListState) _then)
      : super(_value, (v) => _then(v as _DeckListState));

  @override
  _DeckListState get _value => super._value as _DeckListState;

  @override
  $Res call({
    Object? allDeckList = freezed,
  }) {
    return _then(_DeckListState(
      allDeckList: allDeckList == freezed
          ? _value.allDeckList
          : allDeckList // ignore: cast_nullable_to_non_nullable
              as List<Deck>?,
    ));
  }
}

/// @nodoc

class _$_DeckListState implements _DeckListState {
  _$_DeckListState({this.allDeckList});

  @override
  final List<Deck>? allDeckList;

  @override
  String toString() {
    return 'DeckListState(allDeckList: $allDeckList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeckListState &&
            const DeepCollectionEquality().equals(other.allDeckList, allDeckList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(allDeckList));

  @JsonKey(ignore: true)
  @override
  _$DeckListStateCopyWith<_DeckListState> get copyWith =>
      __$DeckListStateCopyWithImpl<_DeckListState>(this, _$identity);
}

abstract class _DeckListState implements DeckListState {
  factory _DeckListState({List<Deck>? allDeckList}) = _$_DeckListState;

  @override
  List<Deck>? get allDeckList;
  @override
  @JsonKey(ignore: true)
  _$DeckListStateCopyWith<_DeckListState> get copyWith => throw _privateConstructorUsedError;
}
