// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'theme_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ThemeState {
  FlexScheme get scheme => throw _privateConstructorUsedError;
  FlexScheme get previewScheme => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ThemeStateCopyWith<ThemeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeStateCopyWith<$Res> {
  factory $ThemeStateCopyWith(
          ThemeState value, $Res Function(ThemeState) then) =
      _$ThemeStateCopyWithImpl<$Res>;
  $Res call({FlexScheme scheme, FlexScheme previewScheme});
}

/// @nodoc
class _$ThemeStateCopyWithImpl<$Res> implements $ThemeStateCopyWith<$Res> {
  _$ThemeStateCopyWithImpl(this._value, this._then);

  final ThemeState _value;
  // ignore: unused_field
  final $Res Function(ThemeState) _then;

  @override
  $Res call({
    Object? scheme = freezed,
    Object? previewScheme = freezed,
  }) {
    return _then(_value.copyWith(
      scheme: scheme == freezed
          ? _value.scheme
          : scheme // ignore: cast_nullable_to_non_nullable
              as FlexScheme,
      previewScheme: previewScheme == freezed
          ? _value.previewScheme
          : previewScheme // ignore: cast_nullable_to_non_nullable
              as FlexScheme,
    ));
  }
}

/// @nodoc
abstract class _$$_ThemeStateCopyWith<$Res>
    implements $ThemeStateCopyWith<$Res> {
  factory _$$_ThemeStateCopyWith(
          _$_ThemeState value, $Res Function(_$_ThemeState) then) =
      __$$_ThemeStateCopyWithImpl<$Res>;
  @override
  $Res call({FlexScheme scheme, FlexScheme previewScheme});
}

/// @nodoc
class __$$_ThemeStateCopyWithImpl<$Res> extends _$ThemeStateCopyWithImpl<$Res>
    implements _$$_ThemeStateCopyWith<$Res> {
  __$$_ThemeStateCopyWithImpl(
      _$_ThemeState _value, $Res Function(_$_ThemeState) _then)
      : super(_value, (v) => _then(v as _$_ThemeState));

  @override
  _$_ThemeState get _value => super._value as _$_ThemeState;

  @override
  $Res call({
    Object? scheme = freezed,
    Object? previewScheme = freezed,
  }) {
    return _then(_$_ThemeState(
      scheme: scheme == freezed
          ? _value.scheme
          : scheme // ignore: cast_nullable_to_non_nullable
              as FlexScheme,
      previewScheme: previewScheme == freezed
          ? _value.previewScheme
          : previewScheme // ignore: cast_nullable_to_non_nullable
              as FlexScheme,
    ));
  }
}

/// @nodoc

class _$_ThemeState implements _ThemeState {
  _$_ThemeState(
      {this.scheme = FlexScheme.ebonyClay,
      this.previewScheme = FlexScheme.ebonyClay});

  @override
  @JsonKey()
  final FlexScheme scheme;
  @override
  @JsonKey()
  final FlexScheme previewScheme;

  @override
  String toString() {
    return 'ThemeState(scheme: $scheme, previewScheme: $previewScheme)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ThemeState &&
            const DeepCollectionEquality().equals(other.scheme, scheme) &&
            const DeepCollectionEquality()
                .equals(other.previewScheme, previewScheme));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(scheme),
      const DeepCollectionEquality().hash(previewScheme));

  @JsonKey(ignore: true)
  @override
  _$$_ThemeStateCopyWith<_$_ThemeState> get copyWith =>
      __$$_ThemeStateCopyWithImpl<_$_ThemeState>(this, _$identity);
}

abstract class _ThemeState implements ThemeState {
  factory _ThemeState(
      {final FlexScheme scheme,
      final FlexScheme previewScheme}) = _$_ThemeState;

  @override
  FlexScheme get scheme => throw _privateConstructorUsedError;
  @override
  FlexScheme get previewScheme => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ThemeStateCopyWith<_$_ThemeState> get copyWith =>
      throw _privateConstructorUsedError;
}
