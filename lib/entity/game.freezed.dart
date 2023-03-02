// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'game')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
  bool get isVisibleToPicker => throw _privateConstructorUsedError;
  int? get sortIndex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameCopyWith<Game> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCopyWith<$Res> {
  factory $GameCopyWith(Game value, $Res Function(Game) then) =
      _$GameCopyWithImpl<$Res, Game>;
  @useResult
  $Res call(
      {@JsonKey(name: 'game_id')
          int? id,
      @JsonKey(name: 'game')
          String name,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
          bool isVisibleToPicker,
      int? sortIndex});
}

/// @nodoc
class _$GameCopyWithImpl<$Res, $Val extends Game>
    implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? isVisibleToPicker = null,
    Object? sortIndex = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$_GameCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$$_GameCopyWith(_$_Game value, $Res Function(_$_Game) then) =
      __$$_GameCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'game_id')
          int? id,
      @JsonKey(name: 'game')
          String name,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
          bool isVisibleToPicker,
      int? sortIndex});
}

/// @nodoc
class __$$_GameCopyWithImpl<$Res> extends _$GameCopyWithImpl<$Res, _$_Game>
    implements _$$_GameCopyWith<$Res> {
  __$$_GameCopyWithImpl(_$_Game _value, $Res Function(_$_Game) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? isVisibleToPicker = null,
    Object? sortIndex = freezed,
  }) {
    return _then(_$_Game(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$_Game implements _Game {
  _$_Game(
      {@JsonKey(name: 'game_id')
          this.id,
      @JsonKey(name: 'game')
          required this.name,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
          this.isVisibleToPicker = true,
      this.sortIndex});

  factory _$_Game.fromJson(Map<String, dynamic> json) => _$$_GameFromJson(json);

  @override
  @JsonKey(name: 'game_id')
  final int? id;
  @override
  @JsonKey(name: 'game')
  final String name;
  @override
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
  final bool isVisibleToPicker;
  @override
  final int? sortIndex;

  @override
  String toString() {
    return 'Game(id: $id, name: $name, isVisibleToPicker: $isVisibleToPicker, sortIndex: $sortIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Game &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isVisibleToPicker, isVisibleToPicker) ||
                other.isVisibleToPicker == isVisibleToPicker) &&
            (identical(other.sortIndex, sortIndex) ||
                other.sortIndex == sortIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, isVisibleToPicker, sortIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameCopyWith<_$_Game> get copyWith =>
      __$$_GameCopyWithImpl<_$_Game>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GameToJson(
      this,
    );
  }
}

abstract class _Game implements Game {
  factory _Game(
      {@JsonKey(name: 'game_id')
          final int? id,
      @JsonKey(name: 'game')
          required final String name,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
          final bool isVisibleToPicker,
      final int? sortIndex}) = _$_Game;

  factory _Game.fromJson(Map<String, dynamic> json) = _$_Game.fromJson;

  @override
  @JsonKey(name: 'game_id')
  int? get id;
  @override
  @JsonKey(name: 'game')
  String get name;
  @override
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
  bool get isVisibleToPicker;
  @override
  int? get sortIndex;
  @override
  @JsonKey(ignore: true)
  _$$_GameCopyWith<_$_Game> get copyWith => throw _privateConstructorUsedError;
}
