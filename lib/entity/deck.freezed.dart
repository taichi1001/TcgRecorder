// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
  @JsonKey(name: 'deck_id')
  int? get deckId => throw _privateConstructorUsedError;
  String get deck => throw _privateConstructorUsedError;
  @JsonKey(name: 'game_id')
  int? get gameId => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: _boolFromJson,
      toJson: _boolToJson,
      name: 'is_visible_to_picker')
  bool get isVisibleToPicker => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_index')
  int? get sortIndex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeckCopyWith<Deck> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeckCopyWith<$Res> {
  factory $DeckCopyWith(Deck value, $Res Function(Deck) then) =
      _$DeckCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'deck_id')
          int? deckId,
      String deck,
      @JsonKey(name: 'game_id')
          int? gameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker')
          bool isVisibleToPicker,
      @JsonKey(name: 'sort_index')
          int? sortIndex});
}

/// @nodoc
class _$DeckCopyWithImpl<$Res> implements $DeckCopyWith<$Res> {
  _$DeckCopyWithImpl(this._value, this._then);

  final Deck _value;
  // ignore: unused_field
  final $Res Function(Deck) _then;

  @override
  $Res call({
    Object? deckId = freezed,
    Object? deck = freezed,
    Object? gameId = freezed,
    Object? isVisibleToPicker = freezed,
    Object? sortIndex = freezed,
  }) {
    return _then(_value.copyWith(
      deckId: deckId == freezed
          ? _value.deckId
          : deckId // ignore: cast_nullable_to_non_nullable
              as int?,
      deck: deck == freezed
          ? _value.deck
          : deck // ignore: cast_nullable_to_non_nullable
              as String,
      gameId: gameId == freezed
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int?,
      isVisibleToPicker: isVisibleToPicker == freezed
          ? _value.isVisibleToPicker
          : isVisibleToPicker // ignore: cast_nullable_to_non_nullable
              as bool,
      sortIndex: sortIndex == freezed
          ? _value.sortIndex
          : sortIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_DeckCopyWith<$Res> implements $DeckCopyWith<$Res> {
  factory _$$_DeckCopyWith(_$_Deck value, $Res Function(_$_Deck) then) =
      __$$_DeckCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'deck_id')
          int? deckId,
      String deck,
      @JsonKey(name: 'game_id')
          int? gameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker')
          bool isVisibleToPicker,
      @JsonKey(name: 'sort_index')
          int? sortIndex});
}

/// @nodoc
class __$$_DeckCopyWithImpl<$Res> extends _$DeckCopyWithImpl<$Res>
    implements _$$_DeckCopyWith<$Res> {
  __$$_DeckCopyWithImpl(_$_Deck _value, $Res Function(_$_Deck) _then)
      : super(_value, (v) => _then(v as _$_Deck));

  @override
  _$_Deck get _value => super._value as _$_Deck;

  @override
  $Res call({
    Object? deckId = freezed,
    Object? deck = freezed,
    Object? gameId = freezed,
    Object? isVisibleToPicker = freezed,
    Object? sortIndex = freezed,
  }) {
    return _then(_$_Deck(
      deckId: deckId == freezed
          ? _value.deckId
          : deckId // ignore: cast_nullable_to_non_nullable
              as int?,
      deck: deck == freezed
          ? _value.deck
          : deck // ignore: cast_nullable_to_non_nullable
              as String,
      gameId: gameId == freezed
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int?,
      isVisibleToPicker: isVisibleToPicker == freezed
          ? _value.isVisibleToPicker
          : isVisibleToPicker // ignore: cast_nullable_to_non_nullable
              as bool,
      sortIndex: sortIndex == freezed
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
      {@JsonKey(name: 'deck_id')
          this.deckId,
      required this.deck,
      @JsonKey(name: 'game_id')
          this.gameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker')
          this.isVisibleToPicker = true,
      @JsonKey(name: 'sort_index')
          this.sortIndex});

  factory _$_Deck.fromJson(Map<String, dynamic> json) => _$$_DeckFromJson(json);

  @override
  @JsonKey(name: 'deck_id')
  final int? deckId;
  @override
  final String deck;
  @override
  @JsonKey(name: 'game_id')
  final int? gameId;
  @override
  @JsonKey(
      fromJson: _boolFromJson,
      toJson: _boolToJson,
      name: 'is_visible_to_picker')
  final bool isVisibleToPicker;
  @override
  @JsonKey(name: 'sort_index')
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
            const DeepCollectionEquality().equals(other.deckId, deckId) &&
            const DeepCollectionEquality().equals(other.deck, deck) &&
            const DeepCollectionEquality().equals(other.gameId, gameId) &&
            const DeepCollectionEquality()
                .equals(other.isVisibleToPicker, isVisibleToPicker) &&
            const DeepCollectionEquality().equals(other.sortIndex, sortIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(deckId),
      const DeepCollectionEquality().hash(deck),
      const DeepCollectionEquality().hash(gameId),
      const DeepCollectionEquality().hash(isVisibleToPicker),
      const DeepCollectionEquality().hash(sortIndex));

  @JsonKey(ignore: true)
  @override
  _$$_DeckCopyWith<_$_Deck> get copyWith =>
      __$$_DeckCopyWithImpl<_$_Deck>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DeckToJson(this);
  }
}

abstract class _Deck implements Deck {
  factory _Deck(
      {@JsonKey(name: 'deck_id')
          final int? deckId,
      required final String deck,
      @JsonKey(name: 'game_id')
          final int? gameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker')
          final bool isVisibleToPicker,
      @JsonKey(name: 'sort_index')
          final int? sortIndex}) = _$_Deck;

  factory _Deck.fromJson(Map<String, dynamic> json) = _$_Deck.fromJson;

  @override
  @JsonKey(name: 'deck_id')
  int? get deckId => throw _privateConstructorUsedError;
  @override
  String get deck => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'game_id')
  int? get gameId => throw _privateConstructorUsedError;
  @override
  @JsonKey(
      fromJson: _boolFromJson,
      toJson: _boolToJson,
      name: 'is_visible_to_picker')
  bool get isVisibleToPicker => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'sort_index')
  int? get sortIndex => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_DeckCopyWith<_$_Deck> get copyWith => throw _privateConstructorUsedError;
}
