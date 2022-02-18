// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Game _$GameFromJson(Map<String, dynamic> json) {
  return _Game.fromJson(json);
}

/// @nodoc
class _$GameTearOff {
  const _$GameTearOff();

  _Game call(
      {@JsonKey(name: 'game_id')
          int? gameId,
      required String game,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker')
          bool isVisibleToPicker = true}) {
    return _Game(
      gameId: gameId,
      game: game,
      isVisibleToPicker: isVisibleToPicker,
    );
  }

  Game fromJson(Map<String, Object?> json) {
    return Game.fromJson(json);
  }
}

/// @nodoc
const $Game = _$GameTearOff();

/// @nodoc
mixin _$Game {
  @JsonKey(name: 'game_id')
  int? get gameId => throw _privateConstructorUsedError;
  String get game => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: _boolFromJson,
      toJson: _boolToJson,
      name: 'is_visible_to_picker')
  bool get isVisibleToPicker => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameCopyWith<Game> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCopyWith<$Res> {
  factory $GameCopyWith(Game value, $Res Function(Game) then) =
      _$GameCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'game_id')
          int? gameId,
      String game,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker')
          bool isVisibleToPicker});
}

/// @nodoc
class _$GameCopyWithImpl<$Res> implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._value, this._then);

  final Game _value;
  // ignore: unused_field
  final $Res Function(Game) _then;

  @override
  $Res call({
    Object? gameId = freezed,
    Object? game = freezed,
    Object? isVisibleToPicker = freezed,
  }) {
    return _then(_value.copyWith(
      gameId: gameId == freezed
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int?,
      game: game == freezed
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as String,
      isVisibleToPicker: isVisibleToPicker == freezed
          ? _value.isVisibleToPicker
          : isVisibleToPicker // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$GameCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$GameCopyWith(_Game value, $Res Function(_Game) then) =
      __$GameCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'game_id')
          int? gameId,
      String game,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker')
          bool isVisibleToPicker});
}

/// @nodoc
class __$GameCopyWithImpl<$Res> extends _$GameCopyWithImpl<$Res>
    implements _$GameCopyWith<$Res> {
  __$GameCopyWithImpl(_Game _value, $Res Function(_Game) _then)
      : super(_value, (v) => _then(v as _Game));

  @override
  _Game get _value => super._value as _Game;

  @override
  $Res call({
    Object? gameId = freezed,
    Object? game = freezed,
    Object? isVisibleToPicker = freezed,
  }) {
    return _then(_Game(
      gameId: gameId == freezed
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int?,
      game: game == freezed
          ? _value.game
          : game // ignore: cast_nullable_to_non_nullable
              as String,
      isVisibleToPicker: isVisibleToPicker == freezed
          ? _value.isVisibleToPicker
          : isVisibleToPicker // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Game implements _Game {
  _$_Game(
      {@JsonKey(name: 'game_id')
          this.gameId,
      required this.game,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker')
          this.isVisibleToPicker = true});

  factory _$_Game.fromJson(Map<String, dynamic> json) => _$$_GameFromJson(json);

  @override
  @JsonKey(name: 'game_id')
  final int? gameId;
  @override
  final String game;
  @override
  @JsonKey(
      fromJson: _boolFromJson,
      toJson: _boolToJson,
      name: 'is_visible_to_picker')
  final bool isVisibleToPicker;

  @override
  String toString() {
    return 'Game(gameId: $gameId, game: $game, isVisibleToPicker: $isVisibleToPicker)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Game &&
            const DeepCollectionEquality().equals(other.gameId, gameId) &&
            const DeepCollectionEquality().equals(other.game, game) &&
            const DeepCollectionEquality()
                .equals(other.isVisibleToPicker, isVisibleToPicker));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(gameId),
      const DeepCollectionEquality().hash(game),
      const DeepCollectionEquality().hash(isVisibleToPicker));

  @JsonKey(ignore: true)
  @override
  _$GameCopyWith<_Game> get copyWith =>
      __$GameCopyWithImpl<_Game>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GameToJson(this);
  }
}

abstract class _Game implements Game {
  factory _Game(
      {@JsonKey(name: 'game_id')
          int? gameId,
      required String game,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker')
          bool isVisibleToPicker}) = _$_Game;

  factory _Game.fromJson(Map<String, dynamic> json) = _$_Game.fromJson;

  @override
  @JsonKey(name: 'game_id')
  int? get gameId;
  @override
  String get game;
  @override
  @JsonKey(
      fromJson: _boolFromJson,
      toJson: _boolToJson,
      name: 'is_visible_to_picker')
  bool get isVisibleToPicker;
  @override
  @JsonKey(ignore: true)
  _$GameCopyWith<_Game> get copyWith => throw _privateConstructorUsedError;
}
