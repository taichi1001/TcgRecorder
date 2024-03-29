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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Game _$GameFromJson(Map<String, dynamic> json) {
  return _Game.fromJson(json);
}

/// @nodoc
mixin _$Game {
  @JsonKey(name: 'game_id')
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'game')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'public_game_id')
  int? get publicGameId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
  bool get isVisibleToPicker => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
  bool get isShare => throw _privateConstructorUsedError;
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
      {@JsonKey(name: 'game_id') int? id,
      @JsonKey(name: 'game') String name,
      @JsonKey(name: 'public_game_id') int? publicGameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
      bool isVisibleToPicker,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson) bool isShare,
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
    Object? publicGameId = freezed,
    Object? isVisibleToPicker = null,
    Object? isShare = null,
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
      publicGameId: freezed == publicGameId
          ? _value.publicGameId
          : publicGameId // ignore: cast_nullable_to_non_nullable
              as int?,
      isVisibleToPicker: null == isVisibleToPicker
          ? _value.isVisibleToPicker
          : isVisibleToPicker // ignore: cast_nullable_to_non_nullable
              as bool,
      isShare: null == isShare
          ? _value.isShare
          : isShare // ignore: cast_nullable_to_non_nullable
              as bool,
      sortIndex: freezed == sortIndex
          ? _value.sortIndex
          : sortIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameImplCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$$GameImplCopyWith(
          _$GameImpl value, $Res Function(_$GameImpl) then) =
      __$$GameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'game_id') int? id,
      @JsonKey(name: 'game') String name,
      @JsonKey(name: 'public_game_id') int? publicGameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
      bool isVisibleToPicker,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson) bool isShare,
      int? sortIndex});
}

/// @nodoc
class __$$GameImplCopyWithImpl<$Res>
    extends _$GameCopyWithImpl<$Res, _$GameImpl>
    implements _$$GameImplCopyWith<$Res> {
  __$$GameImplCopyWithImpl(_$GameImpl _value, $Res Function(_$GameImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? publicGameId = freezed,
    Object? isVisibleToPicker = null,
    Object? isShare = null,
    Object? sortIndex = freezed,
  }) {
    return _then(_$GameImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      publicGameId: freezed == publicGameId
          ? _value.publicGameId
          : publicGameId // ignore: cast_nullable_to_non_nullable
              as int?,
      isVisibleToPicker: null == isVisibleToPicker
          ? _value.isVisibleToPicker
          : isVisibleToPicker // ignore: cast_nullable_to_non_nullable
              as bool,
      isShare: null == isShare
          ? _value.isShare
          : isShare // ignore: cast_nullable_to_non_nullable
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
class _$GameImpl implements _Game {
  _$GameImpl(
      {@JsonKey(name: 'game_id') this.id,
      @JsonKey(name: 'game') required this.name,
      @JsonKey(name: 'public_game_id') this.publicGameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
      this.isVisibleToPicker = true,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
      this.isShare = false,
      this.sortIndex});

  factory _$GameImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameImplFromJson(json);

  @override
  @JsonKey(name: 'game_id')
  final int? id;
  @override
  @JsonKey(name: 'game')
  final String name;
  @override
  @JsonKey(name: 'public_game_id')
  final int? publicGameId;
  @override
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
  final bool isVisibleToPicker;
  @override
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
  final bool isShare;
  @override
  final int? sortIndex;

  @override
  String toString() {
    return 'Game(id: $id, name: $name, publicGameId: $publicGameId, isVisibleToPicker: $isVisibleToPicker, isShare: $isShare, sortIndex: $sortIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.publicGameId, publicGameId) ||
                other.publicGameId == publicGameId) &&
            (identical(other.isVisibleToPicker, isVisibleToPicker) ||
                other.isVisibleToPicker == isVisibleToPicker) &&
            (identical(other.isShare, isShare) || other.isShare == isShare) &&
            (identical(other.sortIndex, sortIndex) ||
                other.sortIndex == sortIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, publicGameId,
      isVisibleToPicker, isShare, sortIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      __$$GameImplCopyWithImpl<_$GameImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameImplToJson(
      this,
    );
  }
}

abstract class _Game implements Game {
  factory _Game(
      {@JsonKey(name: 'game_id') final int? id,
      @JsonKey(name: 'game') required final String name,
      @JsonKey(name: 'public_game_id') final int? publicGameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
      final bool isVisibleToPicker,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson) final bool isShare,
      final int? sortIndex}) = _$GameImpl;

  factory _Game.fromJson(Map<String, dynamic> json) = _$GameImpl.fromJson;

  @override
  @JsonKey(name: 'game_id')
  int? get id;
  @override
  @JsonKey(name: 'game')
  String get name;
  @override
  @JsonKey(name: 'public_game_id')
  int? get publicGameId;
  @override
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
  bool get isVisibleToPicker;
  @override
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
  bool get isShare;
  @override
  int? get sortIndex;
  @override
  @JsonKey(ignore: true)
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
