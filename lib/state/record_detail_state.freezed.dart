// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'record_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RecordDetailStateTearOff {
  const _$RecordDetailStateTearOff();

  _RecordDetailState call(
      {bool isEdit = false,
      required Record record,
      required MargedRecord margedRecord,
      required MargedRecord editMargedRecord,
      DateTime? cacheDate}) {
    return _RecordDetailState(
      isEdit: isEdit,
      record: record,
      margedRecord: margedRecord,
      editMargedRecord: editMargedRecord,
      cacheDate: cacheDate,
    );
  }
}

/// @nodoc
const $RecordDetailState = _$RecordDetailStateTearOff();

/// @nodoc
mixin _$RecordDetailState {
  bool get isEdit => throw _privateConstructorUsedError;
  Record get record => throw _privateConstructorUsedError;
  MargedRecord get margedRecord => throw _privateConstructorUsedError;
  MargedRecord get editMargedRecord => throw _privateConstructorUsedError;
  DateTime? get cacheDate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecordDetailStateCopyWith<RecordDetailState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordDetailStateCopyWith<$Res> {
  factory $RecordDetailStateCopyWith(RecordDetailState value, $Res Function(RecordDetailState) then) =
      _$RecordDetailStateCopyWithImpl<$Res>;
  $Res call({bool isEdit, Record record, MargedRecord margedRecord, MargedRecord editMargedRecord, DateTime? cacheDate});

  $RecordCopyWith<$Res> get record;
  $MargedRecordCopyWith<$Res> get margedRecord;
  $MargedRecordCopyWith<$Res> get editMargedRecord;
}

/// @nodoc
class _$RecordDetailStateCopyWithImpl<$Res> implements $RecordDetailStateCopyWith<$Res> {
  _$RecordDetailStateCopyWithImpl(this._value, this._then);

  final RecordDetailState _value;
  // ignore: unused_field
  final $Res Function(RecordDetailState) _then;

  @override
  $Res call({
    Object? isEdit = freezed,
    Object? record = freezed,
    Object? margedRecord = freezed,
    Object? editMargedRecord = freezed,
    Object? cacheDate = freezed,
  }) {
    return _then(_value.copyWith(
      isEdit: isEdit == freezed
          ? _value.isEdit
          : isEdit // ignore: cast_nullable_to_non_nullable
              as bool,
      record: record == freezed
          ? _value.record
          : record // ignore: cast_nullable_to_non_nullable
              as Record,
      margedRecord: margedRecord == freezed
          ? _value.margedRecord
          : margedRecord // ignore: cast_nullable_to_non_nullable
              as MargedRecord,
      editMargedRecord: editMargedRecord == freezed
          ? _value.editMargedRecord
          : editMargedRecord // ignore: cast_nullable_to_non_nullable
              as MargedRecord,
      cacheDate: cacheDate == freezed
          ? _value.cacheDate
          : cacheDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  @override
  $RecordCopyWith<$Res> get record {
    return $RecordCopyWith<$Res>(_value.record, (value) {
      return _then(_value.copyWith(record: value));
    });
  }

  @override
  $MargedRecordCopyWith<$Res> get margedRecord {
    return $MargedRecordCopyWith<$Res>(_value.margedRecord, (value) {
      return _then(_value.copyWith(margedRecord: value));
    });
  }

  @override
  $MargedRecordCopyWith<$Res> get editMargedRecord {
    return $MargedRecordCopyWith<$Res>(_value.editMargedRecord, (value) {
      return _then(_value.copyWith(editMargedRecord: value));
    });
  }
}

/// @nodoc
abstract class _$RecordDetailStateCopyWith<$Res> implements $RecordDetailStateCopyWith<$Res> {
  factory _$RecordDetailStateCopyWith(_RecordDetailState value, $Res Function(_RecordDetailState) then) =
      __$RecordDetailStateCopyWithImpl<$Res>;
  @override
  $Res call({bool isEdit, Record record, MargedRecord margedRecord, MargedRecord editMargedRecord, DateTime? cacheDate});

  @override
  $RecordCopyWith<$Res> get record;
  @override
  $MargedRecordCopyWith<$Res> get margedRecord;
  @override
  $MargedRecordCopyWith<$Res> get editMargedRecord;
}

/// @nodoc
class __$RecordDetailStateCopyWithImpl<$Res> extends _$RecordDetailStateCopyWithImpl<$Res> implements _$RecordDetailStateCopyWith<$Res> {
  __$RecordDetailStateCopyWithImpl(_RecordDetailState _value, $Res Function(_RecordDetailState) _then)
      : super(_value, (v) => _then(v as _RecordDetailState));

  @override
  _RecordDetailState get _value => super._value as _RecordDetailState;

  @override
  $Res call({
    Object? isEdit = freezed,
    Object? record = freezed,
    Object? margedRecord = freezed,
    Object? editMargedRecord = freezed,
    Object? cacheDate = freezed,
  }) {
    return _then(_RecordDetailState(
      isEdit: isEdit == freezed
          ? _value.isEdit
          : isEdit // ignore: cast_nullable_to_non_nullable
              as bool,
      record: record == freezed
          ? _value.record
          : record // ignore: cast_nullable_to_non_nullable
              as Record,
      margedRecord: margedRecord == freezed
          ? _value.margedRecord
          : margedRecord // ignore: cast_nullable_to_non_nullable
              as MargedRecord,
      editMargedRecord: editMargedRecord == freezed
          ? _value.editMargedRecord
          : editMargedRecord // ignore: cast_nullable_to_non_nullable
              as MargedRecord,
      cacheDate: cacheDate == freezed
          ? _value.cacheDate
          : cacheDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$_RecordDetailState implements _RecordDetailState {
  _$_RecordDetailState(
      {this.isEdit = false, required this.record, required this.margedRecord, required this.editMargedRecord, this.cacheDate});

  @JsonKey()
  @override
  final bool isEdit;
  @override
  final Record record;
  @override
  final MargedRecord margedRecord;
  @override
  final MargedRecord editMargedRecord;
  @override
  final DateTime? cacheDate;

  @override
  String toString() {
    return 'RecordDetailState(isEdit: $isEdit, record: $record, margedRecord: $margedRecord, editMargedRecord: $editMargedRecord, cacheDate: $cacheDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecordDetailState &&
            const DeepCollectionEquality().equals(other.isEdit, isEdit) &&
            const DeepCollectionEquality().equals(other.record, record) &&
            const DeepCollectionEquality().equals(other.margedRecord, margedRecord) &&
            const DeepCollectionEquality().equals(other.editMargedRecord, editMargedRecord) &&
            const DeepCollectionEquality().equals(other.cacheDate, cacheDate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isEdit),
      const DeepCollectionEquality().hash(record),
      const DeepCollectionEquality().hash(margedRecord),
      const DeepCollectionEquality().hash(editMargedRecord),
      const DeepCollectionEquality().hash(cacheDate));

  @JsonKey(ignore: true)
  @override
  _$RecordDetailStateCopyWith<_RecordDetailState> get copyWith => __$RecordDetailStateCopyWithImpl<_RecordDetailState>(this, _$identity);
}

abstract class _RecordDetailState implements RecordDetailState {
  factory _RecordDetailState(
      {bool isEdit,
      required Record record,
      required MargedRecord margedRecord,
      required MargedRecord editMargedRecord,
      DateTime? cacheDate}) = _$_RecordDetailState;

  @override
  bool get isEdit;
  @override
  Record get record;
  @override
  MargedRecord get margedRecord;
  @override
  MargedRecord get editMargedRecord;
  @override
  DateTime? get cacheDate;
  @override
  @JsonKey(ignore: true)
  _$RecordDetailStateCopyWith<_RecordDetailState> get copyWith => throw _privateConstructorUsedError;
}
