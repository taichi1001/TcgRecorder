// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record_old.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RecordOld _$RecordOldFromJson(Map<String, dynamic> json) {
  return _RecordOld.fromJson(json);
}

/// @nodoc
mixin _$RecordOld {
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
  $RecordOldCopyWith<RecordOld> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordOldCopyWith<$Res> {
  factory $RecordOldCopyWith(RecordOld value, $Res Function(RecordOld) then) =
      _$RecordOldCopyWithImpl<$Res, RecordOld>;
  @useResult
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
class _$RecordOldCopyWithImpl<$Res, $Val extends RecordOld>
    implements $RecordOldCopyWith<$Res> {
  _$RecordOldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recordId = freezed,
    Object? gameId = freezed,
    Object? tagId = freezed,
    Object? useDeckId = freezed,
    Object? opponentDeckId = freezed,
    Object? date = freezed,
    Object? bo = null,
    Object? firstSecond = null,
    Object? firstMatchFirstSecond = freezed,
    Object? secondMatchFirstSecond = freezed,
    Object? thiredMatchFirstSecond = freezed,
    Object? winLoss = null,
    Object? firstMatchWinLoss = freezed,
    Object? secondMatchWinLoss = freezed,
    Object? thirdMatchWinLoss = freezed,
    Object? memo = freezed,
    Object? imagePath = freezed,
  }) {
    return _then(_value.copyWith(
      recordId: freezed == recordId
          ? _value.recordId
          : recordId // ignore: cast_nullable_to_non_nullable
              as int?,
      gameId: freezed == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int?,
      tagId: freezed == tagId
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as int?,
      useDeckId: freezed == useDeckId
          ? _value.useDeckId
          : useDeckId // ignore: cast_nullable_to_non_nullable
              as int?,
      opponentDeckId: freezed == opponentDeckId
          ? _value.opponentDeckId
          : opponentDeckId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bo: null == bo
          ? _value.bo
          : bo // ignore: cast_nullable_to_non_nullable
              as BO,
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
      thiredMatchFirstSecond: freezed == thiredMatchFirstSecond
          ? _value.thiredMatchFirstSecond
          : thiredMatchFirstSecond // ignore: cast_nullable_to_non_nullable
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
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecordOldCopyWith<$Res> implements $RecordOldCopyWith<$Res> {
  factory _$$_RecordOldCopyWith(
          _$_RecordOld value, $Res Function(_$_RecordOld) then) =
      __$$_RecordOldCopyWithImpl<$Res>;
  @override
  @useResult
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
class __$$_RecordOldCopyWithImpl<$Res>
    extends _$RecordOldCopyWithImpl<$Res, _$_RecordOld>
    implements _$$_RecordOldCopyWith<$Res> {
  __$$_RecordOldCopyWithImpl(
      _$_RecordOld _value, $Res Function(_$_RecordOld) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recordId = freezed,
    Object? gameId = freezed,
    Object? tagId = freezed,
    Object? useDeckId = freezed,
    Object? opponentDeckId = freezed,
    Object? date = freezed,
    Object? bo = null,
    Object? firstSecond = null,
    Object? firstMatchFirstSecond = freezed,
    Object? secondMatchFirstSecond = freezed,
    Object? thiredMatchFirstSecond = freezed,
    Object? winLoss = null,
    Object? firstMatchWinLoss = freezed,
    Object? secondMatchWinLoss = freezed,
    Object? thirdMatchWinLoss = freezed,
    Object? memo = freezed,
    Object? imagePath = freezed,
  }) {
    return _then(_$_RecordOld(
      recordId: freezed == recordId
          ? _value.recordId
          : recordId // ignore: cast_nullable_to_non_nullable
              as int?,
      gameId: freezed == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int?,
      tagId: freezed == tagId
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as int?,
      useDeckId: freezed == useDeckId
          ? _value.useDeckId
          : useDeckId // ignore: cast_nullable_to_non_nullable
              as int?,
      opponentDeckId: freezed == opponentDeckId
          ? _value.opponentDeckId
          : opponentDeckId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bo: null == bo
          ? _value.bo
          : bo // ignore: cast_nullable_to_non_nullable
              as BO,
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
      thiredMatchFirstSecond: freezed == thiredMatchFirstSecond
          ? _value.thiredMatchFirstSecond
          : thiredMatchFirstSecond // ignore: cast_nullable_to_non_nullable
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
      imagePath: freezed == imagePath
          ? _value._imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RecordOld implements _RecordOld {
  _$_RecordOld(
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

  factory _$_RecordOld.fromJson(Map<String, dynamic> json) =>
      _$$_RecordOldFromJson(json);

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
    if (_imagePath is EqualUnmodifiableListView) return _imagePath;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'RecordOld(recordId: $recordId, gameId: $gameId, tagId: $tagId, useDeckId: $useDeckId, opponentDeckId: $opponentDeckId, date: $date, bo: $bo, firstSecond: $firstSecond, firstMatchFirstSecond: $firstMatchFirstSecond, secondMatchFirstSecond: $secondMatchFirstSecond, thiredMatchFirstSecond: $thiredMatchFirstSecond, winLoss: $winLoss, firstMatchWinLoss: $firstMatchWinLoss, secondMatchWinLoss: $secondMatchWinLoss, thirdMatchWinLoss: $thirdMatchWinLoss, memo: $memo, imagePath: $imagePath)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecordOld &&
            (identical(other.recordId, recordId) ||
                other.recordId == recordId) &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.tagId, tagId) || other.tagId == tagId) &&
            (identical(other.useDeckId, useDeckId) ||
                other.useDeckId == useDeckId) &&
            (identical(other.opponentDeckId, opponentDeckId) ||
                other.opponentDeckId == opponentDeckId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.bo, bo) || other.bo == bo) &&
            (identical(other.firstSecond, firstSecond) ||
                other.firstSecond == firstSecond) &&
            (identical(other.firstMatchFirstSecond, firstMatchFirstSecond) ||
                other.firstMatchFirstSecond == firstMatchFirstSecond) &&
            (identical(other.secondMatchFirstSecond, secondMatchFirstSecond) ||
                other.secondMatchFirstSecond == secondMatchFirstSecond) &&
            (identical(other.thiredMatchFirstSecond, thiredMatchFirstSecond) ||
                other.thiredMatchFirstSecond == thiredMatchFirstSecond) &&
            (identical(other.winLoss, winLoss) || other.winLoss == winLoss) &&
            (identical(other.firstMatchWinLoss, firstMatchWinLoss) ||
                other.firstMatchWinLoss == firstMatchWinLoss) &&
            (identical(other.secondMatchWinLoss, secondMatchWinLoss) ||
                other.secondMatchWinLoss == secondMatchWinLoss) &&
            (identical(other.thirdMatchWinLoss, thirdMatchWinLoss) ||
                other.thirdMatchWinLoss == thirdMatchWinLoss) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            const DeepCollectionEquality()
                .equals(other._imagePath, _imagePath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      recordId,
      gameId,
      tagId,
      useDeckId,
      opponentDeckId,
      date,
      bo,
      firstSecond,
      firstMatchFirstSecond,
      secondMatchFirstSecond,
      thiredMatchFirstSecond,
      winLoss,
      firstMatchWinLoss,
      secondMatchWinLoss,
      thirdMatchWinLoss,
      memo,
      const DeepCollectionEquality().hash(_imagePath));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecordOldCopyWith<_$_RecordOld> get copyWith =>
      __$$_RecordOldCopyWithImpl<_$_RecordOld>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecordOldToJson(
      this,
    );
  }
}

abstract class _RecordOld implements RecordOld {
  factory _RecordOld(
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
          final List<String>? imagePath}) = _$_RecordOld;

  factory _RecordOld.fromJson(Map<String, dynamic> json) =
      _$_RecordOld.fromJson;

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
  @override
  @JsonKey(fromJson: _boFromJson, toJson: _boToJson)
  BO get bo;
  @override
  @JsonKey(
      fromJson: _firstSecondFromJson,
      toJson: _firstSecondToJson,
      name: 'first_second')
  FirstSecond get firstSecond;
  @override
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson,
      name: 'first_match_first_second')
  FirstSecond? get firstMatchFirstSecond;
  @override
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson,
      name: 'second_match_first_second')
  FirstSecond? get secondMatchFirstSecond;
  @override
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson,
      name: 'third_match_first_second')
  FirstSecond? get thiredMatchFirstSecond;
  @override
  @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson, name: 'win_loss')
  WinLoss get winLoss;
  @override
  @JsonKey(
      fromJson: _nullableWinLossFromJson,
      toJson: _nullableWinLossToJson,
      name: 'first_match_win_loss')
  WinLoss? get firstMatchWinLoss;
  @override
  @JsonKey(
      fromJson: _nullableWinLossFromJson,
      toJson: _nullableWinLossToJson,
      name: 'second_match_win_loss')
  WinLoss? get secondMatchWinLoss;
  @override
  @JsonKey(
      fromJson: _nullableWinLossFromJson,
      toJson: _nullableWinLossToJson,
      name: 'third_match_win_loss')
  WinLoss? get thirdMatchWinLoss;
  @override
  String? get memo;
  @override
  @JsonKey(
      fromJson: _stringListFromJson,
      toJson: _stringListToJson,
      name: 'image_path')
  List<String>? get imagePath;
  @override
  @JsonKey(ignore: true)
  _$$_RecordOldCopyWith<_$_RecordOld> get copyWith =>
      throw _privateConstructorUsedError;
}
