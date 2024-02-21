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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Tag _$TagFromJson(Map<String, dynamic> json) {
  return _Tag.fromJson(json);
}

/// @nodoc
mixin _$Tag {
  @JsonKey(name: 'tag_id')
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'tag')
  String get name => throw _privateConstructorUsedError;
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
      {@JsonKey(name: 'tag_id') int? id,
      @JsonKey(name: 'tag') String name,
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
    Object? id = freezed,
    Object? name = null,
    Object? gameId = freezed,
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
abstract class _$$TagImplCopyWith<$Res> implements $TagCopyWith<$Res> {
  factory _$$TagImplCopyWith(_$TagImpl value, $Res Function(_$TagImpl) then) =
      __$$TagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'tag_id') int? id,
      @JsonKey(name: 'tag') String name,
      int? gameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
      bool isVisibleToPicker,
      int? sortIndex});
}

/// @nodoc
class __$$TagImplCopyWithImpl<$Res> extends _$TagCopyWithImpl<$Res, _$TagImpl>
    implements _$$TagImplCopyWith<$Res> {
  __$$TagImplCopyWithImpl(_$TagImpl _value, $Res Function(_$TagImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? gameId = freezed,
    Object? isVisibleToPicker = null,
    Object? sortIndex = freezed,
  }) {
    return _then(_$TagImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
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
class _$TagImpl implements _Tag {
  _$TagImpl(
      {@JsonKey(name: 'tag_id') this.id,
      @JsonKey(name: 'tag') required this.name,
      this.gameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
      this.isVisibleToPicker = true,
      this.sortIndex});

  factory _$TagImpl.fromJson(Map<String, dynamic> json) =>
      _$$TagImplFromJson(json);

  @override
  @JsonKey(name: 'tag_id')
  final int? id;
  @override
  @JsonKey(name: 'tag')
  final String name;
  @override
  final int? gameId;
  @override
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
  final bool isVisibleToPicker;
  @override
  final int? sortIndex;

  @override
  String toString() {
    return 'Tag(id: $id, name: $name, gameId: $gameId, isVisibleToPicker: $isVisibleToPicker, sortIndex: $sortIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.isVisibleToPicker, isVisibleToPicker) ||
                other.isVisibleToPicker == isVisibleToPicker) &&
            (identical(other.sortIndex, sortIndex) ||
                other.sortIndex == sortIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, gameId, isVisibleToPicker, sortIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TagImplCopyWith<_$TagImpl> get copyWith =>
      __$$TagImplCopyWithImpl<_$TagImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TagImplToJson(
      this,
    );
  }
}

abstract class _Tag implements Tag {
  factory _Tag(
      {@JsonKey(name: 'tag_id') final int? id,
      @JsonKey(name: 'tag') required final String name,
      final int? gameId,
      @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
      final bool isVisibleToPicker,
      final int? sortIndex}) = _$TagImpl;

  factory _Tag.fromJson(Map<String, dynamic> json) = _$TagImpl.fromJson;

  @override
  @JsonKey(name: 'tag_id')
  int? get id;
  @override
  @JsonKey(name: 'tag')
  String get name;
  @override
  int? get gameId;
  @override
  @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson)
  bool get isVisibleToPicker;
  @override
  int? get sortIndex;
  @override
  @JsonKey(ignore: true)
  _$$TagImplCopyWith<_$TagImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
