// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RecordDetailState {
  bool get isEdit => throw _privateConstructorUsedError;
  Record get record => throw _privateConstructorUsedError;
  MargedRecord get margedRecord => throw _privateConstructorUsedError;
  MargedRecord get editMargedRecord => throw _privateConstructorUsedError;
  Deck? get cacheUseDeck => throw _privateConstructorUsedError;
  Deck? get cacheOpponentDeck => throw _privateConstructorUsedError;
  Tag? get cacheTag => throw _privateConstructorUsedError;
  DateTime? get cacheDate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecordDetailStateCopyWith<RecordDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordDetailStateCopyWith<$Res> {
  factory $RecordDetailStateCopyWith(
          RecordDetailState value, $Res Function(RecordDetailState) then) =
      _$RecordDetailStateCopyWithImpl<$Res, RecordDetailState>;
  @useResult
  $Res call(
      {bool isEdit,
      Record record,
      MargedRecord margedRecord,
      MargedRecord editMargedRecord,
      Deck? cacheUseDeck,
      Deck? cacheOpponentDeck,
      Tag? cacheTag,
      DateTime? cacheDate});

  $RecordCopyWith<$Res> get record;
  $MargedRecordCopyWith<$Res> get margedRecord;
  $MargedRecordCopyWith<$Res> get editMargedRecord;
  $DeckCopyWith<$Res>? get cacheUseDeck;
  $DeckCopyWith<$Res>? get cacheOpponentDeck;
  $TagCopyWith<$Res>? get cacheTag;
}

/// @nodoc
class _$RecordDetailStateCopyWithImpl<$Res, $Val extends RecordDetailState>
    implements $RecordDetailStateCopyWith<$Res> {
  _$RecordDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEdit = null,
    Object? record = null,
    Object? margedRecord = null,
    Object? editMargedRecord = null,
    Object? cacheUseDeck = freezed,
    Object? cacheOpponentDeck = freezed,
    Object? cacheTag = freezed,
    Object? cacheDate = freezed,
  }) {
    return _then(_value.copyWith(
      isEdit: null == isEdit
          ? _value.isEdit
          : isEdit // ignore: cast_nullable_to_non_nullable
              as bool,
      record: null == record
          ? _value.record
          : record // ignore: cast_nullable_to_non_nullable
              as Record,
      margedRecord: null == margedRecord
          ? _value.margedRecord
          : margedRecord // ignore: cast_nullable_to_non_nullable
              as MargedRecord,
      editMargedRecord: null == editMargedRecord
          ? _value.editMargedRecord
          : editMargedRecord // ignore: cast_nullable_to_non_nullable
              as MargedRecord,
      cacheUseDeck: freezed == cacheUseDeck
          ? _value.cacheUseDeck
          : cacheUseDeck // ignore: cast_nullable_to_non_nullable
              as Deck?,
      cacheOpponentDeck: freezed == cacheOpponentDeck
          ? _value.cacheOpponentDeck
          : cacheOpponentDeck // ignore: cast_nullable_to_non_nullable
              as Deck?,
      cacheTag: freezed == cacheTag
          ? _value.cacheTag
          : cacheTag // ignore: cast_nullable_to_non_nullable
              as Tag?,
      cacheDate: freezed == cacheDate
          ? _value.cacheDate
          : cacheDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RecordCopyWith<$Res> get record {
    return $RecordCopyWith<$Res>(_value.record, (value) {
      return _then(_value.copyWith(record: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MargedRecordCopyWith<$Res> get margedRecord {
    return $MargedRecordCopyWith<$Res>(_value.margedRecord, (value) {
      return _then(_value.copyWith(margedRecord: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MargedRecordCopyWith<$Res> get editMargedRecord {
    return $MargedRecordCopyWith<$Res>(_value.editMargedRecord, (value) {
      return _then(_value.copyWith(editMargedRecord: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DeckCopyWith<$Res>? get cacheUseDeck {
    if (_value.cacheUseDeck == null) {
      return null;
    }

    return $DeckCopyWith<$Res>(_value.cacheUseDeck!, (value) {
      return _then(_value.copyWith(cacheUseDeck: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DeckCopyWith<$Res>? get cacheOpponentDeck {
    if (_value.cacheOpponentDeck == null) {
      return null;
    }

    return $DeckCopyWith<$Res>(_value.cacheOpponentDeck!, (value) {
      return _then(_value.copyWith(cacheOpponentDeck: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TagCopyWith<$Res>? get cacheTag {
    if (_value.cacheTag == null) {
      return null;
    }

    return $TagCopyWith<$Res>(_value.cacheTag!, (value) {
      return _then(_value.copyWith(cacheTag: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RecordDetailStateCopyWith<$Res>
    implements $RecordDetailStateCopyWith<$Res> {
  factory _$$_RecordDetailStateCopyWith(_$_RecordDetailState value,
          $Res Function(_$_RecordDetailState) then) =
      __$$_RecordDetailStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isEdit,
      Record record,
      MargedRecord margedRecord,
      MargedRecord editMargedRecord,
      Deck? cacheUseDeck,
      Deck? cacheOpponentDeck,
      Tag? cacheTag,
      DateTime? cacheDate});

  @override
  $RecordCopyWith<$Res> get record;
  @override
  $MargedRecordCopyWith<$Res> get margedRecord;
  @override
  $MargedRecordCopyWith<$Res> get editMargedRecord;
  @override
  $DeckCopyWith<$Res>? get cacheUseDeck;
  @override
  $DeckCopyWith<$Res>? get cacheOpponentDeck;
  @override
  $TagCopyWith<$Res>? get cacheTag;
}

/// @nodoc
class __$$_RecordDetailStateCopyWithImpl<$Res>
    extends _$RecordDetailStateCopyWithImpl<$Res, _$_RecordDetailState>
    implements _$$_RecordDetailStateCopyWith<$Res> {
  __$$_RecordDetailStateCopyWithImpl(
      _$_RecordDetailState _value, $Res Function(_$_RecordDetailState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEdit = null,
    Object? record = null,
    Object? margedRecord = null,
    Object? editMargedRecord = null,
    Object? cacheUseDeck = freezed,
    Object? cacheOpponentDeck = freezed,
    Object? cacheTag = freezed,
    Object? cacheDate = freezed,
  }) {
    return _then(_$_RecordDetailState(
      isEdit: null == isEdit
          ? _value.isEdit
          : isEdit // ignore: cast_nullable_to_non_nullable
              as bool,
      record: null == record
          ? _value.record
          : record // ignore: cast_nullable_to_non_nullable
              as Record,
      margedRecord: null == margedRecord
          ? _value.margedRecord
          : margedRecord // ignore: cast_nullable_to_non_nullable
              as MargedRecord,
      editMargedRecord: null == editMargedRecord
          ? _value.editMargedRecord
          : editMargedRecord // ignore: cast_nullable_to_non_nullable
              as MargedRecord,
      cacheUseDeck: freezed == cacheUseDeck
          ? _value.cacheUseDeck
          : cacheUseDeck // ignore: cast_nullable_to_non_nullable
              as Deck?,
      cacheOpponentDeck: freezed == cacheOpponentDeck
          ? _value.cacheOpponentDeck
          : cacheOpponentDeck // ignore: cast_nullable_to_non_nullable
              as Deck?,
      cacheTag: freezed == cacheTag
          ? _value.cacheTag
          : cacheTag // ignore: cast_nullable_to_non_nullable
              as Tag?,
      cacheDate: freezed == cacheDate
          ? _value.cacheDate
          : cacheDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$_RecordDetailState implements _RecordDetailState {
  _$_RecordDetailState(
      {this.isEdit = false,
      required this.record,
      required this.margedRecord,
      required this.editMargedRecord,
      this.cacheUseDeck,
      this.cacheOpponentDeck,
      this.cacheTag,
      this.cacheDate});

  @override
  @JsonKey()
  final bool isEdit;
  @override
  final Record record;
  @override
  final MargedRecord margedRecord;
  @override
  final MargedRecord editMargedRecord;
  @override
  final Deck? cacheUseDeck;
  @override
  final Deck? cacheOpponentDeck;
  @override
  final Tag? cacheTag;
  @override
  final DateTime? cacheDate;

  @override
  String toString() {
    return 'RecordDetailState(isEdit: $isEdit, record: $record, margedRecord: $margedRecord, editMargedRecord: $editMargedRecord, cacheUseDeck: $cacheUseDeck, cacheOpponentDeck: $cacheOpponentDeck, cacheTag: $cacheTag, cacheDate: $cacheDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecordDetailState &&
            (identical(other.isEdit, isEdit) || other.isEdit == isEdit) &&
            (identical(other.record, record) || other.record == record) &&
            (identical(other.margedRecord, margedRecord) ||
                other.margedRecord == margedRecord) &&
            (identical(other.editMargedRecord, editMargedRecord) ||
                other.editMargedRecord == editMargedRecord) &&
            (identical(other.cacheUseDeck, cacheUseDeck) ||
                other.cacheUseDeck == cacheUseDeck) &&
            (identical(other.cacheOpponentDeck, cacheOpponentDeck) ||
                other.cacheOpponentDeck == cacheOpponentDeck) &&
            (identical(other.cacheTag, cacheTag) ||
                other.cacheTag == cacheTag) &&
            (identical(other.cacheDate, cacheDate) ||
                other.cacheDate == cacheDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isEdit, record, margedRecord,
      editMargedRecord, cacheUseDeck, cacheOpponentDeck, cacheTag, cacheDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecordDetailStateCopyWith<_$_RecordDetailState> get copyWith =>
      __$$_RecordDetailStateCopyWithImpl<_$_RecordDetailState>(
          this, _$identity);
}

abstract class _RecordDetailState implements RecordDetailState {
  factory _RecordDetailState(
      {final bool isEdit,
      required final Record record,
      required final MargedRecord margedRecord,
      required final MargedRecord editMargedRecord,
      final Deck? cacheUseDeck,
      final Deck? cacheOpponentDeck,
      final Tag? cacheTag,
      final DateTime? cacheDate}) = _$_RecordDetailState;

  @override
  bool get isEdit;
  @override
  Record get record;
  @override
  MargedRecord get margedRecord;
  @override
  MargedRecord get editMargedRecord;
  @override
  Deck? get cacheUseDeck;
  @override
  Deck? get cacheOpponentDeck;
  @override
  Tag? get cacheTag;
  @override
  DateTime? get cacheDate;
  @override
  @JsonKey(ignore: true)
  _$$_RecordDetailStateCopyWith<_$_RecordDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}
