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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Record _$RecordFromJson(Map<String, dynamic> json) {
  return _Record.fromJson(json);
}

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
  DateTime? get date => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _boFromJson, toJson: _boToJson)
  BO get bo => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: _firstSecondFromJson,
      toJson: _firstSecondToJson,
      name: 'first_second')
  FirstSecond get firstSecond => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson,
      name: 'first_match_first_second')
  FirstSecond? get firstMatchFirstSecond => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson,
      name: 'second_match_first_second')
  FirstSecond? get secondMatchFirstSecond => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson,
      name: 'third_match_first_second')
  FirstSecond? get thiredMatchFirstSecond => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson, name: 'win_loss')
  WinLoss get winLoss => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: _nullableWinLossFromJson,
      toJson: _nullableWinLossToJson,
      name: 'first_match_win_loss')
  WinLoss? get firstMatchWinLoss => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: _nullableWinLossFromJson,
      toJson: _nullableWinLossToJson,
      name: 'second_match_win_loss')
  WinLoss? get secondMatchWinLoss => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: _nullableWinLossFromJson,
      toJson: _nullableWinLossToJson,
      name: 'third_match_win_loss')
  WinLoss? get thirdMatchWinLoss => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: _stringListFromJson,
      toJson: _stringListToJson,
      name: 'image_path')
  List<String>? get imagePath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecordCopyWith<Record> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordCopyWith<$Res> {
  factory $RecordCopyWith(Record value, $Res Function(Record) then) =
      _$RecordCopyWithImpl<$Res>;
  $Res call(
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
      @JsonKey(fromJson: _boFromJson, toJson: _boToJson)
          BO bo,
      @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson, name: 'first_second')
          FirstSecond firstSecond,
      @JsonKey(fromJson: _nullableFirstSecondFromJson, toJson: _nullableFirstSecondToJson, name: 'first_match_first_second')
          FirstSecond? firstMatchFirstSecond,
      @JsonKey(fromJson: _nullableFirstSecondFromJson, toJson: _nullableFirstSecondToJson, name: 'second_match_first_second')
          FirstSecond? secondMatchFirstSecond,
      @JsonKey(fromJson: _nullableFirstSecondFromJson, toJson: _nullableFirstSecondToJson, name: 'third_match_first_second')
          FirstSecond? thiredMatchFirstSecond,
      @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson, name: 'win_loss')
          WinLoss winLoss,
      @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson, name: 'first_match_win_loss')
          WinLoss? firstMatchWinLoss,
      @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson, name: 'second_match_win_loss')
          WinLoss? secondMatchWinLoss,
      @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson, name: 'third_match_win_loss')
          WinLoss? thirdMatchWinLoss,
      String? memo,
      @JsonKey(fromJson: _stringListFromJson, toJson: _stringListToJson, name: 'image_path')
          List<String>? imagePath});
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
    Object? bo = freezed,
    Object? firstSecond = freezed,
    Object? firstMatchFirstSecond = freezed,
    Object? secondMatchFirstSecond = freezed,
    Object? thiredMatchFirstSecond = freezed,
    Object? winLoss = freezed,
    Object? firstMatchWinLoss = freezed,
    Object? secondMatchWinLoss = freezed,
    Object? thirdMatchWinLoss = freezed,
    Object? memo = freezed,
    Object? imagePath = freezed,
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
      bo: bo == freezed
          ? _value.bo
          : bo // ignore: cast_nullable_to_non_nullable
              as BO,
      firstSecond: firstSecond == freezed
          ? _value.firstSecond
          : firstSecond // ignore: cast_nullable_to_non_nullable
              as FirstSecond,
      firstMatchFirstSecond: firstMatchFirstSecond == freezed
          ? _value.firstMatchFirstSecond
          : firstMatchFirstSecond // ignore: cast_nullable_to_non_nullable
              as FirstSecond?,
      secondMatchFirstSecond: secondMatchFirstSecond == freezed
          ? _value.secondMatchFirstSecond
          : secondMatchFirstSecond // ignore: cast_nullable_to_non_nullable
              as FirstSecond?,
      thiredMatchFirstSecond: thiredMatchFirstSecond == freezed
          ? _value.thiredMatchFirstSecond
          : thiredMatchFirstSecond // ignore: cast_nullable_to_non_nullable
              as FirstSecond?,
      winLoss: winLoss == freezed
          ? _value.winLoss
          : winLoss // ignore: cast_nullable_to_non_nullable
              as WinLoss,
      firstMatchWinLoss: firstMatchWinLoss == freezed
          ? _value.firstMatchWinLoss
          : firstMatchWinLoss // ignore: cast_nullable_to_non_nullable
              as WinLoss?,
      secondMatchWinLoss: secondMatchWinLoss == freezed
          ? _value.secondMatchWinLoss
          : secondMatchWinLoss // ignore: cast_nullable_to_non_nullable
              as WinLoss?,
      thirdMatchWinLoss: thirdMatchWinLoss == freezed
          ? _value.thirdMatchWinLoss
          : thirdMatchWinLoss // ignore: cast_nullable_to_non_nullable
              as WinLoss?,
      memo: memo == freezed
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: imagePath == freezed
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
abstract class _$$_RecordCopyWith<$Res> implements $RecordCopyWith<$Res> {
  factory _$$_RecordCopyWith(_$_Record value, $Res Function(_$_Record) then) =
      __$$_RecordCopyWithImpl<$Res>;
  @override
  $Res call(
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
      @JsonKey(fromJson: _boFromJson, toJson: _boToJson)
          BO bo,
      @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson, name: 'first_second')
          FirstSecond firstSecond,
      @JsonKey(fromJson: _nullableFirstSecondFromJson, toJson: _nullableFirstSecondToJson, name: 'first_match_first_second')
          FirstSecond? firstMatchFirstSecond,
      @JsonKey(fromJson: _nullableFirstSecondFromJson, toJson: _nullableFirstSecondToJson, name: 'second_match_first_second')
          FirstSecond? secondMatchFirstSecond,
      @JsonKey(fromJson: _nullableFirstSecondFromJson, toJson: _nullableFirstSecondToJson, name: 'third_match_first_second')
          FirstSecond? thiredMatchFirstSecond,
      @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson, name: 'win_loss')
          WinLoss winLoss,
      @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson, name: 'first_match_win_loss')
          WinLoss? firstMatchWinLoss,
      @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson, name: 'second_match_win_loss')
          WinLoss? secondMatchWinLoss,
      @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson, name: 'third_match_win_loss')
          WinLoss? thirdMatchWinLoss,
      String? memo,
      @JsonKey(fromJson: _stringListFromJson, toJson: _stringListToJson, name: 'image_path')
          List<String>? imagePath});
}

/// @nodoc
class __$$_RecordCopyWithImpl<$Res> extends _$RecordCopyWithImpl<$Res>
    implements _$$_RecordCopyWith<$Res> {
  __$$_RecordCopyWithImpl(_$_Record _value, $Res Function(_$_Record) _then)
      : super(_value, (v) => _then(v as _$_Record));

  @override
  _$_Record get _value => super._value as _$_Record;

  @override
  $Res call({
    Object? recordId = freezed,
    Object? gameId = freezed,
    Object? tagId = freezed,
    Object? useDeckId = freezed,
    Object? opponentDeckId = freezed,
    Object? date = freezed,
    Object? bo = freezed,
    Object? firstSecond = freezed,
    Object? firstMatchFirstSecond = freezed,
    Object? secondMatchFirstSecond = freezed,
    Object? thiredMatchFirstSecond = freezed,
    Object? winLoss = freezed,
    Object? firstMatchWinLoss = freezed,
    Object? secondMatchWinLoss = freezed,
    Object? thirdMatchWinLoss = freezed,
    Object? memo = freezed,
    Object? imagePath = freezed,
  }) {
    return _then(_$_Record(
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
      bo: bo == freezed
          ? _value.bo
          : bo // ignore: cast_nullable_to_non_nullable
              as BO,
      firstSecond: firstSecond == freezed
          ? _value.firstSecond
          : firstSecond // ignore: cast_nullable_to_non_nullable
              as FirstSecond,
      firstMatchFirstSecond: firstMatchFirstSecond == freezed
          ? _value.firstMatchFirstSecond
          : firstMatchFirstSecond // ignore: cast_nullable_to_non_nullable
              as FirstSecond?,
      secondMatchFirstSecond: secondMatchFirstSecond == freezed
          ? _value.secondMatchFirstSecond
          : secondMatchFirstSecond // ignore: cast_nullable_to_non_nullable
              as FirstSecond?,
      thiredMatchFirstSecond: thiredMatchFirstSecond == freezed
          ? _value.thiredMatchFirstSecond
          : thiredMatchFirstSecond // ignore: cast_nullable_to_non_nullable
              as FirstSecond?,
      winLoss: winLoss == freezed
          ? _value.winLoss
          : winLoss // ignore: cast_nullable_to_non_nullable
              as WinLoss,
      firstMatchWinLoss: firstMatchWinLoss == freezed
          ? _value.firstMatchWinLoss
          : firstMatchWinLoss // ignore: cast_nullable_to_non_nullable
              as WinLoss?,
      secondMatchWinLoss: secondMatchWinLoss == freezed
          ? _value.secondMatchWinLoss
          : secondMatchWinLoss // ignore: cast_nullable_to_non_nullable
              as WinLoss?,
      thirdMatchWinLoss: thirdMatchWinLoss == freezed
          ? _value.thirdMatchWinLoss
          : thirdMatchWinLoss // ignore: cast_nullable_to_non_nullable
              as WinLoss?,
      memo: memo == freezed
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: imagePath == freezed
          ? _value._imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Record implements _Record {
  _$_Record(
      {@JsonKey(name: 'record_id')
          this.recordId,
      @JsonKey(name: 'game_id')
          this.gameId,
      @JsonKey(name: 'tag_id')
          this.tagId,
      @JsonKey(name: 'use_deck_id')
          this.useDeckId,
      @JsonKey(name: 'opponent_deck_id')
          this.opponentDeckId,
      @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
          this.date,
      @JsonKey(fromJson: _boFromJson, toJson: _boToJson)
          this.bo = BO.bo1,
      @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson, name: 'first_second')
          this.firstSecond = FirstSecond.first,
      @JsonKey(fromJson: _nullableFirstSecondFromJson, toJson: _nullableFirstSecondToJson, name: 'first_match_first_second')
          this.firstMatchFirstSecond,
      @JsonKey(fromJson: _nullableFirstSecondFromJson, toJson: _nullableFirstSecondToJson, name: 'second_match_first_second')
          this.secondMatchFirstSecond,
      @JsonKey(fromJson: _nullableFirstSecondFromJson, toJson: _nullableFirstSecondToJson, name: 'third_match_first_second')
          this.thiredMatchFirstSecond,
      @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson, name: 'win_loss')
          this.winLoss = WinLoss.win,
      @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson, name: 'first_match_win_loss')
          this.firstMatchWinLoss,
      @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson, name: 'second_match_win_loss')
          this.secondMatchWinLoss,
      @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson, name: 'third_match_win_loss')
          this.thirdMatchWinLoss,
      this.memo,
      @JsonKey(fromJson: _stringListFromJson, toJson: _stringListToJson, name: 'image_path')
          final List<String>? imagePath})
      : _imagePath = imagePath;

  factory _$_Record.fromJson(Map<String, dynamic> json) =>
      _$$_RecordFromJson(json);

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
  @override
  @JsonKey(fromJson: _boFromJson, toJson: _boToJson)
  final BO bo;
  @override
  @JsonKey(
      fromJson: _firstSecondFromJson,
      toJson: _firstSecondToJson,
      name: 'first_second')
  final FirstSecond firstSecond;
  @override
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson,
      name: 'first_match_first_second')
  final FirstSecond? firstMatchFirstSecond;
  @override
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson,
      name: 'second_match_first_second')
  final FirstSecond? secondMatchFirstSecond;
  @override
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson,
      name: 'third_match_first_second')
  final FirstSecond? thiredMatchFirstSecond;
  @override
  @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson, name: 'win_loss')
  final WinLoss winLoss;
  @override
  @JsonKey(
      fromJson: _nullableWinLossFromJson,
      toJson: _nullableWinLossToJson,
      name: 'first_match_win_loss')
  final WinLoss? firstMatchWinLoss;
  @override
  @JsonKey(
      fromJson: _nullableWinLossFromJson,
      toJson: _nullableWinLossToJson,
      name: 'second_match_win_loss')
  final WinLoss? secondMatchWinLoss;
  @override
  @JsonKey(
      fromJson: _nullableWinLossFromJson,
      toJson: _nullableWinLossToJson,
      name: 'third_match_win_loss')
  final WinLoss? thirdMatchWinLoss;
  @override
  final String? memo;
  final List<String>? _imagePath;
  @override
  @JsonKey(
      fromJson: _stringListFromJson,
      toJson: _stringListToJson,
      name: 'image_path')
  List<String>? get imagePath {
    final value = _imagePath;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Record(recordId: $recordId, gameId: $gameId, tagId: $tagId, useDeckId: $useDeckId, opponentDeckId: $opponentDeckId, date: $date, bo: $bo, firstSecond: $firstSecond, firstMatchFirstSecond: $firstMatchFirstSecond, secondMatchFirstSecond: $secondMatchFirstSecond, thiredMatchFirstSecond: $thiredMatchFirstSecond, winLoss: $winLoss, firstMatchWinLoss: $firstMatchWinLoss, secondMatchWinLoss: $secondMatchWinLoss, thirdMatchWinLoss: $thirdMatchWinLoss, memo: $memo, imagePath: $imagePath)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Record &&
            const DeepCollectionEquality().equals(other.recordId, recordId) &&
            const DeepCollectionEquality().equals(other.gameId, gameId) &&
            const DeepCollectionEquality().equals(other.tagId, tagId) &&
            const DeepCollectionEquality().equals(other.useDeckId, useDeckId) &&
            const DeepCollectionEquality()
                .equals(other.opponentDeckId, opponentDeckId) &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality().equals(other.bo, bo) &&
            const DeepCollectionEquality()
                .equals(other.firstSecond, firstSecond) &&
            const DeepCollectionEquality()
                .equals(other.firstMatchFirstSecond, firstMatchFirstSecond) &&
            const DeepCollectionEquality()
                .equals(other.secondMatchFirstSecond, secondMatchFirstSecond) &&
            const DeepCollectionEquality()
                .equals(other.thiredMatchFirstSecond, thiredMatchFirstSecond) &&
            const DeepCollectionEquality().equals(other.winLoss, winLoss) &&
            const DeepCollectionEquality()
                .equals(other.firstMatchWinLoss, firstMatchWinLoss) &&
            const DeepCollectionEquality()
                .equals(other.secondMatchWinLoss, secondMatchWinLoss) &&
            const DeepCollectionEquality()
                .equals(other.thirdMatchWinLoss, thirdMatchWinLoss) &&
            const DeepCollectionEquality().equals(other.memo, memo) &&
            const DeepCollectionEquality()
                .equals(other._imagePath, _imagePath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(recordId),
      const DeepCollectionEquality().hash(gameId),
      const DeepCollectionEquality().hash(tagId),
      const DeepCollectionEquality().hash(useDeckId),
      const DeepCollectionEquality().hash(opponentDeckId),
      const DeepCollectionEquality().hash(date),
      const DeepCollectionEquality().hash(bo),
      const DeepCollectionEquality().hash(firstSecond),
      const DeepCollectionEquality().hash(firstMatchFirstSecond),
      const DeepCollectionEquality().hash(secondMatchFirstSecond),
      const DeepCollectionEquality().hash(thiredMatchFirstSecond),
      const DeepCollectionEquality().hash(winLoss),
      const DeepCollectionEquality().hash(firstMatchWinLoss),
      const DeepCollectionEquality().hash(secondMatchWinLoss),
      const DeepCollectionEquality().hash(thirdMatchWinLoss),
      const DeepCollectionEquality().hash(memo),
      const DeepCollectionEquality().hash(_imagePath));

  @JsonKey(ignore: true)
  @override
  _$$_RecordCopyWith<_$_Record> get copyWith =>
      __$$_RecordCopyWithImpl<_$_Record>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecordToJson(this);
  }
}

abstract class _Record implements Record {
  factory _Record(
      {@JsonKey(name: 'record_id')
          final int? recordId,
      @JsonKey(name: 'game_id')
          final int? gameId,
      @JsonKey(name: 'tag_id')
          final int? tagId,
      @JsonKey(name: 'use_deck_id')
          final int? useDeckId,
      @JsonKey(name: 'opponent_deck_id')
          final int? opponentDeckId,
      @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
          final DateTime? date,
      @JsonKey(fromJson: _boFromJson, toJson: _boToJson)
          final BO bo,
      @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson, name: 'first_second')
          final FirstSecond firstSecond,
      @JsonKey(fromJson: _nullableFirstSecondFromJson, toJson: _nullableFirstSecondToJson, name: 'first_match_first_second')
          final FirstSecond? firstMatchFirstSecond,
      @JsonKey(fromJson: _nullableFirstSecondFromJson, toJson: _nullableFirstSecondToJson, name: 'second_match_first_second')
          final FirstSecond? secondMatchFirstSecond,
      @JsonKey(fromJson: _nullableFirstSecondFromJson, toJson: _nullableFirstSecondToJson, name: 'third_match_first_second')
          final FirstSecond? thiredMatchFirstSecond,
      @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson, name: 'win_loss')
          final WinLoss winLoss,
      @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson, name: 'first_match_win_loss')
          final WinLoss? firstMatchWinLoss,
      @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson, name: 'second_match_win_loss')
          final WinLoss? secondMatchWinLoss,
      @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson, name: 'third_match_win_loss')
          final WinLoss? thirdMatchWinLoss,
      final String? memo,
      @JsonKey(fromJson: _stringListFromJson, toJson: _stringListToJson, name: 'image_path')
          final List<String>? imagePath}) = _$_Record;

  factory _Record.fromJson(Map<String, dynamic> json) = _$_Record.fromJson;

  @override
  @JsonKey(name: 'record_id')
  int? get recordId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'game_id')
  int? get gameId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'tag_id')
  int? get tagId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'use_deck_id')
  int? get useDeckId => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'opponent_deck_id')
  int? get opponentDeckId => throw _privateConstructorUsedError;
  @override
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? get date => throw _privateConstructorUsedError;
  @override
  @JsonKey(fromJson: _boFromJson, toJson: _boToJson)
  BO get bo => throw _privateConstructorUsedError;
  @override
  @JsonKey(
      fromJson: _firstSecondFromJson,
      toJson: _firstSecondToJson,
      name: 'first_second')
  FirstSecond get firstSecond => throw _privateConstructorUsedError;
  @override
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson,
      name: 'first_match_first_second')
  FirstSecond? get firstMatchFirstSecond => throw _privateConstructorUsedError;
  @override
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson,
      name: 'second_match_first_second')
  FirstSecond? get secondMatchFirstSecond => throw _privateConstructorUsedError;
  @override
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson,
      name: 'third_match_first_second')
  FirstSecond? get thiredMatchFirstSecond => throw _privateConstructorUsedError;
  @override
  @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson, name: 'win_loss')
  WinLoss get winLoss => throw _privateConstructorUsedError;
  @override
  @JsonKey(
      fromJson: _nullableWinLossFromJson,
      toJson: _nullableWinLossToJson,
      name: 'first_match_win_loss')
  WinLoss? get firstMatchWinLoss => throw _privateConstructorUsedError;
  @override
  @JsonKey(
      fromJson: _nullableWinLossFromJson,
      toJson: _nullableWinLossToJson,
      name: 'second_match_win_loss')
  WinLoss? get secondMatchWinLoss => throw _privateConstructorUsedError;
  @override
  @JsonKey(
      fromJson: _nullableWinLossFromJson,
      toJson: _nullableWinLossToJson,
      name: 'third_match_win_loss')
  WinLoss? get thirdMatchWinLoss => throw _privateConstructorUsedError;
  @override
  String? get memo => throw _privateConstructorUsedError;
  @override
  @JsonKey(
      fromJson: _stringListFromJson,
      toJson: _stringListToJson,
      name: 'image_path')
  List<String>? get imagePath => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RecordCopyWith<_$_Record> get copyWith =>
      throw _privateConstructorUsedError;
}
