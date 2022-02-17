// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'record_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RecordListStateTearOff {
  const _$RecordListStateTearOff();

  _RecordListState call({List<Record>? allRecordList, bool isLoaded = false}) {
    return _RecordListState(
      allRecordList: allRecordList,
      isLoaded: isLoaded,
    );
  }
}

/// @nodoc
const $RecordListState = _$RecordListStateTearOff();

/// @nodoc
mixin _$RecordListState {
  List<Record>? get allRecordList => throw _privateConstructorUsedError;
  bool get isLoaded => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecordListStateCopyWith<RecordListState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordListStateCopyWith<$Res> {
  factory $RecordListStateCopyWith(RecordListState value, $Res Function(RecordListState) then) = _$RecordListStateCopyWithImpl<$Res>;
  $Res call({List<Record>? allRecordList, bool isLoaded});
}

/// @nodoc
class _$RecordListStateCopyWithImpl<$Res> implements $RecordListStateCopyWith<$Res> {
  _$RecordListStateCopyWithImpl(this._value, this._then);

  final RecordListState _value;
  // ignore: unused_field
  final $Res Function(RecordListState) _then;

  @override
  $Res call({
    Object? allRecordList = freezed,
    Object? isLoaded = freezed,
  }) {
    return _then(_value.copyWith(
      allRecordList: allRecordList == freezed
          ? _value.allRecordList
          : allRecordList // ignore: cast_nullable_to_non_nullable
              as List<Record>?,
      isLoaded: isLoaded == freezed
          ? _value.isLoaded
          : isLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$RecordListStateCopyWith<$Res> implements $RecordListStateCopyWith<$Res> {
  factory _$RecordListStateCopyWith(_RecordListState value, $Res Function(_RecordListState) then) = __$RecordListStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Record>? allRecordList, bool isLoaded});
}

/// @nodoc
class __$RecordListStateCopyWithImpl<$Res> extends _$RecordListStateCopyWithImpl<$Res> implements _$RecordListStateCopyWith<$Res> {
  __$RecordListStateCopyWithImpl(_RecordListState _value, $Res Function(_RecordListState) _then)
      : super(_value, (v) => _then(v as _RecordListState));

  @override
  _RecordListState get _value => super._value as _RecordListState;

  @override
  $Res call({
    Object? allRecordList = freezed,
    Object? isLoaded = freezed,
  }) {
    return _then(_RecordListState(
      allRecordList: allRecordList == freezed
          ? _value.allRecordList
          : allRecordList // ignore: cast_nullable_to_non_nullable
              as List<Record>?,
      isLoaded: isLoaded == freezed
          ? _value.isLoaded
          : isLoaded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_RecordListState implements _RecordListState {
  _$_RecordListState({this.allRecordList, this.isLoaded = false});

  @override
  final List<Record>? allRecordList;
  @JsonKey()
  @override
  final bool isLoaded;

  @override
  String toString() {
    return 'RecordListState(allRecordList: $allRecordList, isLoaded: $isLoaded)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecordListState &&
            const DeepCollectionEquality().equals(other.allRecordList, allRecordList) &&
            const DeepCollectionEquality().equals(other.isLoaded, isLoaded));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(allRecordList), const DeepCollectionEquality().hash(isLoaded));

  @JsonKey(ignore: true)
  @override
  _$RecordListStateCopyWith<_RecordListState> get copyWith => __$RecordListStateCopyWithImpl<_RecordListState>(this, _$identity);
}

abstract class _RecordListState implements RecordListState {
  factory _RecordListState({List<Record>? allRecordList, bool isLoaded}) = _$_RecordListState;

  @override
  List<Record>? get allRecordList;
  @override
  bool get isLoaded;
  @override
  @JsonKey(ignore: true)
  _$RecordListStateCopyWith<_RecordListState> get copyWith => throw _privateConstructorUsedError;
}
