// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Tag _$TagFromJson(Map<String, dynamic> json) {
  return _Tag.fromJson(json);
}

/// @nodoc
mixin _$Tag {
  int? get tagId => throw _privateConstructorUsedError;
  String get tag => throw _privateConstructorUsedError;
  int? get gameId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
  bool get isVisibleToPicker => throw _privateConstructorUsedError;
  int? get sortIndex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TagCopyWith<Tag> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagCopyWith<$Res> {
  factory $TagCopyWith(Tag value, $Res Function(Tag) then) =
      _$TagCopyWithImpl<$Res, Tag>;
  @useResult
  $Res call(
      {int? tagId,
      String tag,
      int? gameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
          bool isVisibleToPicker,
      int? sortIndex});
}

/// @nodoc
class _$TagCopyWithImpl<$Res, $Val extends Tag> implements $TagCopyWith<$Res> {
  _$TagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tagId = freezed,
    Object? tag = null,
    Object? gameId = freezed,
    Object? isVisibleToPicker = null,
    Object? sortIndex = freezed,
  }) {
    return _then(_value.copyWith(
      tagId: freezed == tagId
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as int?,
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
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
abstract class _$$_TagCopyWith<$Res> implements $TagCopyWith<$Res> {
  factory _$$_TagCopyWith(_$_Tag value, $Res Function(_$_Tag) then) =
      __$$_TagCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? tagId,
      String tag,
      int? gameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
          bool isVisibleToPicker,
      int? sortIndex});
}

/// @nodoc
class __$$_TagCopyWithImpl<$Res> extends _$TagCopyWithImpl<$Res, _$_Tag>
    implements _$$_TagCopyWith<$Res> {
  __$$_TagCopyWithImpl(_$_Tag _value, $Res Function(_$_Tag) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tagId = freezed,
    Object? tag = null,
    Object? gameId = freezed,
    Object? isVisibleToPicker = null,
    Object? sortIndex = freezed,
  }) {
    return _then(_$_Tag(
      tagId: freezed == tagId
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as int?,
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
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
class _$_Tag implements _Tag {
  _$_Tag(
      {this.tagId,
      required this.tag,
      this.gameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
          this.isVisibleToPicker = true,
      this.sortIndex});

  factory _$_Tag.fromJson(Map<String, dynamic> json) => _$$_TagFromJson(json);

  @override
  final int? tagId;
  @override
  final String tag;
  @override
  final int? gameId;
  @override
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
  final bool isVisibleToPicker;
  @override
  final int? sortIndex;

  @override
  String toString() {
    return 'Tag(tagId: $tagId, tag: $tag, gameId: $gameId, isVisibleToPicker: $isVisibleToPicker, sortIndex: $sortIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Tag &&
            (identical(other.tagId, tagId) || other.tagId == tagId) &&
            (identical(other.tag, tag) || other.tag == tag) &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.isVisibleToPicker, isVisibleToPicker) ||
                other.isVisibleToPicker == isVisibleToPicker) &&
            (identical(other.sortIndex, sortIndex) ||
                other.sortIndex == sortIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, tagId, tag, gameId, isVisibleToPicker, sortIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TagCopyWith<_$_Tag> get copyWith =>
      __$$_TagCopyWithImpl<_$_Tag>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TagToJson(
      this,
    );
  }
}

abstract class _Tag implements Tag {
  factory _Tag(
      {final int? tagId,
      required final String tag,
      final int? gameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
          final bool isVisibleToPicker,
      final int? sortIndex}) = _$_Tag;

  factory _Tag.fromJson(Map<String, dynamic> json) = _$_Tag.fromJson;

  @override
  int? get tagId;
  @override
  String get tag;
  @override
  int? get gameId;
  @override
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
  bool get isVisibleToPicker;
  @override
  int? get sortIndex;
  @override
  @JsonKey(ignore: true)
  _$$_TagCopyWith<_$_Tag> get copyWith => throw _privateConstructorUsedError;
}
