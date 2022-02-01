// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'adaptive_banner_ad_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AdaptiveBannerAdStateTearOff {
  const _$AdaptiveBannerAdStateTearOff();

  _AdaptiveBannerAdState call({AdSize? adSize}) {
    return _AdaptiveBannerAdState(
      adSize: adSize,
    );
  }
}

/// @nodoc
const $AdaptiveBannerAdState = _$AdaptiveBannerAdStateTearOff();

/// @nodoc
mixin _$AdaptiveBannerAdState {
  AdSize? get adSize => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AdaptiveBannerAdStateCopyWith<AdaptiveBannerAdState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdaptiveBannerAdStateCopyWith<$Res> {
  factory $AdaptiveBannerAdStateCopyWith(AdaptiveBannerAdState value,
          $Res Function(AdaptiveBannerAdState) then) =
      _$AdaptiveBannerAdStateCopyWithImpl<$Res>;
  $Res call({AdSize? adSize});
}

/// @nodoc
class _$AdaptiveBannerAdStateCopyWithImpl<$Res>
    implements $AdaptiveBannerAdStateCopyWith<$Res> {
  _$AdaptiveBannerAdStateCopyWithImpl(this._value, this._then);

  final AdaptiveBannerAdState _value;
  // ignore: unused_field
  final $Res Function(AdaptiveBannerAdState) _then;

  @override
  $Res call({
    Object? adSize = freezed,
  }) {
    return _then(_value.copyWith(
      adSize: adSize == freezed
          ? _value.adSize
          : adSize // ignore: cast_nullable_to_non_nullable
              as AdSize?,
    ));
  }
}

/// @nodoc
abstract class _$AdaptiveBannerAdStateCopyWith<$Res>
    implements $AdaptiveBannerAdStateCopyWith<$Res> {
  factory _$AdaptiveBannerAdStateCopyWith(_AdaptiveBannerAdState value,
          $Res Function(_AdaptiveBannerAdState) then) =
      __$AdaptiveBannerAdStateCopyWithImpl<$Res>;
  @override
  $Res call({AdSize? adSize});
}

/// @nodoc
class __$AdaptiveBannerAdStateCopyWithImpl<$Res>
    extends _$AdaptiveBannerAdStateCopyWithImpl<$Res>
    implements _$AdaptiveBannerAdStateCopyWith<$Res> {
  __$AdaptiveBannerAdStateCopyWithImpl(_AdaptiveBannerAdState _value,
      $Res Function(_AdaptiveBannerAdState) _then)
      : super(_value, (v) => _then(v as _AdaptiveBannerAdState));

  @override
  _AdaptiveBannerAdState get _value => super._value as _AdaptiveBannerAdState;

  @override
  $Res call({
    Object? adSize = freezed,
  }) {
    return _then(_AdaptiveBannerAdState(
      adSize: adSize == freezed
          ? _value.adSize
          : adSize // ignore: cast_nullable_to_non_nullable
              as AdSize?,
    ));
  }
}

/// @nodoc

class _$_AdaptiveBannerAdState implements _AdaptiveBannerAdState {
  _$_AdaptiveBannerAdState({this.adSize});

  @override
  final AdSize? adSize;

  @override
  String toString() {
    return 'AdaptiveBannerAdState(adSize: $adSize)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AdaptiveBannerAdState &&
            const DeepCollectionEquality().equals(other.adSize, adSize));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(adSize));

  @JsonKey(ignore: true)
  @override
  _$AdaptiveBannerAdStateCopyWith<_AdaptiveBannerAdState> get copyWith =>
      __$AdaptiveBannerAdStateCopyWithImpl<_AdaptiveBannerAdState>(
          this, _$identity);
}

abstract class _AdaptiveBannerAdState implements AdaptiveBannerAdState {
  factory _AdaptiveBannerAdState({AdSize? adSize}) = _$_AdaptiveBannerAdState;

  @override
  AdSize? get adSize;
  @override
  @JsonKey(ignore: true)
  _$AdaptiveBannerAdStateCopyWith<_AdaptiveBannerAdState> get copyWith =>
      throw _privateConstructorUsedError;
}
