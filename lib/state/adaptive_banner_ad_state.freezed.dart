// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'adaptive_banner_ad_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
      _$AdaptiveBannerAdStateCopyWithImpl<$Res, AdaptiveBannerAdState>;
  @useResult
  $Res call({AdSize? adSize});
}

/// @nodoc
class _$AdaptiveBannerAdStateCopyWithImpl<$Res,
        $Val extends AdaptiveBannerAdState>
    implements $AdaptiveBannerAdStateCopyWith<$Res> {
  _$AdaptiveBannerAdStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adSize = freezed,
  }) {
    return _then(_value.copyWith(
      adSize: freezed == adSize
          ? _value.adSize
          : adSize // ignore: cast_nullable_to_non_nullable
              as AdSize?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AdaptiveBannerAdStateCopyWith<$Res>
    implements $AdaptiveBannerAdStateCopyWith<$Res> {
  factory _$$_AdaptiveBannerAdStateCopyWith(_$_AdaptiveBannerAdState value,
          $Res Function(_$_AdaptiveBannerAdState) then) =
      __$$_AdaptiveBannerAdStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AdSize? adSize});
}

/// @nodoc
class __$$_AdaptiveBannerAdStateCopyWithImpl<$Res>
    extends _$AdaptiveBannerAdStateCopyWithImpl<$Res, _$_AdaptiveBannerAdState>
    implements _$$_AdaptiveBannerAdStateCopyWith<$Res> {
  __$$_AdaptiveBannerAdStateCopyWithImpl(_$_AdaptiveBannerAdState _value,
      $Res Function(_$_AdaptiveBannerAdState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adSize = freezed,
  }) {
    return _then(_$_AdaptiveBannerAdState(
      adSize: freezed == adSize
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
            other is _$_AdaptiveBannerAdState &&
            (identical(other.adSize, adSize) || other.adSize == adSize));
  }

  @override
  int get hashCode => Object.hash(runtimeType, adSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AdaptiveBannerAdStateCopyWith<_$_AdaptiveBannerAdState> get copyWith =>
      __$$_AdaptiveBannerAdStateCopyWithImpl<_$_AdaptiveBannerAdState>(
          this, _$identity);
}

abstract class _AdaptiveBannerAdState implements AdaptiveBannerAdState {
  factory _AdaptiveBannerAdState({final AdSize? adSize}) =
      _$_AdaptiveBannerAdState;

  @override
  AdSize? get adSize;
  @override
  @JsonKey(ignore: true)
  _$$_AdaptiveBannerAdStateCopyWith<_$_AdaptiveBannerAdState> get copyWith =>
      throw _privateConstructorUsedError;
}
