// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deck.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Deck _$DeckFromJson(Map<String, dynamic> json) {
  return _Deck.fromJson(json);
}

/// @nodoc
mixin _$Deck {
  int? get deckId => throw _privateConstructorUsedError;
  String get deck => throw _privateConstructorUsedError;
  int? get gameId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
  bool get isVisibleToPicker => throw _privateConstructorUsedError;
  int? get sortIndex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeckCopyWith<Deck> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeckCopyWith<$Res> {
  factory $DeckCopyWith(Deck value, $Res Function(Deck) then) =
      _$DeckCopyWithImpl<$Res, Deck>;
  @useResult
  $Res call(
      {int? deckId,
      String deck,
      int? gameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
          bool isVisibleToPicker,
      int? sortIndex});
}

/// @nodoc
class _$DeckCopyWithImpl<$Res, $Val extends Deck>
    implements $DeckCopyWith<$Res> {
  _$DeckCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deckId = freezed,
    Object? deck = null,
    Object? gameId = freezed,
    Object? isVisibleToPicker = null,
    Object? sortIndex = freezed,
  }) {
    return _then(_value.copyWith(
      deckId: freezed == deckId
          ? _value.deckId
          : deckId // ignore: cast_nullable_to_non_nullable
              as int?,
      deck: null == deck
          ? _value.deck
          : deck // ignore: cast_nullable_to_non_nullable
              as String,
      gameId: freezed == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int?,
      isVisibleToPicker: null == isVisibleToPicker
          ? _value.isVisibleToPicker
          : isVisibleToPicker // ignore: cast_nullable_to_non_nullable
              as bool,
      sortIndex: freezed == sortIndex
          ? _value.sortIndex
          : sortIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DeckCopyWith<$Res> implements $DeckCopyWith<$Res> {
  factory _$$_DeckCopyWith(_$_Deck value, $Res Function(_$_Deck) then) =
      __$$_DeckCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? deckId,
      String deck,
      int? gameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
          bool isVisibleToPicker,
      int? sortIndex});
}

/// @nodoc
class __$$_DeckCopyWithImpl<$Res> extends _$DeckCopyWithImpl<$Res, _$_Deck>
    implements _$$_DeckCopyWith<$Res> {
  __$$_DeckCopyWithImpl(_$_Deck _value, $Res Function(_$_Deck) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deckId = freezed,
    Object? deck = null,
    Object? gameId = freezed,
    Object? isVisibleToPicker = null,
    Object? sortIndex = freezed,
  }) {
    return _then(_$_Deck(
      deckId: freezed == deckId
          ? _value.deckId
          : deckId // ignore: cast_nullable_to_non_nullable
              as int?,
      deck: null == deck
          ? _value.deck
          : deck // ignore: cast_nullable_to_non_nullable
              as String,
      gameId: freezed == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int?,
      isVisibleToPicker: null == isVisibleToPicker
          ? _value.isVisibleToPicker
          : isVisibleToPicker // ignore: cast_nullable_to_non_nullable
              as bool,
      sortIndex: freezed == sortIndex
          ? _value.sortIndex
          : sortIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Deck implements _Deck {
  _$_Deck(
      {this.deckId,
      required this.deck,
      this.gameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
          this.isVisibleToPicker = true,
      this.sortIndex});

  factory _$_Deck.fromJson(Map<String, dynamic> json) => _$$_DeckFromJson(json);

  @override
  final int? deckId;
  @override
  final String deck;
  @override
  final int? gameId;
  @override
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
  final bool isVisibleToPicker;
  @override
  final int? sortIndex;

  @override
  String toString() {
    return 'Deck(deckId: $deckId, deck: $deck, gameId: $gameId, isVisibleToPicker: $isVisibleToPicker, sortIndex: $sortIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Deck &&
            (identical(other.deckId, deckId) || other.deckId == deckId) &&
            (identical(other.deck, deck) || other.deck == deck) &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.isVisibleToPicker, isVisibleToPicker) ||
                other.isVisibleToPicker == isVisibleToPicker) &&
            (identical(other.sortIndex, sortIndex) ||
                other.sortIndex == sortIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, deckId, deck, gameId, isVisibleToPicker, sortIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeckCopyWith<_$_Deck> get copyWith =>
      __$$_DeckCopyWithImpl<_$_Deck>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DeckToJson(
      this,
    );
  }
}

abstract class _Deck implements Deck {
  factory _Deck(
      {final int? deckId,
      required final String deck,
      final int? gameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
          final bool isVisibleToPicker,
      final int? sortIndex}) = _$_Deck;

  factory _Deck.fromJson(Map<String, dynamic> json) = _$_Deck.fromJson;

  @override
  int? get deckId;
  @override
  String get deck;
  @override
  int? get gameId;
  @override
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
  bool get isVisibleToPicker;
  @override
  int? get sortIndex;
  @override
  @JsonKey(ignore: true)
  _$$_DeckCopyWith<_$_Deck> get copyWith => throw _privateConstructorUsedError;
}
