// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'input_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$InputViewStateTearOff {
  const _$InputViewStateTearOff();

  _InputViewState call(
      {Record? record,
      required DateTime date,
      DateTime? cacheDate,
      Deck? useDeck,
      Deck? cacheUseDeck,
      Deck? opponentDeck,
      Deck? cacheOpponentDeck,
      Tag? tag,
      Tag? cacheTag,
      bool winLoss = true,
      bool firstSecond = true}) {
    return _InputViewState(
      record: record,
      date: date,
      cacheDate: cacheDate,
      useDeck: useDeck,
      cacheUseDeck: cacheUseDeck,
      opponentDeck: opponentDeck,
      cacheOpponentDeck: cacheOpponentDeck,
      tag: tag,
      cacheTag: cacheTag,
      winLoss: winLoss,
      firstSecond: firstSecond,
    );
  }
}

/// @nodoc
const $InputViewState = _$InputViewStateTearOff();

/// @nodoc
mixin _$InputViewState {
  Record? get record => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  DateTime? get cacheDate => throw _privateConstructorUsedError;
  Deck? get useDeck => throw _privateConstructorUsedError;
  Deck? get cacheUseDeck => throw _privateConstructorUsedError;
  Deck? get opponentDeck => throw _privateConstructorUsedError;
  Deck? get cacheOpponentDeck => throw _privateConstructorUsedError;
  Tag? get tag => throw _privateConstructorUsedError;
  Tag? get cacheTag => throw _privateConstructorUsedError;
  bool get winLoss => throw _privateConstructorUsedError;
  bool get firstSecond => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InputViewStateCopyWith<InputViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InputViewStateCopyWith<$Res> {
  factory $InputViewStateCopyWith(
          InputViewState value, $Res Function(InputViewState) then) =
      _$InputViewStateCopyWithImpl<$Res>;
  $Res call(
      {Record? record,
      DateTime date,
      DateTime? cacheDate,
      Deck? useDeck,
      Deck? cacheUseDeck,
      Deck? opponentDeck,
      Deck? cacheOpponentDeck,
      Tag? tag,
      Tag? cacheTag,
      bool winLoss,
      bool firstSecond});

  $RecordCopyWith<$Res>? get record;
  $DeckCopyWith<$Res>? get useDeck;
  $DeckCopyWith<$Res>? get cacheUseDeck;
  $DeckCopyWith<$Res>? get opponentDeck;
  $DeckCopyWith<$Res>? get cacheOpponentDeck;
  $TagCopyWith<$Res>? get tag;
  $TagCopyWith<$Res>? get cacheTag;
}

/// @nodoc
class _$InputViewStateCopyWithImpl<$Res>
    implements $InputViewStateCopyWith<$Res> {
  _$InputViewStateCopyWithImpl(this._value, this._then);

  final InputViewState _value;
  // ignore: unused_field
  final $Res Function(InputViewState) _then;

  @override
  $Res call({
    Object? record = freezed,
    Object? date = freezed,
    Object? cacheDate = freezed,
    Object? useDeck = freezed,
    Object? cacheUseDeck = freezed,
    Object? opponentDeck = freezed,
    Object? cacheOpponentDeck = freezed,
    Object? tag = freezed,
    Object? cacheTag = freezed,
    Object? winLoss = freezed,
    Object? firstSecond = freezed,
  }) {
    return _then(_value.copyWith(
      record: record == freezed
          ? _value.record
          : record // ignore: cast_nullable_to_non_nullable
              as Record?,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cacheDate: cacheDate == freezed
          ? _value.cacheDate
          : cacheDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      useDeck: useDeck == freezed
          ? _value.useDeck
          : useDeck // ignore: cast_nullable_to_non_nullable
              as Deck?,
      cacheUseDeck: cacheUseDeck == freezed
          ? _value.cacheUseDeck
          : cacheUseDeck // ignore: cast_nullable_to_non_nullable
              as Deck?,
      opponentDeck: opponentDeck == freezed
          ? _value.opponentDeck
          : opponentDeck // ignore: cast_nullable_to_non_nullable
              as Deck?,
      cacheOpponentDeck: cacheOpponentDeck == freezed
          ? _value.cacheOpponentDeck
          : cacheOpponentDeck // ignore: cast_nullable_to_non_nullable
              as Deck?,
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as Tag?,
      cacheTag: cacheTag == freezed
          ? _value.cacheTag
          : cacheTag // ignore: cast_nullable_to_non_nullable
              as Tag?,
      winLoss: winLoss == freezed
          ? _value.winLoss
          : winLoss // ignore: cast_nullable_to_non_nullable
              as bool,
      firstSecond: firstSecond == freezed
          ? _value.firstSecond
          : firstSecond // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $RecordCopyWith<$Res>? get record {
    if (_value.record == null) {
      return null;
    }

    return $RecordCopyWith<$Res>(_value.record!, (value) {
      return _then(_value.copyWith(record: value));
    });
  }

  @override
  $DeckCopyWith<$Res>? get useDeck {
    if (_value.useDeck == null) {
      return null;
    }

    return $DeckCopyWith<$Res>(_value.useDeck!, (value) {
      return _then(_value.copyWith(useDeck: value));
    });
  }

  @override
  $DeckCopyWith<$Res>? get cacheUseDeck {
    if (_value.cacheUseDeck == null) {
      return null;
    }

    return $DeckCopyWith<$Res>(_value.cacheUseDeck!, (value) {
      return _then(_value.copyWith(cacheUseDeck: value));
    });
  }

  @override
  $DeckCopyWith<$Res>? get opponentDeck {
    if (_value.opponentDeck == null) {
      return null;
    }

    return $DeckCopyWith<$Res>(_value.opponentDeck!, (value) {
      return _then(_value.copyWith(opponentDeck: value));
    });
  }

  @override
  $DeckCopyWith<$Res>? get cacheOpponentDeck {
    if (_value.cacheOpponentDeck == null) {
      return null;
    }

    return $DeckCopyWith<$Res>(_value.cacheOpponentDeck!, (value) {
      return _then(_value.copyWith(cacheOpponentDeck: value));
    });
  }

  @override
  $TagCopyWith<$Res>? get tag {
    if (_value.tag == null) {
      return null;
    }

    return $TagCopyWith<$Res>(_value.tag!, (value) {
      return _then(_value.copyWith(tag: value));
    });
  }

  @override
  $TagCopyWith<$Res>? get cacheTag {
    if (_value.cacheTag == null) {
      return null;
    }

    return $TagCopyWith<$Res>(_value.cacheTag!, (value) {
      return _then(_value.copyWith(cacheTag: value));
    });
  }
}

/// @nodoc
abstract class _$InputViewStateCopyWith<$Res>
    implements $InputViewStateCopyWith<$Res> {
  factory _$InputViewStateCopyWith(
          _InputViewState value, $Res Function(_InputViewState) then) =
      __$InputViewStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {Record? record,
      DateTime date,
      DateTime? cacheDate,
      Deck? useDeck,
      Deck? cacheUseDeck,
      Deck? opponentDeck,
      Deck? cacheOpponentDeck,
      Tag? tag,
      Tag? cacheTag,
      bool winLoss,
      bool firstSecond});

  @override
  $RecordCopyWith<$Res>? get record;
  @override
  $DeckCopyWith<$Res>? get useDeck;
  @override
  $DeckCopyWith<$Res>? get cacheUseDeck;
  @override
  $DeckCopyWith<$Res>? get opponentDeck;
  @override
  $DeckCopyWith<$Res>? get cacheOpponentDeck;
  @override
  $TagCopyWith<$Res>? get tag;
  @override
  $TagCopyWith<$Res>? get cacheTag;
}

/// @nodoc
class __$InputViewStateCopyWithImpl<$Res>
    extends _$InputViewStateCopyWithImpl<$Res>
    implements _$InputViewStateCopyWith<$Res> {
  __$InputViewStateCopyWithImpl(
      _InputViewState _value, $Res Function(_InputViewState) _then)
      : super(_value, (v) => _then(v as _InputViewState));

  @override
  _InputViewState get _value => super._value as _InputViewState;

  @override
  $Res call({
    Object? record = freezed,
    Object? date = freezed,
    Object? cacheDate = freezed,
    Object? useDeck = freezed,
    Object? cacheUseDeck = freezed,
    Object? opponentDeck = freezed,
    Object? cacheOpponentDeck = freezed,
    Object? tag = freezed,
    Object? cacheTag = freezed,
    Object? winLoss = freezed,
    Object? firstSecond = freezed,
  }) {
    return _then(_InputViewState(
      record: record == freezed
          ? _value.record
          : record // ignore: cast_nullable_to_non_nullable
              as Record?,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cacheDate: cacheDate == freezed
          ? _value.cacheDate
          : cacheDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      useDeck: useDeck == freezed
          ? _value.useDeck
          : useDeck // ignore: cast_nullable_to_non_nullable
              as Deck?,
      cacheUseDeck: cacheUseDeck == freezed
          ? _value.cacheUseDeck
          : cacheUseDeck // ignore: cast_nullable_to_non_nullable
              as Deck?,
      opponentDeck: opponentDeck == freezed
          ? _value.opponentDeck
          : opponentDeck // ignore: cast_nullable_to_non_nullable
              as Deck?,
      cacheOpponentDeck: cacheOpponentDeck == freezed
          ? _value.cacheOpponentDeck
          : cacheOpponentDeck // ignore: cast_nullable_to_non_nullable
              as Deck?,
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as Tag?,
      cacheTag: cacheTag == freezed
          ? _value.cacheTag
          : cacheTag // ignore: cast_nullable_to_non_nullable
              as Tag?,
      winLoss: winLoss == freezed
          ? _value.winLoss
          : winLoss // ignore: cast_nullable_to_non_nullable
              as bool,
      firstSecond: firstSecond == freezed
          ? _value.firstSecond
          : firstSecond // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_InputViewState implements _InputViewState {
  _$_InputViewState(
      {this.record,
      required this.date,
      this.cacheDate,
      this.useDeck,
      this.cacheUseDeck,
      this.opponentDeck,
      this.cacheOpponentDeck,
      this.tag,
      this.cacheTag,
      this.winLoss = true,
      this.firstSecond = true});

  @override
  final Record? record;
  @override
  final DateTime date;
  @override
  final DateTime? cacheDate;
  @override
  final Deck? useDeck;
  @override
  final Deck? cacheUseDeck;
  @override
  final Deck? opponentDeck;
  @override
  final Deck? cacheOpponentDeck;
  @override
  final Tag? tag;
  @override
  final Tag? cacheTag;
  @JsonKey()
  @override
  final bool winLoss;
  @JsonKey()
  @override
  final bool firstSecond;

  @override
  String toString() {
    return 'InputViewState(record: $record, date: $date, cacheDate: $cacheDate, useDeck: $useDeck, cacheUseDeck: $cacheUseDeck, opponentDeck: $opponentDeck, cacheOpponentDeck: $cacheOpponentDeck, tag: $tag, cacheTag: $cacheTag, winLoss: $winLoss, firstSecond: $firstSecond)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InputViewState &&
            const DeepCollectionEquality().equals(other.record, record) &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality().equals(other.cacheDate, cacheDate) &&
            const DeepCollectionEquality().equals(other.useDeck, useDeck) &&
            const DeepCollectionEquality()
                .equals(other.cacheUseDeck, cacheUseDeck) &&
            const DeepCollectionEquality()
                .equals(other.opponentDeck, opponentDeck) &&
            const DeepCollectionEquality()
                .equals(other.cacheOpponentDeck, cacheOpponentDeck) &&
            const DeepCollectionEquality().equals(other.tag, tag) &&
            const DeepCollectionEquality().equals(other.cacheTag, cacheTag) &&
            const DeepCollectionEquality().equals(other.winLoss, winLoss) &&
            const DeepCollectionEquality()
                .equals(other.firstSecond, firstSecond));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(record),
      const DeepCollectionEquality().hash(date),
      const DeepCollectionEquality().hash(cacheDate),
      const DeepCollectionEquality().hash(useDeck),
      const DeepCollectionEquality().hash(cacheUseDeck),
      const DeepCollectionEquality().hash(opponentDeck),
      const DeepCollectionEquality().hash(cacheOpponentDeck),
      const DeepCollectionEquality().hash(tag),
      const DeepCollectionEquality().hash(cacheTag),
      const DeepCollectionEquality().hash(winLoss),
      const DeepCollectionEquality().hash(firstSecond));

  @JsonKey(ignore: true)
  @override
  _$InputViewStateCopyWith<_InputViewState> get copyWith =>
      __$InputViewStateCopyWithImpl<_InputViewState>(this, _$identity);
}

abstract class _InputViewState implements InputViewState {
  factory _InputViewState(
      {Record? record,
      required DateTime date,
      DateTime? cacheDate,
      Deck? useDeck,
      Deck? cacheUseDeck,
      Deck? opponentDeck,
      Deck? cacheOpponentDeck,
      Tag? tag,
      Tag? cacheTag,
      bool winLoss,
      bool firstSecond}) = _$_InputViewState;

  @override
  Record? get record;
  @override
  DateTime get date;
  @override
  DateTime? get cacheDate;
  @override
  Deck? get useDeck;
  @override
  Deck? get cacheUseDeck;
  @override
  Deck? get opponentDeck;
  @override
  Deck? get cacheOpponentDeck;
  @override
  Tag? get tag;
  @override
  Tag? get cacheTag;
  @override
  bool get winLoss;
  @override
  bool get firstSecond;
  @override
  @JsonKey(ignore: true)
  _$InputViewStateCopyWith<_InputViewState> get copyWith =>
      throw _privateConstructorUsedError;
}
