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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
abstract class _$$AdaptiveBannerAdStateImplCopyWith<$Res>
    implements $AdaptiveBannerAdStateCopyWith<$Res> {
  factory _$$AdaptiveBannerAdStateImplCopyWith(
          _$AdaptiveBannerAdStateImpl value,
          $Res Function(_$AdaptiveBannerAdStateImpl) then) =
      __$$AdaptiveBannerAdStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AdSize? adSize});
}

/// @nodoc
class __$$AdaptiveBannerAdStateImplCopyWithImpl<$Res>
    extends _$AdaptiveBannerAdStateCopyWithImpl<$Res,
        _$AdaptiveBannerAdStateImpl>
    implements _$$AdaptiveBannerAdStateImplCopyWith<$Res> {
  __$$AdaptiveBannerAdStateImplCopyWithImpl(_$AdaptiveBannerAdStateImpl _value,
      $Res Function(_$AdaptiveBannerAdStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adSize = freezed,
  }) {
    return _then(_$AdaptiveBannerAdStateImpl(
      adSize: freezed == adSize
          ? _value.adSize
          : adSize // ignore: cast_nullable_to_non_nullable
              as AdSize?,
    ));
  }
}

/// @nodoc

class _$AdaptiveBannerAdStateImpl implements _AdaptiveBannerAdState {
  _$AdaptiveBannerAdStateImpl({this.adSize});

  @override
  final AdSize? adSize;

  @override
  String toString() {
    return 'AdaptiveBannerAdState(adSize: $adSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdaptiveBannerAdStateImpl &&
            (identical(other.adSize, adSize) || other.adSize == adSize));
  }

  @override
  int get hashCode => Object.hash(runtimeType, adSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AdaptiveBannerAdStateImplCopyWith<_$AdaptiveBannerAdStateImpl>
      get copyWith => __$$AdaptiveBannerAdStateImplCopyWithImpl<
          _$AdaptiveBannerAdStateImpl>(this, _$identity);
}

abstract class _AdaptiveBannerAdState implements AdaptiveBannerAdState {
  factory _AdaptiveBannerAdState({final AdSize? adSize}) =
      _$AdaptiveBannerAdStateImpl;

  @override
  AdSize? get adSize;
  @override
  @JsonKey(ignore: true)
  _$$AdaptiveBannerAdStateImplCopyWith<_$AdaptiveBannerAdStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
