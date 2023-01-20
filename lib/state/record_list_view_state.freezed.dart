// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record_list_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RecordListViewState {
  Sort get sort => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  DateTime? get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  Deck? get useDeck => throw _privateConstructorUsedError;
  Deck? get opponentDeck => throw _privateConstructorUsedError;
  Tag? get tag => throw _privateConstructorUsedError;
  Sort get cacheOrder => throw _privateConstructorUsedError;
  DateTime? get cacheStartDate => throw _privateConstructorUsedError;
  DateTime? get cacheEndDate => throw _privateConstructorUsedError;
  Deck? get cacheUseDeck => throw _privateConstructorUsedError;
  Deck? get cacheOpponentDeck => throw _privateConstructorUsedError;
  Tag? get cacheTag => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecordListViewStateCopyWith<RecordListViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordListViewStateCopyWith<$Res> {
  factory $RecordListViewStateCopyWith(
          RecordListViewState value, $Res Function(RecordListViewState) then) =
      _$RecordListViewStateCopyWithImpl<$Res, RecordListViewState>;
  @useResult
  $Res call(
      {Sort sort,
      DateTime? startDate,
      DateTime? endDate,
      DateTime? startTime,
      DateTime? endTime,
      Deck? useDeck,
      Deck? opponentDeck,
      Tag? tag,
      Sort cacheOrder,
      DateTime? cacheStartDate,
      DateTime? cacheEndDate,
      Deck? cacheUseDeck,
      Deck? cacheOpponentDeck,
      Tag? cacheTag});

  $DeckCopyWith<$Res>? get useDeck;
  $DeckCopyWith<$Res>? get opponentDeck;
  $TagCopyWith<$Res>? get tag;
  $DeckCopyWith<$Res>? get cacheUseDeck;
  $DeckCopyWith<$Res>? get cacheOpponentDeck;
  $TagCopyWith<$Res>? get cacheTag;
}

/// @nodoc
class _$RecordListViewStateCopyWithImpl<$Res, $Val extends RecordListViewState>
    implements $RecordListViewStateCopyWith<$Res> {
  _$RecordListViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sort = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? useDeck = freezed,
    Object? opponentDeck = freezed,
    Object? tag = freezed,
    Object? cacheOrder = null,
    Object? cacheStartDate = freezed,
    Object? cacheEndDate = freezed,
    Object? cacheUseDeck = freezed,
    Object? cacheOpponentDeck = freezed,
    Object? cacheTag = freezed,
  }) {
    return _then(_value.copyWith(
      sort: null == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as Sort,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      useDeck: freezed == useDeck
          ? _value.useDeck
          : useDeck // ignore: cast_nullable_to_non_nullable
              as Deck?,
      opponentDeck: freezed == opponentDeck
          ? _value.opponentDeck
          : opponentDeck // ignore: cast_nullable_to_non_nullable
              as Deck?,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as Tag?,
      cacheOrder: null == cacheOrder
          ? _value.cacheOrder
          : cacheOrder // ignore: cast_nullable_to_non_nullable
              as Sort,
      cacheStartDate: freezed == cacheStartDate
          ? _value.cacheStartDate
          : cacheStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cacheEndDate: freezed == cacheEndDate
          ? _value.cacheEndDate
          : cacheEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DeckCopyWith<$Res>? get useDeck {
    if (_value.useDeck == null) {
      return null;
    }

    return $DeckCopyWith<$Res>(_value.useDeck!, (value) {
      return _then(_value.copyWith(useDeck: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DeckCopyWith<$Res>? get opponentDeck {
    if (_value.opponentDeck == null) {
      return null;
    }

    return $DeckCopyWith<$Res>(_value.opponentDeck!, (value) {
      return _then(_value.copyWith(opponentDeck: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TagCopyWith<$Res>? get tag {
    if (_value.tag == null) {
      return null;
    }

    return $TagCopyWith<$Res>(_value.tag!, (value) {
      return _then(_value.copyWith(tag: value) as $Val);
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
abstract class _$$_RecordListViewStateCopyWith<$Res>
    implements $RecordListViewStateCopyWith<$Res> {
  factory _$$_RecordListViewStateCopyWith(_$_RecordListViewState value,
          $Res Function(_$_RecordListViewState) then) =
      __$$_RecordListViewStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Sort sort,
      DateTime? startDate,
      DateTime? endDate,
      DateTime? startTime,
      DateTime? endTime,
      Deck? useDeck,
      Deck? opponentDeck,
      Tag? tag,
      Sort cacheOrder,
      DateTime? cacheStartDate,
      DateTime? cacheEndDate,
      Deck? cacheUseDeck,
      Deck? cacheOpponentDeck,
      Tag? cacheTag});

  @override
  $DeckCopyWith<$Res>? get useDeck;
  @override
  $DeckCopyWith<$Res>? get opponentDeck;
  @override
  $TagCopyWith<$Res>? get tag;
  @override
  $DeckCopyWith<$Res>? get cacheUseDeck;
  @override
  $DeckCopyWith<$Res>? get cacheOpponentDeck;
  @override
  $TagCopyWith<$Res>? get cacheTag;
}

/// @nodoc
class __$$_RecordListViewStateCopyWithImpl<$Res>
    extends _$RecordListViewStateCopyWithImpl<$Res, _$_RecordListViewState>
    implements _$$_RecordListViewStateCopyWith<$Res> {
  __$$_RecordListViewStateCopyWithImpl(_$_RecordListViewState _value,
      $Res Function(_$_RecordListViewState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sort = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? useDeck = freezed,
    Object? opponentDeck = freezed,
    Object? tag = freezed,
    Object? cacheOrder = null,
    Object? cacheStartDate = freezed,
    Object? cacheEndDate = freezed,
    Object? cacheUseDeck = freezed,
    Object? cacheOpponentDeck = freezed,
    Object? cacheTag = freezed,
  }) {
    return _then(_$_RecordListViewState(
      sort: null == sort
          ? _value.sort
          : sort // ignore: cast_nullable_to_non_nullable
              as Sort,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      useDeck: freezed == useDeck
          ? _value.useDeck
          : useDeck // ignore: cast_nullable_to_non_nullable
              as Deck?,
      opponentDeck: freezed == opponentDeck
          ? _value.opponentDeck
          : opponentDeck // ignore: cast_nullable_to_non_nullable
              as Deck?,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as Tag?,
      cacheOrder: null == cacheOrder
          ? _value.cacheOrder
          : cacheOrder // ignore: cast_nullable_to_non_nullable
              as Sort,
      cacheStartDate: freezed == cacheStartDate
          ? _value.cacheStartDate
          : cacheStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cacheEndDate: freezed == cacheEndDate
          ? _value.cacheEndDate
          : cacheEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
    ));
  }
}

/// @nodoc

class _$_RecordListViewState implements _RecordListViewState {
  _$_RecordListViewState(
      {this.sort = Sort.newest,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.useDeck,
      this.opponentDeck,
      this.tag,
      this.cacheOrder = Sort.newest,
      this.cacheStartDate,
      this.cacheEndDate,
      this.cacheUseDeck,
      this.cacheOpponentDeck,
      this.cacheTag});

  @override
  @JsonKey()
  final Sort sort;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final DateTime? startTime;
  @override
  final DateTime? endTime;
  @override
  final Deck? useDeck;
  @override
  final Deck? opponentDeck;
  @override
  final Tag? tag;
  @override
  @JsonKey()
  final Sort cacheOrder;
  @override
  final DateTime? cacheStartDate;
  @override
  final DateTime? cacheEndDate;
  @override
  final Deck? cacheUseDeck;
  @override
  final Deck? cacheOpponentDeck;
  @override
  final Tag? cacheTag;

  @override
  String toString() {
    return 'RecordListViewState(sort: $sort, startDate: $startDate, endDate: $endDate, startTime: $startTime, endTime: $endTime, useDeck: $useDeck, opponentDeck: $opponentDeck, tag: $tag, cacheOrder: $cacheOrder, cacheStartDate: $cacheStartDate, cacheEndDate: $cacheEndDate, cacheUseDeck: $cacheUseDeck, cacheOpponentDeck: $cacheOpponentDeck, cacheTag: $cacheTag)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecordListViewState &&
            (identical(other.sort, sort) || other.sort == sort) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.useDeck, useDeck) || other.useDeck == useDeck) &&
            (identical(other.opponentDeck, opponentDeck) ||
                other.opponentDeck == opponentDeck) &&
            (identical(other.tag, tag) || other.tag == tag) &&
            (identical(other.cacheOrder, cacheOrder) ||
                other.cacheOrder == cacheOrder) &&
            (identical(other.cacheStartDate, cacheStartDate) ||
                other.cacheStartDate == cacheStartDate) &&
            (identical(other.cacheEndDate, cacheEndDate) ||
                other.cacheEndDate == cacheEndDate) &&
            (identical(other.cacheUseDeck, cacheUseDeck) ||
                other.cacheUseDeck == cacheUseDeck) &&
            (identical(other.cacheOpponentDeck, cacheOpponentDeck) ||
                other.cacheOpponentDeck == cacheOpponentDeck) &&
            (identical(other.cacheTag, cacheTag) ||
                other.cacheTag == cacheTag));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      sort,
      startDate,
      endDate,
      startTime,
      endTime,
      useDeck,
      opponentDeck,
      tag,
      cacheOrder,
      cacheStartDate,
      cacheEndDate,
      cacheUseDeck,
      cacheOpponentDeck,
      cacheTag);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecordListViewStateCopyWith<_$_RecordListViewState> get copyWith =>
      __$$_RecordListViewStateCopyWithImpl<_$_RecordListViewState>(
          this, _$identity);
}

abstract class _RecordListViewState implements RecordListViewState {
  factory _RecordListViewState(
      {final Sort sort,
      final DateTime? startDate,
      final DateTime? endDate,
      final DateTime? startTime,
      final DateTime? endTime,
      final Deck? useDeck,
      final Deck? opponentDeck,
      final Tag? tag,
      final Sort cacheOrder,
      final DateTime? cacheStartDate,
      final DateTime? cacheEndDate,
      final Deck? cacheUseDeck,
      final Deck? cacheOpponentDeck,
      final Tag? cacheTag}) = _$_RecordListViewState;

  @override
  Sort get sort;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  DateTime? get startTime;
  @override
  DateTime? get endTime;
  @override
  Deck? get useDeck;
  @override
  Deck? get opponentDeck;
  @override
  Tag? get tag;
  @override
  Sort get cacheOrder;
  @override
  DateTime? get cacheStartDate;
  @override
  DateTime? get cacheEndDate;
  @override
  Deck? get cacheUseDeck;
  @override
  Deck? get cacheOpponentDeck;
  @override
  Tag? get cacheTag;
  @override
  @JsonKey(ignore: true)
  _$$_RecordListViewStateCopyWith<_$_RecordListViewState> get copyWith =>
      throw _privateConstructorUsedError;
}
