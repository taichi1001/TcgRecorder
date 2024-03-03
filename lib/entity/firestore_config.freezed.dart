// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firestore_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FirestoreConfig _$FirestoreConfigFromJson(Map<String, dynamic> json) {
  return _FirestoreConfig.fromJson(json);
}

/// @nodoc
mixin _$FirestoreConfig {
  String get android => throw _privateConstructorUsedError;
  String get ios => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirestoreConfigCopyWith<FirestoreConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirestoreConfigCopyWith<$Res> {
  factory $FirestoreConfigCopyWith(
          FirestoreConfig value, $Res Function(FirestoreConfig) then) =
      _$FirestoreConfigCopyWithImpl<$Res, FirestoreConfig>;
  @useResult
  $Res call({String android, String ios});
}

/// @nodoc
class _$FirestoreConfigCopyWithImpl<$Res, $Val extends FirestoreConfig>
    implements $FirestoreConfigCopyWith<$Res> {
  _$FirestoreConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? android = null,
    Object? ios = null,
  }) {
    return _then(_value.copyWith(
      android: null == android
          ? _value.android
          : android // ignore: cast_nullable_to_non_nullable
              as String,
      ios: null == ios
          ? _value.ios
          : ios // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FirestoreConfigImplCopyWith<$Res>
    implements $FirestoreConfigCopyWith<$Res> {
  factory _$$FirestoreConfigImplCopyWith(_$FirestoreConfigImpl value,
          $Res Function(_$FirestoreConfigImpl) then) =
      __$$FirestoreConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String android, String ios});
}

/// @nodoc
class __$$FirestoreConfigImplCopyWithImpl<$Res>
    extends _$FirestoreConfigCopyWithImpl<$Res, _$FirestoreConfigImpl>
    implements _$$FirestoreConfigImplCopyWith<$Res> {
  __$$FirestoreConfigImplCopyWithImpl(
      _$FirestoreConfigImpl _value, $Res Function(_$FirestoreConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? android = null,
    Object? ios = null,
  }) {
    return _then(_$FirestoreConfigImpl(
      android: null == android
          ? _value.android
          : android // ignore: cast_nullable_to_non_nullable
              as String,
      ios: null == ios
          ? _value.ios
          : ios // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FirestoreConfigImpl implements _FirestoreConfig {
  _$FirestoreConfigImpl({required this.android, required this.ios});

  factory _$FirestoreConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$FirestoreConfigImplFromJson(json);

  @override
  final String android;
  @override
  final String ios;

  @override
  String toString() {
    return 'FirestoreConfig(android: $android, ios: $ios)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FirestoreConfigImpl &&
            (identical(other.android, android) || other.android == android) &&
            (identical(other.ios, ios) || other.ios == ios));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, android, ios);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FirestoreConfigImplCopyWith<_$FirestoreConfigImpl> get copyWith =>
      __$$FirestoreConfigImplCopyWithImpl<_$FirestoreConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FirestoreConfigImplToJson(
      this,
    );
  }
}

abstract class _FirestoreConfig implements FirestoreConfig {
  factory _FirestoreConfig(
      {required final String android,
      required final String ios}) = _$FirestoreConfigImpl;

  factory _FirestoreConfig.fromJson(Map<String, dynamic> json) =
      _$FirestoreConfigImpl.fromJson;

  @override
  String get android;
  @override
  String get ios;
  @override
  @JsonKey(ignore: true)
  _$$FirestoreConfigImplCopyWith<_$FirestoreConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
