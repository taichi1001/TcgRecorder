// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'revenue_cat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RevenueCatState {
  CustomerInfo? get customerInfo => throw _privateConstructorUsedError;
  Offerings? get offerings => throw _privateConstructorUsedError;
  Exception? get exception => throw _privateConstructorUsedError;
  bool get isPremium => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RevenueCatStateCopyWith<RevenueCatState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevenueCatStateCopyWith<$Res> {
  factory $RevenueCatStateCopyWith(
          RevenueCatState value, $Res Function(RevenueCatState) then) =
      _$RevenueCatStateCopyWithImpl<$Res, RevenueCatState>;
  @useResult
  $Res call(
      {CustomerInfo? customerInfo,
      Offerings? offerings,
      Exception? exception,
      bool isPremium,
      bool isLoading});

  $CustomerInfoCopyWith<$Res>? get customerInfo;
  $OfferingsCopyWith<$Res>? get offerings;
}

/// @nodoc
class _$RevenueCatStateCopyWithImpl<$Res, $Val extends RevenueCatState>
    implements $RevenueCatStateCopyWith<$Res> {
  _$RevenueCatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerInfo = freezed,
    Object? offerings = freezed,
    Object? exception = freezed,
    Object? isPremium = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      customerInfo: freezed == customerInfo
          ? _value.customerInfo
          : customerInfo // ignore: cast_nullable_to_non_nullable
              as CustomerInfo?,
      offerings: freezed == offerings
          ? _value.offerings
          : offerings // ignore: cast_nullable_to_non_nullable
              as Offerings?,
      exception: freezed == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as Exception?,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomerInfoCopyWith<$Res>? get customerInfo {
    if (_value.customerInfo == null) {
      return null;
    }

    return $CustomerInfoCopyWith<$Res>(_value.customerInfo!, (value) {
      return _then(_value.copyWith(customerInfo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OfferingsCopyWith<$Res>? get offerings {
    if (_value.offerings == null) {
      return null;
    }

    return $OfferingsCopyWith<$Res>(_value.offerings!, (value) {
      return _then(_value.copyWith(offerings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RevenueCatStateCopyWith<$Res>
    implements $RevenueCatStateCopyWith<$Res> {
  factory _$$_RevenueCatStateCopyWith(
          _$_RevenueCatState value, $Res Function(_$_RevenueCatState) then) =
      __$$_RevenueCatStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CustomerInfo? customerInfo,
      Offerings? offerings,
      Exception? exception,
      bool isPremium,
      bool isLoading});

  @override
  $CustomerInfoCopyWith<$Res>? get customerInfo;
  @override
  $OfferingsCopyWith<$Res>? get offerings;
}

/// @nodoc
class __$$_RevenueCatStateCopyWithImpl<$Res>
    extends _$RevenueCatStateCopyWithImpl<$Res, _$_RevenueCatState>
    implements _$$_RevenueCatStateCopyWith<$Res> {
  __$$_RevenueCatStateCopyWithImpl(
      _$_RevenueCatState _value, $Res Function(_$_RevenueCatState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerInfo = freezed,
    Object? offerings = freezed,
    Object? exception = freezed,
    Object? isPremium = null,
    Object? isLoading = null,
  }) {
    return _then(_$_RevenueCatState(
      customerInfo: freezed == customerInfo
          ? _value.customerInfo
          : customerInfo // ignore: cast_nullable_to_non_nullable
              as CustomerInfo?,
      offerings: freezed == offerings
          ? _value.offerings
          : offerings // ignore: cast_nullable_to_non_nullable
              as Offerings?,
      exception: freezed == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as Exception?,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_RevenueCatState implements _RevenueCatState {
  _$_RevenueCatState(
      {this.customerInfo,
      this.offerings,
      this.exception,
      this.isPremium = false,
      this.isLoading = false});

  @override
  final CustomerInfo? customerInfo;
  @override
  final Offerings? offerings;
  @override
  final Exception? exception;
  @override
  @JsonKey()
  final bool isPremium;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'RevenueCatState(customerInfo: $customerInfo, offerings: $offerings, exception: $exception, isPremium: $isPremium, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RevenueCatState &&
            (identical(other.customerInfo, customerInfo) ||
                other.customerInfo == customerInfo) &&
            (identical(other.offerings, offerings) ||
                other.offerings == offerings) &&
            (identical(other.exception, exception) ||
                other.exception == exception) &&
            (identical(other.isPremium, isPremium) ||
                other.isPremium == isPremium) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, customerInfo, offerings, exception, isPremium, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RevenueCatStateCopyWith<_$_RevenueCatState> get copyWith =>
      __$$_RevenueCatStateCopyWithImpl<_$_RevenueCatState>(this, _$identity);
}

abstract class _RevenueCatState implements RevenueCatState {
  factory _RevenueCatState(
      {final CustomerInfo? customerInfo,
      final Offerings? offerings,
      final Exception? exception,
      final bool isPremium,
      final bool isLoading}) = _$_RevenueCatState;

  @override
  CustomerInfo? get customerInfo;
  @override
  Offerings? get offerings;
  @override
  Exception? get exception;
  @override
  bool get isPremium;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_RevenueCatStateCopyWith<_$_RevenueCatState> get copyWith =>
      throw _privateConstructorUsedError;
}
