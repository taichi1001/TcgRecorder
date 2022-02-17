// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Record _$RecordFromJson(Map<String, dynamic> json) {
  return _Record.fromJson(json);
}

/// @nodoc
class _$RecordTearOff {
  const _$RecordTearOff();

  _Record call(
      {@JsonKey(name: 'record_id')
          int? recordId,
      @JsonKey(name: 'game_id')
          int? gameId,
      @JsonKey(name: 'tag_id')
          int? tagId,
      @JsonKey(name: 'use_deck_id')
          int? useDeckId,
      @JsonKey(name: 'opponent_deck_id')
          int? opponentDeckId,
      @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
          DateTime? date,
      @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson, name: 'first_second')
          FirstSecond firstSecond = FirstSecond.first,
      @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson, name: 'win_loss')
          WinLoss winLoss = WinLoss.win,
      String? memo}) {
    return _Record(
      recordId: recordId,
      gameId: gameId,
      tagId: tagId,
      useDeckId: useDeckId,
      opponentDeckId: opponentDeckId,
      date: date,
      firstSecond: firstSecond,
      winLoss: winLoss,
      memo: memo,
    );
  }

  Record fromJson(Map<String, Object?> json) {
    return Record.fromJson(json);
  }
}

/// @nodoc
const $Record = _$RecordTearOff();

/// @nodoc
mixin _$Record {
  @JsonKey(name: 'record_id')
  int? get recordId => throw _privateConstructorUsedError;
  @JsonKey(name: 'game_id')
  int? get gameId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tag_id')
  int? get tagId => throw _privateConstructorUsedError;
  @JsonKey(name: 'use_deck_id')
  int? get useDeckId => throw _privateConstructorUsedError;
  @JsonKey(name: 'opponent_deck_id')
  int? get opponentDeckId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? get date =>
      throw _privateConstructorUsedError; // @Default(true) @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'first_second') bool firstSecond,
// @Default(true) @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'win_loss') bool winLoss,
  @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson, name: 'first_second')
  FirstSecond get firstSecond => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson, name: 'win_loss')
  WinLoss get winLoss => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecordCopyWith<Record> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordCopyWith<$Res> {
  factory $RecordCopyWith(Record value, $Res Function(Record) then) = _$RecordCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'record_id') int? recordId,
      @JsonKey(name: 'game_id') int? gameId,
      @JsonKey(name: 'tag_id') int? tagId,
      @JsonKey(name: 'use_deck_id') int? useDeckId,
      @JsonKey(name: 'opponent_deck_id') int? opponentDeckId,
      @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) DateTime? date,
      @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson, name: 'first_second') FirstSecond firstSecond,
      @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson, name: 'win_loss') WinLoss winLoss,
      String? memo});
}

/// @nodoc
class _$RecordCopyWithImpl<$Res> implements $RecordCopyWith<$Res> {
  _$RecordCopyWithImpl(this._value, this._then);

  final Record _value;
  // ignore: unused_field
  final $Res Function(Record) _then;

  @override
  $Res call({
    Object? recordId = freezed,
    Object? gameId = freezed,
    Object? tagId = freezed,
    Object? useDeckId = freezed,
    Object? opponentDeckId = freezed,
    Object? date = freezed,
    Object? firstSecond = freezed,
    Object? winLoss = freezed,
    Object? memo = freezed,
  }) {
    return _then(_value.copyWith(
      recordId: recordId == freezed
          ? _value.recordId
          : recordId // ignore: cast_nullable_to_non_nullable
              as int?,
      gameId: gameId == freezed
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int?,
      tagId: tagId == freezed
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as int?,
      useDeckId: useDeckId == freezed
          ? _value.useDeckId
          : useDeckId // ignore: cast_nullable_to_non_nullable
              as int?,
      opponentDeckId: opponentDeckId == freezed
          ? _value.opponentDeckId
          : opponentDeckId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
abstract class _$RecordCopyWith<$Res> implements $RecordCopyWith<$Res> {
  factory _$RecordCopyWith(_Record value, $Res Function(_Record) then) = __$RecordCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'record_id') int? recordId,
      @JsonKey(name: 'game_id') int? gameId,
      @JsonKey(name: 'tag_id') int? tagId,
      @JsonKey(name: 'use_deck_id') int? useDeckId,
      @JsonKey(name: 'opponent_deck_id') int? opponentDeckId,
      @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) DateTime? date,
      @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson, name: 'first_second') FirstSecond firstSecond,
      @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson, name: 'win_loss') WinLoss winLoss,
      String? memo});
}

/// @nodoc
class __$RecordCopyWithImpl<$Res> extends _$RecordCopyWithImpl<$Res> implements _$RecordCopyWith<$Res> {
  __$RecordCopyWithImpl(_Record _value, $Res Function(_Record) _then) : super(_value, (v) => _then(v as _Record));

  @override
  _Record get _value => super._value as _Record;

  @override
  $Res call({
    Object? recordId = freezed,
    Object? gameId = freezed,
    Object? tagId = freezed,
    Object? useDeckId = freezed,
    Object? opponentDeckId = freezed,
    Object? date = freezed,
    Object? firstSecond = freezed,
    Object? winLoss = freezed,
    Object? memo = freezed,
  }) {
    return _then(_Record(
      recordId: recordId == freezed
          ? _value.recordId
          : recordId // ignore: cast_nullable_to_non_nullable
              as int?,
      gameId: gameId == freezed
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int?,
      tagId: tagId == freezed
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as int?,
      useDeckId: useDeckId == freezed
          ? _value.useDeckId
          : useDeckId // ignore: cast_nullable_to_non_nullable
              as int?,
      opponentDeckId: opponentDeckId == freezed
          ? _value.opponentDeckId
          : opponentDeckId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
@JsonSerializable()
class _$_Record implements _Record {
  _$_Record(
      {@JsonKey(name: 'record_id') this.recordId,
      @JsonKey(name: 'game_id') this.gameId,
      @JsonKey(name: 'tag_id') this.tagId,
      @JsonKey(name: 'use_deck_id') this.useDeckId,
      @JsonKey(name: 'opponent_deck_id') this.opponentDeckId,
      @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) this.date,
      @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson, name: 'first_second') this.firstSecond = FirstSecond.first,
      @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson, name: 'win_loss') this.winLoss = WinLoss.win,
      this.memo});

  factory _$_Record.fromJson(Map<String, dynamic> json) => _$$_RecordFromJson(json);

  @override
  @JsonKey(name: 'record_id')
  final int? recordId;
  @override
  @JsonKey(name: 'game_id')
  final int? gameId;
  @override
  @JsonKey(name: 'tag_id')
  final int? tagId;
  @override
  @JsonKey(name: 'use_deck_id')
  final int? useDeckId;
  @override
  @JsonKey(name: 'opponent_deck_id')
  final int? opponentDeckId;
  @override
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime? date;
  @override // @Default(true) @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'first_second') bool firstSecond,
// @Default(true) @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'win_loss') bool winLoss,
  @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson, name: 'first_second')
  final FirstSecond firstSecond;
  @override
  @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson, name: 'win_loss')
  final WinLoss winLoss;
  @override
  final String? memo;

  @override
  String toString() {
    return 'Record(recordId: $recordId, gameId: $gameId, tagId: $tagId, useDeckId: $useDeckId, opponentDeckId: $opponentDeckId, date: $date, firstSecond: $firstSecond, winLoss: $winLoss, memo: $memo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Record &&
            const DeepCollectionEquality().equals(other.recordId, recordId) &&
            const DeepCollectionEquality().equals(other.gameId, gameId) &&
            const DeepCollectionEquality().equals(other.tagId, tagId) &&
            const DeepCollectionEquality().equals(other.useDeckId, useDeckId) &&
            const DeepCollectionEquality().equals(other.opponentDeckId, opponentDeckId) &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality().equals(other.firstSecond, firstSecond) &&
            const DeepCollectionEquality().equals(other.winLoss, winLoss) &&
            const DeepCollectionEquality().equals(other.memo, memo));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(recordId),
      const DeepCollectionEquality().hash(gameId),
      const DeepCollectionEquality().hash(tagId),
      const DeepCollectionEquality().hash(useDeckId),
      const DeepCollectionEquality().hash(opponentDeckId),
      const DeepCollectionEquality().hash(date),
      const DeepCollectionEquality().hash(firstSecond),
      const DeepCollectionEquality().hash(winLoss),
      const DeepCollectionEquality().hash(memo));

  @JsonKey(ignore: true)
  @override
  _$RecordCopyWith<_Record> get copyWith => __$RecordCopyWithImpl<_Record>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecordToJson(this);
  }
}

abstract class _Record implements Record {
  factory _Record(
      {@JsonKey(name: 'record_id') int? recordId,
      @JsonKey(name: 'game_id') int? gameId,
      @JsonKey(name: 'tag_id') int? tagId,
      @JsonKey(name: 'use_deck_id') int? useDeckId,
      @JsonKey(name: 'opponent_deck_id') int? opponentDeckId,
      @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) DateTime? date,
      @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson, name: 'first_second') FirstSecond firstSecond,
      @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson, name: 'win_loss') WinLoss winLoss,
      String? memo}) = _$_Record;

  factory _Record.fromJson(Map<String, dynamic> json) = _$_Record.fromJson;

  @override
  @JsonKey(name: 'record_id')
  int? get recordId;
  @override
  @JsonKey(name: 'game_id')
  int? get gameId;
  @override
  @JsonKey(name: 'tag_id')
  int? get tagId;
  @override
  @JsonKey(name: 'use_deck_id')
  int? get useDeckId;
  @override
  @JsonKey(name: 'opponent_deck_id')
  int? get opponentDeckId;
  @override
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? get date;
  @override // @Default(true) @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'first_second') bool firstSecond,
// @Default(true) @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'win_loss') bool winLoss,
  @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson, name: 'first_second')
  FirstSecond get firstSecond;
  @override
  @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson, name: 'win_loss')
  WinLoss get winLoss;
  @override
  String? get memo;
  @override
  @JsonKey(ignore: true)
  _$RecordCopyWith<_Record> get copyWith => throw _privateConstructorUsedError;
}
