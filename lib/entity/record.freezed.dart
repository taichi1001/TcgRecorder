// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Record _$RecordFromJson(Map<String, dynamic> json) {
  return _Record.fromJson(json);
}

/// @nodoc
mixin _$Record {
  @JsonKey(name: 'record_id')
  int? get id => throw _privateConstructorUsedError;
  int? get gameId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _intListFromJson, toJson: _intListToJson)
  List<int> get tagId => throw _privateConstructorUsedError;
  int? get useDeckId => throw _privateConstructorUsedError;
  int? get opponentDeckId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? get date => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _boFromJson, toJson: _boToJson)
  BO get bo => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson)
  FirstSecond get firstSecond => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson)
  FirstSecond? get firstMatchFirstSecond => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson)
  FirstSecond? get secondMatchFirstSecond => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson)
  FirstSecond? get thirdMatchFirstSecond => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson)
  WinLoss get winLoss => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
  WinLoss? get firstMatchWinLoss => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
  WinLoss? get secondMatchWinLoss => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
  WinLoss? get thirdMatchWinLoss => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _stringListFromJson, toJson: _stringListToJson)
  List<String>? get imagePath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecordCopyWith<Record> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordCopyWith<$Res> {
  factory $RecordCopyWith(Record value, $Res Function(Record) then) =
      _$RecordCopyWithImpl<$Res, Record>;
  @useResult
  $Res call(
      {@JsonKey(name: 'record_id') int? id,
      int? gameId,
      @JsonKey(fromJson: _intListFromJson, toJson: _intListToJson)
      List<int> tagId,
      int? useDeckId,
      int? opponentDeckId,
      @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
      DateTime? date,
      @JsonKey(fromJson: _boFromJson, toJson: _boToJson) BO bo,
      @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson)
      FirstSecond firstSecond,
      @JsonKey(
          fromJson: _nullableFirstSecondFromJson,
          toJson: _nullableFirstSecondToJson)
      FirstSecond? firstMatchFirstSecond,
      @JsonKey(
          fromJson: _nullableFirstSecondFromJson,
          toJson: _nullableFirstSecondToJson)
      FirstSecond? secondMatchFirstSecond,
      @JsonKey(
          fromJson: _nullableFirstSecondFromJson,
          toJson: _nullableFirstSecondToJson)
      FirstSecond? thirdMatchFirstSecond,
      @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson)
      WinLoss winLoss,
      @JsonKey(
          fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
      WinLoss? firstMatchWinLoss,
      @JsonKey(
          fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
      WinLoss? secondMatchWinLoss,
      @JsonKey(
          fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
      WinLoss? thirdMatchWinLoss,
      String? memo,
      String? author,
      @JsonKey(fromJson: _stringListFromJson, toJson: _stringListToJson)
      List<String>? imagePath});
}

/// @nodoc
class _$RecordCopyWithImpl<$Res, $Val extends Record>
    implements $RecordCopyWith<$Res> {
  _$RecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? gameId = freezed,
    Object? tagId = null,
    Object? useDeckId = freezed,
    Object? opponentDeckId = freezed,
    Object? date = freezed,
    Object? bo = null,
    Object? firstSecond = null,
    Object? firstMatchFirstSecond = freezed,
    Object? secondMatchFirstSecond = freezed,
    Object? thirdMatchFirstSecond = freezed,
    Object? winLoss = null,
    Object? firstMatchWinLoss = freezed,
    Object? secondMatchWinLoss = freezed,
    Object? thirdMatchWinLoss = freezed,
    Object? memo = freezed,
    Object? author = freezed,
    Object? imagePath = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      gameId: freezed == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int?,
      tagId: null == tagId
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as List<int>,
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
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecordImplCopyWith<$Res> implements $RecordCopyWith<$Res> {
  factory _$$RecordImplCopyWith(
          _$RecordImpl value, $Res Function(_$RecordImpl) then) =
      __$$RecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'record_id') int? id,
      int? gameId,
      @JsonKey(fromJson: _intListFromJson, toJson: _intListToJson)
      List<int> tagId,
      int? useDeckId,
      int? opponentDeckId,
      @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
      DateTime? date,
      @JsonKey(fromJson: _boFromJson, toJson: _boToJson) BO bo,
      @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson)
      FirstSecond firstSecond,
      @JsonKey(
          fromJson: _nullableFirstSecondFromJson,
          toJson: _nullableFirstSecondToJson)
      FirstSecond? firstMatchFirstSecond,
      @JsonKey(
          fromJson: _nullableFirstSecondFromJson,
          toJson: _nullableFirstSecondToJson)
      FirstSecond? secondMatchFirstSecond,
      @JsonKey(
          fromJson: _nullableFirstSecondFromJson,
          toJson: _nullableFirstSecondToJson)
      FirstSecond? thirdMatchFirstSecond,
      @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson)
      WinLoss winLoss,
      @JsonKey(
          fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
      WinLoss? firstMatchWinLoss,
      @JsonKey(
          fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
      WinLoss? secondMatchWinLoss,
      @JsonKey(
          fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
      WinLoss? thirdMatchWinLoss,
      String? memo,
      String? author,
      @JsonKey(fromJson: _stringListFromJson, toJson: _stringListToJson)
      List<String>? imagePath});
}

/// @nodoc
class __$$RecordImplCopyWithImpl<$Res>
    extends _$RecordCopyWithImpl<$Res, _$RecordImpl>
    implements _$$RecordImplCopyWith<$Res> {
  __$$RecordImplCopyWithImpl(
      _$RecordImpl _value, $Res Function(_$RecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? gameId = freezed,
    Object? tagId = null,
    Object? useDeckId = freezed,
    Object? opponentDeckId = freezed,
    Object? date = freezed,
    Object? bo = null,
    Object? firstSecond = null,
    Object? firstMatchFirstSecond = freezed,
    Object? secondMatchFirstSecond = freezed,
    Object? thirdMatchFirstSecond = freezed,
    Object? winLoss = null,
    Object? firstMatchWinLoss = freezed,
    Object? secondMatchWinLoss = freezed,
    Object? thirdMatchWinLoss = freezed,
    Object? memo = freezed,
    Object? author = freezed,
    Object? imagePath = freezed,
  }) {
    return _then(_$RecordImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      gameId: freezed == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int?,
      tagId: null == tagId
          ? _value._tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as List<int>,
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
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
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
class _$RecordImpl implements _Record {
  _$RecordImpl(
      {@JsonKey(name: 'record_id') this.id,
      this.gameId,
      @JsonKey(fromJson: _intListFromJson, toJson: _intListToJson)
      final List<int> tagId = const [],
      this.useDeckId,
      this.opponentDeckId,
      @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) this.date,
      @JsonKey(fromJson: _boFromJson, toJson: _boToJson) this.bo = BO.bo1,
      @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson)
      this.firstSecond = FirstSecond.first,
      @JsonKey(
          fromJson: _nullableFirstSecondFromJson,
          toJson: _nullableFirstSecondToJson)
      this.firstMatchFirstSecond,
      @JsonKey(
          fromJson: _nullableFirstSecondFromJson,
          toJson: _nullableFirstSecondToJson)
      this.secondMatchFirstSecond,
      @JsonKey(
          fromJson: _nullableFirstSecondFromJson,
          toJson: _nullableFirstSecondToJson)
      this.thirdMatchFirstSecond,
      @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson)
      this.winLoss = WinLoss.win,
      @JsonKey(
          fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
      this.firstMatchWinLoss,
      @JsonKey(
          fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
      this.secondMatchWinLoss,
      @JsonKey(
          fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
      this.thirdMatchWinLoss,
      this.memo,
      this.author,
      @JsonKey(fromJson: _stringListFromJson, toJson: _stringListToJson)
      final List<String>? imagePath})
      : _tagId = tagId,
        _imagePath = imagePath;

  factory _$RecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecordImplFromJson(json);

  @override
  @JsonKey(name: 'record_id')
  final int? id;
  @override
  final int? gameId;
  final List<int> _tagId;
  @override
  @JsonKey(fromJson: _intListFromJson, toJson: _intListToJson)
  List<int> get tagId {
    if (_tagId is EqualUnmodifiableListView) return _tagId;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tagId);
  }

  @override
  final int? useDeckId;
  @override
  final int? opponentDeckId;
  @override
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime? date;
  @override
  @JsonKey(fromJson: _boFromJson, toJson: _boToJson)
  final BO bo;
  @override
  @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson)
  final FirstSecond firstSecond;
  @override
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson)
  final FirstSecond? firstMatchFirstSecond;
  @override
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson)
  final FirstSecond? secondMatchFirstSecond;
  @override
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson)
  final FirstSecond? thirdMatchFirstSecond;
  @override
  @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson)
  final WinLoss winLoss;
  @override
  @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
  final WinLoss? firstMatchWinLoss;
  @override
  @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
  final WinLoss? secondMatchWinLoss;
  @override
  @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
  final WinLoss? thirdMatchWinLoss;
  @override
  final String? memo;
  @override
  final String? author;
  final List<String>? _imagePath;
  @override
  @JsonKey(fromJson: _stringListFromJson, toJson: _stringListToJson)
  List<String>? get imagePath {
    final value = _imagePath;
    if (value == null) return null;
    if (_imagePath is EqualUnmodifiableListView) return _imagePath;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Record(id: $id, gameId: $gameId, tagId: $tagId, useDeckId: $useDeckId, opponentDeckId: $opponentDeckId, date: $date, bo: $bo, firstSecond: $firstSecond, firstMatchFirstSecond: $firstMatchFirstSecond, secondMatchFirstSecond: $secondMatchFirstSecond, thirdMatchFirstSecond: $thirdMatchFirstSecond, winLoss: $winLoss, firstMatchWinLoss: $firstMatchWinLoss, secondMatchWinLoss: $secondMatchWinLoss, thirdMatchWinLoss: $thirdMatchWinLoss, memo: $memo, author: $author, imagePath: $imagePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            const DeepCollectionEquality().equals(other._tagId, _tagId) &&
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
            (identical(other.author, author) || other.author == author) &&
            const DeepCollectionEquality()
                .equals(other._imagePath, _imagePath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      gameId,
      const DeepCollectionEquality().hash(_tagId),
      useDeckId,
      opponentDeckId,
      date,
      bo,
      firstSecond,
      firstMatchFirstSecond,
      secondMatchFirstSecond,
      thirdMatchFirstSecond,
      winLoss,
      firstMatchWinLoss,
      secondMatchWinLoss,
      thirdMatchWinLoss,
      memo,
      author,
      const DeepCollectionEquality().hash(_imagePath));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordImplCopyWith<_$RecordImpl> get copyWith =>
      __$$RecordImplCopyWithImpl<_$RecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecordImplToJson(
      this,
    );
  }
}

abstract class _Record implements Record {
  factory _Record(
      {@JsonKey(name: 'record_id') final int? id,
      final int? gameId,
      @JsonKey(fromJson: _intListFromJson, toJson: _intListToJson)
      final List<int> tagId,
      final int? useDeckId,
      final int? opponentDeckId,
      @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
      final DateTime? date,
      @JsonKey(fromJson: _boFromJson, toJson: _boToJson) final BO bo,
      @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson)
      final FirstSecond firstSecond,
      @JsonKey(
          fromJson: _nullableFirstSecondFromJson,
          toJson: _nullableFirstSecondToJson)
      final FirstSecond? firstMatchFirstSecond,
      @JsonKey(
          fromJson: _nullableFirstSecondFromJson,
          toJson: _nullableFirstSecondToJson)
      final FirstSecond? secondMatchFirstSecond,
      @JsonKey(
          fromJson: _nullableFirstSecondFromJson,
          toJson: _nullableFirstSecondToJson)
      final FirstSecond? thirdMatchFirstSecond,
      @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson)
      final WinLoss winLoss,
      @JsonKey(
          fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
      final WinLoss? firstMatchWinLoss,
      @JsonKey(
          fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
      final WinLoss? secondMatchWinLoss,
      @JsonKey(
          fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
      final WinLoss? thirdMatchWinLoss,
      final String? memo,
      final String? author,
      @JsonKey(fromJson: _stringListFromJson, toJson: _stringListToJson)
      final List<String>? imagePath}) = _$RecordImpl;

  factory _Record.fromJson(Map<String, dynamic> json) = _$RecordImpl.fromJson;

  @override
  @JsonKey(name: 'record_id')
  int? get id;
  @override
  int? get gameId;
  @override
  @JsonKey(fromJson: _intListFromJson, toJson: _intListToJson)
  List<int> get tagId;
  @override
  int? get useDeckId;
  @override
  int? get opponentDeckId;
  @override
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? get date;
  @override
  @JsonKey(fromJson: _boFromJson, toJson: _boToJson)
  BO get bo;
  @override
  @JsonKey(fromJson: _firstSecondFromJson, toJson: _firstSecondToJson)
  FirstSecond get firstSecond;
  @override
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson)
  FirstSecond? get firstMatchFirstSecond;
  @override
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson)
  FirstSecond? get secondMatchFirstSecond;
  @override
  @JsonKey(
      fromJson: _nullableFirstSecondFromJson,
      toJson: _nullableFirstSecondToJson)
  FirstSecond? get thirdMatchFirstSecond;
  @override
  @JsonKey(fromJson: _winLossFromJson, toJson: _winLossToJson)
  WinLoss get winLoss;
  @override
  @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
  WinLoss? get firstMatchWinLoss;
  @override
  @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
  WinLoss? get secondMatchWinLoss;
  @override
  @JsonKey(fromJson: _nullableWinLossFromJson, toJson: _nullableWinLossToJson)
  WinLoss? get thirdMatchWinLoss;
  @override
  String? get memo;
  @override
  String? get author;
  @override
  @JsonKey(fromJson: _stringListFromJson, toJson: _stringListToJson)
  List<String>? get imagePath;
  @override
  @JsonKey(ignore: true)
  _$$RecordImplCopyWith<_$RecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
