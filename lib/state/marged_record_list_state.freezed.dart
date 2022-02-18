// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'marged_record_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MargedRecordListStateTearOff {
  const _$MargedRecordListStateTearOff();

  _MargedRecordListState call({List<MargedRecord>? margedRecordList}) {
    return _MargedRecordListState(
      margedRecordList: margedRecordList,
    );
  }
}

/// @nodoc
const $MargedRecordListState = _$MargedRecordListStateTearOff();

/// @nodoc
mixin _$MargedRecordListState {
  List<MargedRecord>? get margedRecordList =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MargedRecordListStateCopyWith<MargedRecordListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MargedRecordListStateCopyWith<$Res> {
  factory $MargedRecordListStateCopyWith(MargedRecordListState value,
          $Res Function(MargedRecordListState) then) =
      _$MargedRecordListStateCopyWithImpl<$Res>;
  $Res call({List<MargedRecord>? margedRecordList});
}

/// @nodoc
class _$MargedRecordListStateCopyWithImpl<$Res>
    implements $MargedRecordListStateCopyWith<$Res> {
  _$MargedRecordListStateCopyWithImpl(this._value, this._then);

  final MargedRecordListState _value;
  // ignore: unused_field
  final $Res Function(MargedRecordListState) _then;

  @override
  $Res call({
    Object? margedRecordList = freezed,
  }) {
    return _then(_value.copyWith(
      margedRecordList: margedRecordList == freezed
          ? _value.margedRecordList
          : margedRecordList // ignore: cast_nullable_to_non_nullable
              as List<MargedRecord>?,
    ));
  }
}

/// @nodoc
abstract class _$MargedRecordListStateCopyWith<$Res>
    implements $MargedRecordListStateCopyWith<$Res> {
  factory _$MargedRecordListStateCopyWith(_MargedRecordListState value,
          $Res Function(_MargedRecordListState) then) =
      __$MargedRecordListStateCopyWithImpl<$Res>;
  @override
  $Res call({List<MargedRecord>? margedRecordList});
}

/// @nodoc
class __$MargedRecordListStateCopyWithImpl<$Res>
    extends _$MargedRecordListStateCopyWithImpl<$Res>
    implements _$MargedRecordListStateCopyWith<$Res> {
  __$MargedRecordListStateCopyWithImpl(_MargedRecordListState _value,
      $Res Function(_MargedRecordListState) _then)
      : super(_value, (v) => _then(v as _MargedRecordListState));

  @override
  _MargedRecordListState get _value => super._value as _MargedRecordListState;

  @override
  $Res call({
    Object? margedRecordList = freezed,
  }) {
    return _then(_MargedRecordListState(
      margedRecordList: margedRecordList == freezed
          ? _value.margedRecordList
          : margedRecordList // ignore: cast_nullable_to_non_nullable
              as List<MargedRecord>?,
    ));
  }
}

/// @nodoc

class _$_MargedRecordListState implements _MargedRecordListState {
  _$_MargedRecordListState({this.margedRecordList});

  @override
  final List<MargedRecord>? margedRecordList;

  @override
  String toString() {
    return 'MargedRecordListState(margedRecordList: $margedRecordList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MargedRecordListState &&
            const DeepCollectionEquality()
                .equals(other.margedRecordList, margedRecordList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(margedRecordList));

  @JsonKey(ignore: true)
  @override
  _$MargedRecordListStateCopyWith<_MargedRecordListState> get copyWith =>
      __$MargedRecordListStateCopyWithImpl<_MargedRecordListState>(
          this, _$identity);
}

abstract class _MargedRecordListState implements MargedRecordListState {
  factory _MargedRecordListState({List<MargedRecord>? margedRecordList}) =
      _$_MargedRecordListState;

  @override
  List<MargedRecord>? get margedRecordList;
  @override
  @JsonKey(ignore: true)
  _$MargedRecordListStateCopyWith<_MargedRecordListState> get copyWith =>
      throw _privateConstructorUsedError;
}
