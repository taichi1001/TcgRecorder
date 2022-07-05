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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DeckListState {
  List<Deck>? get allDeckList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeckListStateCopyWith<DeckListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeckListStateCopyWith<$Res> {
  factory $DeckListStateCopyWith(
          DeckListState value, $Res Function(DeckListState) then) =
      _$DeckListStateCopyWithImpl<$Res>;
  $Res call({List<Deck>? allDeckList});
}

/// @nodoc
class _$DeckListStateCopyWithImpl<$Res>
    implements $DeckListStateCopyWith<$Res> {
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
abstract class _$$_DeckListStateCopyWith<$Res>
    implements $DeckListStateCopyWith<$Res> {
  factory _$$_DeckListStateCopyWith(
          _$_DeckListState value, $Res Function(_$_DeckListState) then) =
      __$$_DeckListStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Deck>? allDeckList});
}

/// @nodoc
class __$$_DeckListStateCopyWithImpl<$Res>
    extends _$DeckListStateCopyWithImpl<$Res>
    implements _$$_DeckListStateCopyWith<$Res> {
  __$$_DeckListStateCopyWithImpl(
      _$_DeckListState _value, $Res Function(_$_DeckListState) _then)
      : super(_value, (v) => _then(v as _$_DeckListState));

  @override
  _$_DeckListState get _value => super._value as _$_DeckListState;

  @override
  $Res call({
    Object? allDeckList = freezed,
  }) {
    return _then(_$_DeckListState(
      allDeckList: allDeckList == freezed
          ? _value._allDeckList
          : allDeckList // ignore: cast_nullable_to_non_nullable
              as List<Deck>?,
    ));
  }
}

/// @nodoc

class _$_DeckListState implements _DeckListState {
  _$_DeckListState({final List<Deck>? allDeckList})
      : _allDeckList = allDeckList;

  final List<Deck>? _allDeckList;
  @override
  List<Deck>? get allDeckList {
    final value = _allDeckList;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'DeckListState(allDeckList: $allDeckList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeckListState &&
            const DeepCollectionEquality()
                .equals(other._allDeckList, _allDeckList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_allDeckList));

  @JsonKey(ignore: true)
  @override
  _$$_DeckListStateCopyWith<_$_DeckListState> get copyWith =>
      __$$_DeckListStateCopyWithImpl<_$_DeckListState>(this, _$identity);
}

abstract class _DeckListState implements DeckListState {
  factory _DeckListState({final List<Deck>? allDeckList}) = _$_DeckListState;

  @override
  List<Deck>? get allDeckList => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_DeckListStateCopyWith<_$_DeckListState> get copyWith =>
      throw _privateConstructorUsedError;
}
