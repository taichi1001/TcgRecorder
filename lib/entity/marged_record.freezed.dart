// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'marged_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MargedRecord {
  Record get record => throw _privateConstructorUsedError;
  String get game => throw _privateConstructorUsedError;
  List<String> get tag => throw _privateConstructorUsedError;
  BO get bo => throw _privateConstructorUsedError;
  String get useDeck => throw _privateConstructorUsedError;
  String get opponentDeck => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  FirstSecond get firstSecond => throw _privateConstructorUsedError;
  FirstSecond? get firstMatchFirstSecond => throw _privateConstructorUsedError;
  FirstSecond? get secondMatchFirstSecond => throw _privateConstructorUsedError;
  FirstSecond? get thirdMatchFirstSecond => throw _privateConstructorUsedError;
  WinLoss get winLoss => throw _privateConstructorUsedError;
  WinLoss? get firstMatchWinLoss => throw _privateConstructorUsedError;
  WinLoss? get secondMatchWinLoss => throw _privateConstructorUsedError;
  WinLoss? get thirdMatchWinLoss => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  List<String>? get imagePaths => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MargedRecordCopyWith<MargedRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MargedRecordCopyWith<$Res> {
  factory $MargedRecordCopyWith(
          MargedRecord value, $Res Function(MargedRecord) then) =
      _$MargedRecordCopyWithImpl<$Res, MargedRecord>;
  @useResult
  $Res call(
      {Record record,
      String game,
      List<String> tag,
      BO bo,
      String useDeck,
      String opponentDeck,
      DateTime date,
      FirstSecond firstSecond,
      FirstSecond? firstMatchFirstSecond,
      FirstSecond? secondMatchFirstSecond,
      FirstSecond? thirdMatchFirstSecond,
      WinLoss winLoss,
      WinLoss? firstMatchWinLoss,
      WinLoss? secondMatchWinLoss,
      WinLoss? thirdMatchWinLoss,
      String? memo,
      List<String>? imagePaths});

  $RecordCopyWith<$Res> get record;
}

/// @nodoc
class _$MargedRecordCopyWithImpl<$Res, $Val extends MargedRecord>
    implements $MargedRecordCopyWith<$Res> {
  _$MargedRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? record = null,
    Object? game = null,
    Object? tag = null,
    Object? bo = null,
    Object? useDeck = null,
    Object? opponentDeck = null,
    Object? date = null,
    Object? firstSecond = null,
    Object? firstMatchFirstSecond = freezed,
    Object? secondMatchFirstSecond = freezed,
    Object? thirdMatchFirstSecond = freezed,
    Object? winLoss = null,
    Object? firstMatchWinLoss = freezed,
    Object? secondMatchWinLoss = freezed,
    Object? thirdMatchWinLoss = freezed,
    Object? memo = freezed,
    Object? imagePaths = freezed,
  }) {
    return _then(_value.copyWith(
      record: null == record
          ? _value.record
          : record // ignore: cast_nullable_to_non_nullable
              as Record,
      game: null == game
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as String,
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as List<String>,
      bo: null == bo
          ? _value.bo
          : bo // ignore: cast_nullable_to_non_nullable
              as BO,
      useDeck: null == useDeck
          ? _value.useDeck
          : useDeck // ignore: cast_nullable_to_non_nullable
              as String,
      opponentDeck: null == opponentDeck
          ? _value.opponentDeck
          : opponentDeck // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      firstSecond: null == firstSecond
          ? _value.firstSecond
          : firstSecond // ignore: cast_nullable_to_non_nullable
              as FirstSecond,
      firstMatchFirstSecond: freezed == firstMatchFirstSecond
          ? _value.firstMatchFirstSecond
          : firstMatchFirstSecond // ignore: cast_nullable_to_non_nullable
              as FirstSecond?,
      secondMatchFirstSecond: freezed == secondMatchFirstSecond
          ? _value.secondMatchFirstSecond
          : secondMatchFirstSecond // ignore: cast_nullable_to_non_nullable
              as FirstSecond?,
      thirdMatchFirstSecond: freezed == thirdMatchFirstSecond
          ? _value.thirdMatchFirstSecond
          : thirdMatchFirstSecond // ignore: cast_nullable_to_non_nullable
              as FirstSecond?,
      winLoss: null == winLoss
          ? _value.winLoss
          : winLoss // ignore: cast_nullable_to_non_nullable
              as WinLoss,
      firstMatchWinLoss: freezed == firstMatchWinLoss
          ? _value.firstMatchWinLoss
          : firstMatchWinLoss // ignore: cast_nullable_to_non_nullable
              as WinLoss?,
      secondMatchWinLoss: freezed == secondMatchWinLoss
          ? _value.secondMatchWinLoss
          : secondMatchWinLoss // ignore: cast_nullable_to_non_nullable
              as WinLoss?,
      thirdMatchWinLoss: freezed == thirdMatchWinLoss
          ? _value.thirdMatchWinLoss
          : thirdMatchWinLoss // ignore: cast_nullable_to_non_nullable
              as WinLoss?,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePaths: freezed == imagePaths
          ? _value.imagePaths
          : imagePaths // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RecordCopyWith<$Res> get record {
    return $RecordCopyWith<$Res>(_value.record, (value) {
      return _then(_value.copyWith(record: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MargedRecordImplCopyWith<$Res>
    implements $MargedRecordCopyWith<$Res> {
  factory _$$MargedRecordImplCopyWith(
          _$MargedRecordImpl value, $Res Function(_$MargedRecordImpl) then) =
      __$$MargedRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Record record,
      String game,
      List<String> tag,
      BO bo,
      String useDeck,
      String opponentDeck,
      DateTime date,
      FirstSecond firstSecond,
      FirstSecond? firstMatchFirstSecond,
      FirstSecond? secondMatchFirstSecond,
      FirstSecond? thirdMatchFirstSecond,
      WinLoss winLoss,
      WinLoss? firstMatchWinLoss,
      WinLoss? secondMatchWinLoss,
      WinLoss? thirdMatchWinLoss,
      String? memo,
      List<String>? imagePaths});

  @override
  $RecordCopyWith<$Res> get record;
}

/// @nodoc
class __$$MargedRecordImplCopyWithImpl<$Res>
    extends _$MargedRecordCopyWithImpl<$Res, _$MargedRecordImpl>
    implements _$$MargedRecordImplCopyWith<$Res> {
  __$$MargedRecordImplCopyWithImpl(
      _$MargedRecordImpl _value, $Res Function(_$MargedRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? record = null,
    Object? game = null,
    Object? tag = null,
    Object? bo = null,
    Object? useDeck = null,
    Object? opponentDeck = null,
    Object? date = null,
    Object? firstSecond = null,
    Object? firstMatchFirstSecond = freezed,
    Object? secondMatchFirstSecond = freezed,
    Object? thirdMatchFirstSecond = freezed,
    Object? winLoss = null,
    Object? firstMatchWinLoss = freezed,
    Object? secondMatchWinLoss = freezed,
    Object? thirdMatchWinLoss = freezed,
    Object? memo = freezed,
    Object? imagePaths = freezed,
  }) {
    return _then(_$MargedRecordImpl(
      record: null == record
          ? _value.record
          : record // ignore: cast_nullable_to_non_nullable
              as Record,
      game: null == game
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as String,
      tag: null == tag
          ? _value._tag
          : tag // ignore: cast_nullable_to_non_nullable
              as List<String>,
      bo: null == bo
          ? _value.bo
          : bo // ignore: cast_nullable_to_non_nullable
              as BO,
      useDeck: null == useDeck
          ? _value.useDeck
          : useDeck // ignore: cast_nullable_to_non_nullable
              as String,
      opponentDeck: null == opponentDeck
          ? _value.opponentDeck
          : opponentDeck // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      firstSecond: null == firstSecond
          ? _value.firstSecond
          : firstSecond // ignore: cast_nullable_to_non_nullable
              as FirstSecond,
      firstMatchFirstSecond: freezed == firstMatchFirstSecond
          ? _value.firstMatchFirstSecond
          : firstMatchFirstSecond // ignore: cast_nullable_to_non_nullable
              as FirstSecond?,
      secondMatchFirstSecond: freezed == secondMatchFirstSecond
          ? _value.secondMatchFirstSecond
          : secondMatchFirstSecond // ignore: cast_nullable_to_non_nullable
              as FirstSecond?,
      thirdMatchFirstSecond: freezed == thirdMatchFirstSecond
          ? _value.thirdMatchFirstSecond
          : thirdMatchFirstSecond // ignore: cast_nullable_to_non_nullable
              as FirstSecond?,
      winLoss: null == winLoss
          ? _value.winLoss
          : winLoss // ignore: cast_nullable_to_non_nullable
              as WinLoss,
      firstMatchWinLoss: freezed == firstMatchWinLoss
          ? _value.firstMatchWinLoss
          : firstMatchWinLoss // ignore: cast_nullable_to_non_nullable
              as WinLoss?,
      secondMatchWinLoss: freezed == secondMatchWinLoss
          ? _value.secondMatchWinLoss
          : secondMatchWinLoss // ignore: cast_nullable_to_non_nullable
              as WinLoss?,
      thirdMatchWinLoss: freezed == thirdMatchWinLoss
          ? _value.thirdMatchWinLoss
          : thirdMatchWinLoss // ignore: cast_nullable_to_non_nullable
              as WinLoss?,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePaths: freezed == imagePaths
          ? _value._imagePaths
          : imagePaths // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

class _$MargedRecordImpl implements _MargedRecord {
  _$MargedRecordImpl(
      {required this.record,
      required this.game,
      final List<String> tag = const [],
      required this.bo,
      required this.useDeck,
      required this.opponentDeck,
      required this.date,
      required this.firstSecond,
      this.firstMatchFirstSecond,
      this.secondMatchFirstSecond,
      this.thirdMatchFirstSecond,
      required this.winLoss,
      this.firstMatchWinLoss,
      this.secondMatchWinLoss,
      this.thirdMatchWinLoss,
      this.memo,
      final List<String>? imagePaths})
      : _tag = tag,
        _imagePaths = imagePaths;

  @override
  final Record record;
  @override
  final String game;
  final List<String> _tag;
  @override
  @JsonKey()
  List<String> get tag {
    if (_tag is EqualUnmodifiableListView) return _tag;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tag);
  }

  @override
  final BO bo;
  @override
  final String useDeck;
  @override
  final String opponentDeck;
  @override
  final DateTime date;
  @override
  final FirstSecond firstSecond;
  @override
  final FirstSecond? firstMatchFirstSecond;
  @override
  final FirstSecond? secondMatchFirstSecond;
  @override
  final FirstSecond? thirdMatchFirstSecond;
  @override
  final WinLoss winLoss;
  @override
  final WinLoss? firstMatchWinLoss;
  @override
  final WinLoss? secondMatchWinLoss;
  @override
  final WinLoss? thirdMatchWinLoss;
  @override
  final String? memo;
  final List<String>? _imagePaths;
  @override
  List<String>? get imagePaths {
    final value = _imagePaths;
    if (value == null) return null;
    if (_imagePaths is EqualUnmodifiableListView) return _imagePaths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MargedRecord(record: $record, game: $game, tag: $tag, bo: $bo, useDeck: $useDeck, opponentDeck: $opponentDeck, date: $date, firstSecond: $firstSecond, firstMatchFirstSecond: $firstMatchFirstSecond, secondMatchFirstSecond: $secondMatchFirstSecond, thirdMatchFirstSecond: $thirdMatchFirstSecond, winLoss: $winLoss, firstMatchWinLoss: $firstMatchWinLoss, secondMatchWinLoss: $secondMatchWinLoss, thirdMatchWinLoss: $thirdMatchWinLoss, memo: $memo, imagePaths: $imagePaths)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MargedRecordImpl &&
            (identical(other.record, record) || other.record == record) &&
            (identical(other.game, game) || other.game == game) &&
            const DeepCollectionEquality().equals(other._tag, _tag) &&
            (identical(other.bo, bo) || other.bo == bo) &&
            (identical(other.useDeck, useDeck) || other.useDeck == useDeck) &&
            (identical(other.opponentDeck, opponentDeck) ||
                other.opponentDeck == opponentDeck) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.firstSecond, firstSecond) ||
                other.firstSecond == firstSecond) &&
            (identical(other.firstMatchFirstSecond, firstMatchFirstSecond) ||
                other.firstMatchFirstSecond == firstMatchFirstSecond) &&
            (identical(other.secondMatchFirstSecond, secondMatchFirstSecond) ||
                other.secondMatchFirstSecond == secondMatchFirstSecond) &&
            (identical(other.thirdMatchFirstSecond, thirdMatchFirstSecond) ||
                other.thirdMatchFirstSecond == thirdMatchFirstSecond) &&
            (identical(other.winLoss, winLoss) || other.winLoss == winLoss) &&
            (identical(other.firstMatchWinLoss, firstMatchWinLoss) ||
                other.firstMatchWinLoss == firstMatchWinLoss) &&
            (identical(other.secondMatchWinLoss, secondMatchWinLoss) ||
                other.secondMatchWinLoss == secondMatchWinLoss) &&
            (identical(other.thirdMatchWinLoss, thirdMatchWinLoss) ||
                other.thirdMatchWinLoss == thirdMatchWinLoss) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            const DeepCollectionEquality()
                .equals(other._imagePaths, _imagePaths));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      record,
      game,
      const DeepCollectionEquality().hash(_tag),
      bo,
      useDeck,
      opponentDeck,
      date,
      firstSecond,
      firstMatchFirstSecond,
      secondMatchFirstSecond,
      thirdMatchFirstSecond,
      winLoss,
      firstMatchWinLoss,
      secondMatchWinLoss,
      thirdMatchWinLoss,
      memo,
      const DeepCollectionEquality().hash(_imagePaths));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MargedRecordImplCopyWith<_$MargedRecordImpl> get copyWith =>
      __$$MargedRecordImplCopyWithImpl<_$MargedRecordImpl>(this, _$identity);
}

abstract class _MargedRecord implements MargedRecord {
  factory _MargedRecord(
      {required final Record record,
      required final String game,
      final List<String> tag,
      required final BO bo,
      required final String useDeck,
      required final String opponentDeck,
      required final DateTime date,
      required final FirstSecond firstSecond,
      final FirstSecond? firstMatchFirstSecond,
      final FirstSecond? secondMatchFirstSecond,
      final FirstSecond? thirdMatchFirstSecond,
      required final WinLoss winLoss,
      final WinLoss? firstMatchWinLoss,
      final WinLoss? secondMatchWinLoss,
      final WinLoss? thirdMatchWinLoss,
      final String? memo,
      final List<String>? imagePaths}) = _$MargedRecordImpl;

  @override
  Record get record;
  @override
  String get game;
  @override
  List<String> get tag;
  @override
  BO get bo;
  @override
  String get useDeck;
  @override
  String get opponentDeck;
  @override
  DateTime get date;
  @override
  FirstSecond get firstSecond;
  @override
  FirstSecond? get firstMatchFirstSecond;
  @override
  FirstSecond? get secondMatchFirstSecond;
  @override
  FirstSecond? get thirdMatchFirstSecond;
  @override
  WinLoss get winLoss;
  @override
  WinLoss? get firstMatchWinLoss;
  @override
  WinLoss? get secondMatchWinLoss;
  @override
  WinLoss? get thirdMatchWinLoss;
  @override
  String? get memo;
  @override
  List<String>? get imagePaths;
  @override
  @JsonKey(ignore: true)
  _$$MargedRecordImplCopyWith<_$MargedRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
