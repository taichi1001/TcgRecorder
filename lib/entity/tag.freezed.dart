// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Tag _$TagFromJson(Map<String, dynamic> json) {
  return _Tag.fromJson(json);
}

/// @nodoc
class _$TagTearOff {
  const _$TagTearOff();

  _Tag call(
      {@JsonKey(name: 'tag_id') int? tagId,
      required String tag,
      @JsonKey(name: 'game_id') int? gameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker') bool isVisibleToPicker = true}) {
    return _Tag(
      tagId: tagId,
      tag: tag,
      gameId: gameId,
      isVisibleToPicker: isVisibleToPicker,
    );
  }

  Tag fromJson(Map<String, Object?> json) {
    return Tag.fromJson(json);
  }
}

/// @nodoc
const $Tag = _$TagTearOff();

/// @nodoc
mixin _$Tag {
  @JsonKey(name: 'tag_id')
  int? get tagId => throw _privateConstructorUsedError;
  String get tag => throw _privateConstructorUsedError;
  @JsonKey(name: 'game_id')
  int? get gameId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker')
  bool get isVisibleToPicker => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TagCopyWith<Tag> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagCopyWith<$Res> {
  factory $TagCopyWith(Tag value, $Res Function(Tag) then) = _$TagCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'tag_id') int? tagId,
      String tag,
      @JsonKey(name: 'game_id') int? gameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker') bool isVisibleToPicker});
}

/// @nodoc
class _$TagCopyWithImpl<$Res> implements $TagCopyWith<$Res> {
  _$TagCopyWithImpl(this._value, this._then);

  final Tag _value;
  // ignore: unused_field
  final $Res Function(Tag) _then;

  @override
  $Res call({
    Object? tagId = freezed,
    Object? tag = freezed,
    Object? gameId = freezed,
    Object? isVisibleToPicker = freezed,
  }) {
    return _then(_value.copyWith(
      tagId: tagId == freezed
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as int?,
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String,
      gameId: gameId == freezed
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int?,
      isVisibleToPicker: isVisibleToPicker == freezed
          ? _value.isVisibleToPicker
          : isVisibleToPicker // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$TagCopyWith<$Res> implements $TagCopyWith<$Res> {
  factory _$TagCopyWith(_Tag value, $Res Function(_Tag) then) = __$TagCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'tag_id') int? tagId,
      String tag,
      @JsonKey(name: 'game_id') int? gameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker') bool isVisibleToPicker});
}

/// @nodoc
class __$TagCopyWithImpl<$Res> extends _$TagCopyWithImpl<$Res> implements _$TagCopyWith<$Res> {
  __$TagCopyWithImpl(_Tag _value, $Res Function(_Tag) _then) : super(_value, (v) => _then(v as _Tag));

  @override
  _Tag get _value => super._value as _Tag;

  @override
  $Res call({
    Object? tagId = freezed,
    Object? tag = freezed,
    Object? gameId = freezed,
    Object? isVisibleToPicker = freezed,
  }) {
    return _then(_Tag(
      tagId: tagId == freezed
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as int?,
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String,
      gameId: gameId == freezed
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as int?,
      isVisibleToPicker: isVisibleToPicker == freezed
          ? _value.isVisibleToPicker
          : isVisibleToPicker // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Tag implements _Tag {
  _$_Tag(
      {@JsonKey(name: 'tag_id') this.tagId,
      required this.tag,
      @JsonKey(name: 'game_id') this.gameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker') this.isVisibleToPicker = true});

  factory _$_Tag.fromJson(Map<String, dynamic> json) => _$$_TagFromJson(json);

  @override
  @JsonKey(name: 'tag_id')
  final int? tagId;
  @override
  final String tag;
  @override
  @JsonKey(name: 'game_id')
  final int? gameId;
  @override
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker')
  final bool isVisibleToPicker;

  @override
  String toString() {
    return 'Tag(tagId: $tagId, tag: $tag, gameId: $gameId, isVisibleToPicker: $isVisibleToPicker)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Tag &&
            const DeepCollectionEquality().equals(other.tagId, tagId) &&
            const DeepCollectionEquality().equals(other.tag, tag) &&
            const DeepCollectionEquality().equals(other.gameId, gameId) &&
            const DeepCollectionEquality().equals(other.isVisibleToPicker, isVisibleToPicker));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(tagId), const DeepCollectionEquality().hash(tag),
      const DeepCollectionEquality().hash(gameId), const DeepCollectionEquality().hash(isVisibleToPicker));

  @JsonKey(ignore: true)
  @override
  _$TagCopyWith<_Tag> get copyWith => __$TagCopyWithImpl<_Tag>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TagToJson(this);
  }
}

abstract class _Tag implements Tag {
  factory _Tag(
      {@JsonKey(name: 'tag_id') int? tagId,
      required String tag,
      @JsonKey(name: 'game_id') int? gameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker') bool isVisibleToPicker}) = _$_Tag;

  factory _Tag.fromJson(Map<String, dynamic> json) = _$_Tag.fromJson;

  @override
  @JsonKey(name: 'tag_id')
  int? get tagId;
  @override
  String get tag;
  @override
  @JsonKey(name: 'game_id')
  int? get gameId;
  @override
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson, name: 'is_visible_to_picker')
  bool get isVisibleToPicker;
  @override
  @JsonKey(ignore: true)
  _$TagCopyWith<_Tag> get copyWith => throw _privateConstructorUsedError;
}
