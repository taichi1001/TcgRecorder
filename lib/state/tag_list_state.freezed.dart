// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tag_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TagListStateTearOff {
  const _$TagListStateTearOff();

  _TagListState call({List<Tag>? allTagList}) {
    return _TagListState(
      allTagList: allTagList,
    );
  }
}

/// @nodoc
const $TagListState = _$TagListStateTearOff();

/// @nodoc
mixin _$TagListState {
  List<Tag>? get allTagList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TagListStateCopyWith<TagListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagListStateCopyWith<$Res> {
  factory $TagListStateCopyWith(
          TagListState value, $Res Function(TagListState) then) =
      _$TagListStateCopyWithImpl<$Res>;
  $Res call({List<Tag>? allTagList});
}

/// @nodoc
class _$TagListStateCopyWithImpl<$Res> implements $TagListStateCopyWith<$Res> {
  _$TagListStateCopyWithImpl(this._value, this._then);

  final TagListState _value;
  // ignore: unused_field
  final $Res Function(TagListState) _then;

  @override
  $Res call({
    Object? allTagList = freezed,
  }) {
    return _then(_value.copyWith(
      allTagList: allTagList == freezed
          ? _value.allTagList
          : allTagList // ignore: cast_nullable_to_non_nullable
              as List<Tag>?,
    ));
  }
}

/// @nodoc
abstract class _$TagListStateCopyWith<$Res>
    implements $TagListStateCopyWith<$Res> {
  factory _$TagListStateCopyWith(
          _TagListState value, $Res Function(_TagListState) then) =
      __$TagListStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Tag>? allTagList});
}

/// @nodoc
class __$TagListStateCopyWithImpl<$Res> extends _$TagListStateCopyWithImpl<$Res>
    implements _$TagListStateCopyWith<$Res> {
  __$TagListStateCopyWithImpl(
      _TagListState _value, $Res Function(_TagListState) _then)
      : super(_value, (v) => _then(v as _TagListState));

  @override
  _TagListState get _value => super._value as _TagListState;

  @override
  $Res call({
    Object? allTagList = freezed,
  }) {
    return _then(_TagListState(
      allTagList: allTagList == freezed
          ? _value.allTagList
          : allTagList // ignore: cast_nullable_to_non_nullable
              as List<Tag>?,
    ));
  }
}

/// @nodoc

class _$_TagListState implements _TagListState {
  _$_TagListState({this.allTagList});

  @override
  final List<Tag>? allTagList;

  @override
  String toString() {
    return 'TagListState(allTagList: $allTagList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TagListState &&
            const DeepCollectionEquality()
                .equals(other.allTagList, allTagList));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(allTagList));

  @JsonKey(ignore: true)
  @override
  _$TagListStateCopyWith<_TagListState> get copyWith =>
      __$TagListStateCopyWithImpl<_TagListState>(this, _$identity);
}

abstract class _TagListState implements TagListState {
  factory _TagListState({List<Tag>? allTagList}) = _$_TagListState;

  @override
  List<Tag>? get allTagList;
  @override
  @JsonKey(ignore: true)
  _$TagListStateCopyWith<_TagListState> get copyWith =>
      throw _privateConstructorUsedError;
}
