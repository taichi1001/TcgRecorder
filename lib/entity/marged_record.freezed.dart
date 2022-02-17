// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'marged_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MargedRecordTearOff {
  const _$MargedRecordTearOff();

  _MargedRecord call(
      {required int recordId,
      required String game,
      String? tag = '分類無し',
      required String useDeck,
      required String opponentDeck,
      required DateTime date,
      required FirstSecond firstSecond,
      required WinLoss winLoss,
      String? memo}) {
    return _MargedRecord(
      recordId: recordId,
      game: game,
      tag: tag,
      useDeck: useDeck,
      opponentDeck: opponentDeck,
      date: date,
      firstSecond: firstSecond,
      winLoss: winLoss,
      memo: memo,
    );
  }
}

/// @nodoc
const $MargedRecord = _$MargedRecordTearOff();

/// @nodoc
mixin _$MargedRecord {
  int get recordId => throw _privateConstructorUsedError;
  String get game => throw _privateConstructorUsedError;
  String? get tag => throw _privateConstructorUsedError;
  String get useDeck => throw _privateConstructorUsedError;
  String get opponentDeck => throw _privateConstructorUsedError;
  DateTime get date =>
      throw _privateConstructorUsedError; // required bool firstSecond,
// required bool winLoss,
  FirstSecond get firstSecond => throw _privateConstructorUsedError;
  WinLoss get winLoss => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MargedRecordCopyWith<MargedRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MargedRecordCopyWith<$Res> {
  factory $MargedRecordCopyWith(
          MargedRecord value, $Res Function(MargedRecord) then) =
      _$MargedRecordCopyWithImpl<$Res>;
  $Res call(
      {int recordId,
      String game,
      String? tag,
      String useDeck,
      String opponentDeck,
      DateTime date,
      FirstSecond firstSecond,
      WinLoss winLoss,
      String? memo});
}

/// @nodoc
class _$MargedRecordCopyWithImpl<$Res> implements $MargedRecordCopyWith<$Res> {
  _$MargedRecordCopyWithImpl(this._value, this._then);

  final MargedRecord _value;
  // ignore: unused_field
  final $Res Function(MargedRecord) _then;

  @override
  $Res call({
    Object? recordId = freezed,
    Object? game = freezed,
    Object? tag = freezed,
    Object? useDeck = freezed,
    Object? opponentDeck = freezed,
    Object? date = freezed,
    Object? firstSecond = freezed,
    Object? winLoss = freezed,
    Object? memo = freezed,
  }) {
    return _then(_value.copyWith(
      recordId: recordId == freezed
          ? _value.recordId
          : recordId // ignore: cast_nullable_to_non_nullable
              as int,
      game: game == freezed
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as String,
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      useDeck: useDeck == freezed
          ? _value.useDeck
          : useDeck // ignore: cast_nullable_to_non_nullable
              as String,
      opponentDeck: opponentDeck == freezed
          ? _value.opponentDeck
          : opponentDeck // ignore: cast_nullable_to_non_nullable
              as String,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      firstSecond: firstSecond == freezed
          ? _value.firstSecond
          : firstSecond // ignore: cast_nullable_to_non_nullable
              as FirstSecond,
      winLoss: winLoss == freezed
          ? _value.winLoss
          : winLoss // ignore: cast_nullable_to_non_nullable
              as WinLoss,
      memo: memo == freezed
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$MargedRecordCopyWith<$Res>
    implements $MargedRecordCopyWith<$Res> {
  factory _$MargedRecordCopyWith(
          _MargedRecord value, $Res Function(_MargedRecord) then) =
      __$MargedRecordCopyWithImpl<$Res>;
  @override
  $Res call(
      {int recordId,
      String game,
      String? tag,
      String useDeck,
      String opponentDeck,
      DateTime date,
      FirstSecond firstSecond,
      WinLoss winLoss,
      String? memo});
}

/// @nodoc
class __$MargedRecordCopyWithImpl<$Res> extends _$MargedRecordCopyWithImpl<$Res>
    implements _$MargedRecordCopyWith<$Res> {
  __$MargedRecordCopyWithImpl(
      _MargedRecord _value, $Res Function(_MargedRecord) _then)
      : super(_value, (v) => _then(v as _MargedRecord));

  @override
  _MargedRecord get _value => super._value as _MargedRecord;

  @override
  $Res call({
    Object? recordId = freezed,
    Object? game = freezed,
    Object? tag = freezed,
    Object? useDeck = freezed,
    Object? opponentDeck = freezed,
    Object? date = freezed,
    Object? firstSecond = freezed,
    Object? winLoss = freezed,
    Object? memo = freezed,
  }) {
    return _then(_MargedRecord(
      recordId: recordId == freezed
          ? _value.recordId
          : recordId // ignore: cast_nullable_to_non_nullable
              as int,
      game: game == freezed
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as String,
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      useDeck: useDeck == freezed
          ? _value.useDeck
          : useDeck // ignore: cast_nullable_to_non_nullable
              as String,
      opponentDeck: opponentDeck == freezed
          ? _value.opponentDeck
          : opponentDeck // ignore: cast_nullable_to_non_nullable
              as String,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      firstSecond: firstSecond == freezed
          ? _value.firstSecond
          : firstSecond // ignore: cast_nullable_to_non_nullable
              as FirstSecond,
      winLoss: winLoss == freezed
          ? _value.winLoss
          : winLoss // ignore: cast_nullable_to_non_nullable
              as WinLoss,
      memo: memo == freezed
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_MargedRecord implements _MargedRecord {
  _$_MargedRecord(
      {required this.recordId,
      required this.game,
      this.tag = '分類無し',
      required this.useDeck,
      required this.opponentDeck,
      required this.date,
      required this.firstSecond,
      required this.winLoss,
      this.memo});

  @override
  final int recordId;
  @override
  final String game;
  @JsonKey()
  @override
  final String? tag;
  @override
  final String useDeck;
  @override
  final String opponentDeck;
  @override
  final DateTime date;
  @override // required bool firstSecond,
// required bool winLoss,
  final FirstSecond firstSecond;
  @override
  final WinLoss winLoss;
  @override
  final String? memo;

  @override
  String toString() {
    return 'MargedRecord(recordId: $recordId, game: $game, tag: $tag, useDeck: $useDeck, opponentDeck: $opponentDeck, date: $date, firstSecond: $firstSecond, winLoss: $winLoss, memo: $memo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MargedRecord &&
            const DeepCollectionEquality().equals(other.recordId, recordId) &&
            const DeepCollectionEquality().equals(other.game, game) &&
            const DeepCollectionEquality().equals(other.tag, tag) &&
            const DeepCollectionEquality().equals(other.useDeck, useDeck) &&
            const DeepCollectionEquality()
                .equals(other.opponentDeck, opponentDeck) &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality()
                .equals(other.firstSecond, firstSecond) &&
            const DeepCollectionEquality().equals(other.winLoss, winLoss) &&
            const DeepCollectionEquality().equals(other.memo, memo));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(recordId),
      const DeepCollectionEquality().hash(game),
      const DeepCollectionEquality().hash(tag),
      const DeepCollectionEquality().hash(useDeck),
      const DeepCollectionEquality().hash(opponentDeck),
      const DeepCollectionEquality().hash(date),
      const DeepCollectionEquality().hash(firstSecond),
      const DeepCollectionEquality().hash(winLoss),
      const DeepCollectionEquality().hash(memo));

  @JsonKey(ignore: true)
  @override
  _$MargedRecordCopyWith<_MargedRecord> get copyWith =>
      __$MargedRecordCopyWithImpl<_MargedRecord>(this, _$identity);
}

abstract class _MargedRecord implements MargedRecord {
  factory _MargedRecord(
      {required int recordId,
      required String game,
      String? tag,
      required String useDeck,
      required String opponentDeck,
      required DateTime date,
      required FirstSecond firstSecond,
      required WinLoss winLoss,
      String? memo}) = _$_MargedRecord;

  @override
  int get recordId;
  @override
  String get game;
  @override
  String? get tag;
  @override
  String get useDeck;
  @override
  String get opponentDeck;
  @override
  DateTime get date;
  @override // required bool firstSecond,
// required bool winLoss,
  FirstSecond get firstSecond;
  @override
  WinLoss get winLoss;
  @override
  String? get memo;
  @override
  @JsonKey(ignore: true)
  _$MargedRecordCopyWith<_MargedRecord> get copyWith =>
      throw _privateConstructorUsedError;
}
