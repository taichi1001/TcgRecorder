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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Game _$GameFromJson(Map<String, dynamic> json) {
  return _Game.fromJson(json);
}

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
abstract class _$$_GameCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$$_GameCopyWith(_$_Game value, $Res Function(_$_Game) then) =
      __$$_GameCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'game_id')
          int? gameId,
      String game,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker')
          bool isVisibleToPicker});
}

/// @nodoc
class __$$_GameCopyWithImpl<$Res> extends _$GameCopyWithImpl<$Res>
    implements _$$_GameCopyWith<$Res> {
  __$$_GameCopyWithImpl(_$_Game _value, $Res Function(_$_Game) _then)
      : super(_value, (v) => _then(v as _$_Game));

  @override
  _$_Game get _value => super._value as _$_Game;

  @override
  $Res call({
    Object? gameId = freezed,
    Object? game = freezed,
    Object? isVisibleToPicker = freezed,
  }) {
    return _then(_$_Game(
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
            other is _$_Game &&
            const DeepCollectionEquality().equals(other.gameId, gameId) &&
            const DeepCollectionEquality().equals(other.game, game) &&
            const DeepCollectionEquality()
                .equals(other.isVisibleToPicker, isVisibleToPicker));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(gameId),
      const DeepCollectionEquality().hash(game),
      const DeepCollectionEquality().hash(isVisibleToPicker));

  @JsonKey(ignore: true)
  @override
  _$$_GameCopyWith<_$_Game> get copyWith =>
      __$$_GameCopyWithImpl<_$_Game>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GameToJson(this);
  }
}

abstract class _Game implements Game {
  factory _Game(
      {@JsonKey(name: 'game_id')
          final int? gameId,
      required final String game,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker')
          final bool isVisibleToPicker}) = _$_Game;

  factory _Game.fromJson(Map<String, dynamic> json) = _$_Game.fromJson;

  @override
  @JsonKey(name: 'game_id')
  int? get gameId => throw _privateConstructorUsedError;
  @override
  String get game => throw _privateConstructorUsedError;
  @override
  @JsonKey(
      fromJson: _boolFromJson,
      toJson: _boolToJson,
      name: 'is_visible_to_picker')
  bool get isVisibleToPicker => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_GameCopyWith<_$_Game> get copyWith => throw _privateConstructorUsedError;
}
