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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RecordListViewState {
  Sort get sort => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  DateTime? get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  Deck? get useDeck => throw _privateConstructorUsedError;
  Deck? get opponentDeck => throw _privateConstructorUsedError;
  List<Tag> get tagList => throw _privateConstructorUsedError;
  Sort get cacheOrder => throw _privateConstructorUsedError;
  DateTime? get cacheStartDate => throw _privateConstructorUsedError;
  DateTime? get cacheEndDate => throw _privateConstructorUsedError;

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
      List<Tag> tagList,
      Sort cacheOrder,
      DateTime? cacheStartDate,
      DateTime? cacheEndDate});

  $DeckCopyWith<$Res>? get useDeck;
  $DeckCopyWith<$Res>? get opponentDeck;
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
    Object? tagList = null,
    Object? cacheOrder = null,
    Object? cacheStartDate = freezed,
    Object? cacheEndDate = freezed,
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
      tagList: null == tagList
          ? _value.tagList
          : tagList // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
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
}

/// @nodoc
abstract class _$$RecordListViewStateImplCopyWith<$Res>
    implements $RecordListViewStateCopyWith<$Res> {
  factory _$$RecordListViewStateImplCopyWith(_$RecordListViewStateImpl value,
          $Res Function(_$RecordListViewStateImpl) then) =
      __$$RecordListViewStateImplCopyWithImpl<$Res>;
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
      List<Tag> tagList,
      Sort cacheOrder,
      DateTime? cacheStartDate,
      DateTime? cacheEndDate});

  @override
  $DeckCopyWith<$Res>? get useDeck;
  @override
  $DeckCopyWith<$Res>? get opponentDeck;
}

/// @nodoc
class __$$RecordListViewStateImplCopyWithImpl<$Res>
    extends _$RecordListViewStateCopyWithImpl<$Res, _$RecordListViewStateImpl>
    implements _$$RecordListViewStateImplCopyWith<$Res> {
  __$$RecordListViewStateImplCopyWithImpl(_$RecordListViewStateImpl _value,
      $Res Function(_$RecordListViewStateImpl) _then)
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
    Object? tagList = null,
    Object? cacheOrder = null,
    Object? cacheStartDate = freezed,
    Object? cacheEndDate = freezed,
  }) {
    return _then(_$RecordListViewStateImpl(
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
      tagList: null == tagList
          ? _value._tagList
          : tagList // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
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
    ));
  }
}

/// @nodoc

class _$RecordListViewStateImpl implements _RecordListViewState {
  _$RecordListViewStateImpl(
      {this.sort = Sort.newest,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.useDeck,
      this.opponentDeck,
      final List<Tag> tagList = const [],
      this.cacheOrder = Sort.newest,
      this.cacheStartDate,
      this.cacheEndDate})
      : _tagList = tagList;

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
  final List<Tag> _tagList;
  @override
  @JsonKey()
  List<Tag> get tagList {
    if (_tagList is EqualUnmodifiableListView) return _tagList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tagList);
  }

  @override
  @JsonKey()
  final Sort cacheOrder;
  @override
  final DateTime? cacheStartDate;
  @override
  final DateTime? cacheEndDate;

  @override
  String toString() {
    return 'RecordListViewState(sort: $sort, startDate: $startDate, endDate: $endDate, startTime: $startTime, endTime: $endTime, useDeck: $useDeck, opponentDeck: $opponentDeck, tagList: $tagList, cacheOrder: $cacheOrder, cacheStartDate: $cacheStartDate, cacheEndDate: $cacheEndDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordListViewStateImpl &&
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
            const DeepCollectionEquality().equals(other._tagList, _tagList) &&
            (identical(other.cacheOrder, cacheOrder) ||
                other.cacheOrder == cacheOrder) &&
            (identical(other.cacheStartDate, cacheStartDate) ||
                other.cacheStartDate == cacheStartDate) &&
            (identical(other.cacheEndDate, cacheEndDate) ||
                other.cacheEndDate == cacheEndDate));
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
      const DeepCollectionEquality().hash(_tagList),
      cacheOrder,
      cacheStartDate,
      cacheEndDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordListViewStateImplCopyWith<_$RecordListViewStateImpl> get copyWith =>
      __$$RecordListViewStateImplCopyWithImpl<_$RecordListViewStateImpl>(
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
      final List<Tag> tagList,
      final Sort cacheOrder,
      final DateTime? cacheStartDate,
      final DateTime? cacheEndDate}) = _$RecordListViewStateImpl;

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
  List<Tag> get tagList;
  @override
  Sort get cacheOrder;
  @override
  DateTime? get cacheStartDate;
  @override
  DateTime? get cacheEndDate;
  @override
  @JsonKey(ignore: true)
  _$$RecordListViewStateImplCopyWith<_$RecordListViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
