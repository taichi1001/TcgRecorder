// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'input_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$InputViewState {
  Record? get record => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  Deck? get useDeck => throw _privateConstructorUsedError;
  Deck? get opponentDeck => throw _privateConstructorUsedError;
  List<Tag> get tag => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  WinLoss get winLoss => throw _privateConstructorUsedError;
  WinLoss? get firstMatchWinLoss => throw _privateConstructorUsedError;
  WinLoss? get secondMatchWinLoss => throw _privateConstructorUsedError;
  WinLoss? get thirdMatchWinLoss => throw _privateConstructorUsedError;
  FirstSecond get firstSecond => throw _privateConstructorUsedError;
  FirstSecond? get firstMatchFirstSecond => throw _privateConstructorUsedError;
  FirstSecond? get secondMatchFirstSecond => throw _privateConstructorUsedError;
  FirstSecond? get thirdMatchFirstSecond => throw _privateConstructorUsedError;
  List<XFile> get images => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InputViewStateCopyWith<InputViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InputViewStateCopyWith<$Res> {
  factory $InputViewStateCopyWith(
          InputViewState value, $Res Function(InputViewState) then) =
      _$InputViewStateCopyWithImpl<$Res, InputViewState>;
  @useResult
  $Res call(
      {Record? record,
      DateTime date,
      Deck? useDeck,
      Deck? opponentDeck,
      List<Tag> tag,
      String? memo,
      WinLoss winLoss,
      WinLoss? firstMatchWinLoss,
      WinLoss? secondMatchWinLoss,
      WinLoss? thirdMatchWinLoss,
      FirstSecond firstSecond,
      FirstSecond? firstMatchFirstSecond,
      FirstSecond? secondMatchFirstSecond,
      FirstSecond? thirdMatchFirstSecond,
      List<XFile> images});

  $RecordCopyWith<$Res>? get record;
  $DeckCopyWith<$Res>? get useDeck;
  $DeckCopyWith<$Res>? get opponentDeck;
}

/// @nodoc
class _$InputViewStateCopyWithImpl<$Res, $Val extends InputViewState>
    implements $InputViewStateCopyWith<$Res> {
  _$InputViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? record = freezed,
    Object? date = null,
    Object? useDeck = freezed,
    Object? opponentDeck = freezed,
    Object? tag = null,
    Object? memo = freezed,
    Object? winLoss = null,
    Object? firstMatchWinLoss = freezed,
    Object? secondMatchWinLoss = freezed,
    Object? thirdMatchWinLoss = freezed,
    Object? firstSecond = null,
    Object? firstMatchFirstSecond = freezed,
    Object? secondMatchFirstSecond = freezed,
    Object? thirdMatchFirstSecond = freezed,
    Object? images = null,
  }) {
    return _then(_value.copyWith(
      record: freezed == record
          ? _value.record
          : record // ignore: cast_nullable_to_non_nullable
              as Record?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      useDeck: freezed == useDeck
          ? _value.useDeck
          : useDeck // ignore: cast_nullable_to_non_nullable
              as Deck?,
      opponentDeck: freezed == opponentDeck
          ? _value.opponentDeck
          : opponentDeck // ignore: cast_nullable_to_non_nullable
              as Deck?,
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
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
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<XFile>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RecordCopyWith<$Res>? get record {
    if (_value.record == null) {
      return null;
    }

    return $RecordCopyWith<$Res>(_value.record!, (value) {
      return _then(_value.copyWith(record: value) as $Val);
    });
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
abstract class _$$_InputViewStateCopyWith<$Res>
    implements $InputViewStateCopyWith<$Res> {
  factory _$$_InputViewStateCopyWith(
          _$_InputViewState value, $Res Function(_$_InputViewState) then) =
      __$$_InputViewStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Record? record,
      DateTime date,
      Deck? useDeck,
      Deck? opponentDeck,
      List<Tag> tag,
      String? memo,
      WinLoss winLoss,
      WinLoss? firstMatchWinLoss,
      WinLoss? secondMatchWinLoss,
      WinLoss? thirdMatchWinLoss,
      FirstSecond firstSecond,
      FirstSecond? firstMatchFirstSecond,
      FirstSecond? secondMatchFirstSecond,
      FirstSecond? thirdMatchFirstSecond,
      List<XFile> images});

  @override
  $RecordCopyWith<$Res>? get record;
  @override
  $DeckCopyWith<$Res>? get useDeck;
  @override
  $DeckCopyWith<$Res>? get opponentDeck;
}

/// @nodoc
class __$$_InputViewStateCopyWithImpl<$Res>
    extends _$InputViewStateCopyWithImpl<$Res, _$_InputViewState>
    implements _$$_InputViewStateCopyWith<$Res> {
  __$$_InputViewStateCopyWithImpl(
      _$_InputViewState _value, $Res Function(_$_InputViewState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? record = freezed,
    Object? date = null,
    Object? useDeck = freezed,
    Object? opponentDeck = freezed,
    Object? tag = null,
    Object? memo = freezed,
    Object? winLoss = null,
    Object? firstMatchWinLoss = freezed,
    Object? secondMatchWinLoss = freezed,
    Object? thirdMatchWinLoss = freezed,
    Object? firstSecond = null,
    Object? firstMatchFirstSecond = freezed,
    Object? secondMatchFirstSecond = freezed,
    Object? thirdMatchFirstSecond = freezed,
    Object? images = null,
  }) {
    return _then(_$_InputViewState(
      record: freezed == record
          ? _value.record
          : record // ignore: cast_nullable_to_non_nullable
              as Record?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      useDeck: freezed == useDeck
          ? _value.useDeck
          : useDeck // ignore: cast_nullable_to_non_nullable
              as Deck?,
      opponentDeck: freezed == opponentDeck
          ? _value.opponentDeck
          : opponentDeck // ignore: cast_nullable_to_non_nullable
              as Deck?,
      tag: null == tag
          ? _value._tag
          : tag // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
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
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<XFile>,
    ));
  }
}

/// @nodoc

class _$_InputViewState implements _InputViewState {
  _$_InputViewState(
      {this.record,
      required this.date,
      this.useDeck,
      this.opponentDeck,
      final List<Tag> tag = const [],
      this.memo,
      this.winLoss = WinLoss.win,
      this.firstMatchWinLoss,
      this.secondMatchWinLoss,
      this.thirdMatchWinLoss,
      this.firstSecond = FirstSecond.first,
      this.firstMatchFirstSecond,
      this.secondMatchFirstSecond,
      this.thirdMatchFirstSecond,
      final List<XFile> images = const []})
      : _tag = tag,
        _images = images;

  @override
  final Record? record;
  @override
  final DateTime date;
  @override
  final Deck? useDeck;
  @override
  final Deck? opponentDeck;
  final List<Tag> _tag;
  @override
  @JsonKey()
  List<Tag> get tag {
    if (_tag is EqualUnmodifiableListView) return _tag;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tag);
  }

  @override
  final String? memo;
  @override
  @JsonKey()
  final WinLoss winLoss;
  @override
  final WinLoss? firstMatchWinLoss;
  @override
  final WinLoss? secondMatchWinLoss;
  @override
  final WinLoss? thirdMatchWinLoss;
  @override
  @JsonKey()
  final FirstSecond firstSecond;
  @override
  final FirstSecond? firstMatchFirstSecond;
  @override
  final FirstSecond? secondMatchFirstSecond;
  @override
  final FirstSecond? thirdMatchFirstSecond;
  final List<XFile> _images;
  @override
  @JsonKey()
  List<XFile> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  String toString() {
    return 'InputViewState(record: $record, date: $date, useDeck: $useDeck, opponentDeck: $opponentDeck, tag: $tag, memo: $memo, winLoss: $winLoss, firstMatchWinLoss: $firstMatchWinLoss, secondMatchWinLoss: $secondMatchWinLoss, thirdMatchWinLoss: $thirdMatchWinLoss, firstSecond: $firstSecond, firstMatchFirstSecond: $firstMatchFirstSecond, secondMatchFirstSecond: $secondMatchFirstSecond, thirdMatchFirstSecond: $thirdMatchFirstSecond, images: $images)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InputViewState &&
            (identical(other.record, record) || other.record == record) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.useDeck, useDeck) || other.useDeck == useDeck) &&
            (identical(other.opponentDeck, opponentDeck) ||
                other.opponentDeck == opponentDeck) &&
            const DeepCollectionEquality().equals(other._tag, _tag) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.winLoss, winLoss) || other.winLoss == winLoss) &&
            (identical(other.firstMatchWinLoss, firstMatchWinLoss) ||
                other.firstMatchWinLoss == firstMatchWinLoss) &&
            (identical(other.secondMatchWinLoss, secondMatchWinLoss) ||
                other.secondMatchWinLoss == secondMatchWinLoss) &&
            (identical(other.thirdMatchWinLoss, thirdMatchWinLoss) ||
                other.thirdMatchWinLoss == thirdMatchWinLoss) &&
            (identical(other.firstSecond, firstSecond) ||
                other.firstSecond == firstSecond) &&
            (identical(other.firstMatchFirstSecond, firstMatchFirstSecond) ||
                other.firstMatchFirstSecond == firstMatchFirstSecond) &&
            (identical(other.secondMatchFirstSecond, secondMatchFirstSecond) ||
                other.secondMatchFirstSecond == secondMatchFirstSecond) &&
            (identical(other.thirdMatchFirstSecond, thirdMatchFirstSecond) ||
                other.thirdMatchFirstSecond == thirdMatchFirstSecond) &&
            const DeepCollectionEquality().equals(other._images, _images));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      record,
      date,
      useDeck,
      opponentDeck,
      const DeepCollectionEquality().hash(_tag),
      memo,
      winLoss,
      firstMatchWinLoss,
      secondMatchWinLoss,
      thirdMatchWinLoss,
      firstSecond,
      firstMatchFirstSecond,
      secondMatchFirstSecond,
      thirdMatchFirstSecond,
      const DeepCollectionEquality().hash(_images));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InputViewStateCopyWith<_$_InputViewState> get copyWith =>
      __$$_InputViewStateCopyWithImpl<_$_InputViewState>(this, _$identity);
}

abstract class _InputViewState implements InputViewState {
  factory _InputViewState(
      {final Record? record,
      required final DateTime date,
      final Deck? useDeck,
      final Deck? opponentDeck,
      final List<Tag> tag,
      final String? memo,
      final WinLoss winLoss,
      final WinLoss? firstMatchWinLoss,
      final WinLoss? secondMatchWinLoss,
      final WinLoss? thirdMatchWinLoss,
      final FirstSecond firstSecond,
      final FirstSecond? firstMatchFirstSecond,
      final FirstSecond? secondMatchFirstSecond,
      final FirstSecond? thirdMatchFirstSecond,
      final List<XFile> images}) = _$_InputViewState;

  @override
  Record? get record;
  @override
  DateTime get date;
  @override
  Deck? get useDeck;
  @override
  Deck? get opponentDeck;
  @override
  List<Tag> get tag;
  @override
  String? get memo;
  @override
  WinLoss get winLoss;
  @override
  WinLoss? get firstMatchWinLoss;
  @override
  WinLoss? get secondMatchWinLoss;
  @override
  WinLoss? get thirdMatchWinLoss;
  @override
  FirstSecond get firstSecond;
  @override
  FirstSecond? get firstMatchFirstSecond;
  @override
  FirstSecond? get secondMatchFirstSecond;
  @override
  FirstSecond? get thirdMatchFirstSecond;
  @override
  List<XFile> get images;
  @override
  @JsonKey(ignore: true)
  _$$_InputViewStateCopyWith<_$_InputViewState> get copyWith =>
      throw _privateConstructorUsedError;
}
