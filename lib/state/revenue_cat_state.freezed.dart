// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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

  @JsonKey(ignore: true)
  $RevenueCatStateCopyWith<RevenueCatState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevenueCatStateCopyWith<$Res> {
  factory $RevenueCatStateCopyWith(
          RevenueCatState value, $Res Function(RevenueCatState) then) =
      _$RevenueCatStateCopyWithImpl<$Res>;
  $Res call(
      {CustomerInfo? customerInfo, Offerings? offerings, Exception? exception});

  $CustomerInfoCopyWith<$Res>? get customerInfo;
  $OfferingsCopyWith<$Res>? get offerings;
}

/// @nodoc
class _$RevenueCatStateCopyWithImpl<$Res>
    implements $RevenueCatStateCopyWith<$Res> {
  _$RevenueCatStateCopyWithImpl(this._value, this._then);

  final RevenueCatState _value;
  // ignore: unused_field
  final $Res Function(RevenueCatState) _then;

  @override
  $Res call({
    Object? customerInfo = freezed,
    Object? offerings = freezed,
    Object? exception = freezed,
  }) {
    return _then(_value.copyWith(
      customerInfo: customerInfo == freezed
          ? _value.customerInfo
          : customerInfo // ignore: cast_nullable_to_non_nullable
              as CustomerInfo?,
      offerings: offerings == freezed
          ? _value.offerings
          : offerings // ignore: cast_nullable_to_non_nullable
              as Offerings?,
      exception: exception == freezed
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ));
  }

  @override
  $CustomerInfoCopyWith<$Res>? get customerInfo {
    if (_value.customerInfo == null) {
      return null;
    }

    return $CustomerInfoCopyWith<$Res>(_value.customerInfo!, (value) {
      return _then(_value.copyWith(customerInfo: value));
    });
  }

  @override
  $OfferingsCopyWith<$Res>? get offerings {
    if (_value.offerings == null) {
      return null;
    }

    return $OfferingsCopyWith<$Res>(_value.offerings!, (value) {
      return _then(_value.copyWith(offerings: value));
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
  $Res call(
      {CustomerInfo? customerInfo, Offerings? offerings, Exception? exception});

  @override
  $CustomerInfoCopyWith<$Res>? get customerInfo;
  @override
  $OfferingsCopyWith<$Res>? get offerings;
}

/// @nodoc
class __$$_RevenueCatStateCopyWithImpl<$Res>
    extends _$RevenueCatStateCopyWithImpl<$Res>
    implements _$$_RevenueCatStateCopyWith<$Res> {
  __$$_RevenueCatStateCopyWithImpl(
      _$_RevenueCatState _value, $Res Function(_$_RevenueCatState) _then)
      : super(_value, (v) => _then(v as _$_RevenueCatState));

  @override
  _$_RevenueCatState get _value => super._value as _$_RevenueCatState;

  @override
  $Res call({
    Object? customerInfo = freezed,
    Object? offerings = freezed,
    Object? exception = freezed,
  }) {
    return _then(_$_RevenueCatState(
      customerInfo: customerInfo == freezed
          ? _value.customerInfo
          : customerInfo // ignore: cast_nullable_to_non_nullable
              as CustomerInfo?,
      offerings: offerings == freezed
          ? _value.offerings
          : offerings // ignore: cast_nullable_to_non_nullable
              as Offerings?,
      exception: exception == freezed
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as Exception?,
    ));
  }
}

/// @nodoc

class _$_RevenueCatState implements _RevenueCatState {
  _$_RevenueCatState({this.customerInfo, this.offerings, this.exception});

  @override
  final CustomerInfo? customerInfo;
  @override
  final Offerings? offerings;
  @override
  final Exception? exception;

  @override
  String toString() {
    return 'RevenueCatState(customerInfo: $customerInfo, offerings: $offerings, exception: $exception)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RevenueCatState &&
            const DeepCollectionEquality()
                .equals(other.customerInfo, customerInfo) &&
            const DeepCollectionEquality().equals(other.offerings, offerings) &&
            const DeepCollectionEquality().equals(other.exception, exception));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(customerInfo),
      const DeepCollectionEquality().hash(offerings),
      const DeepCollectionEquality().hash(exception));

  @JsonKey(ignore: true)
  @override
  _$$_RevenueCatStateCopyWith<_$_RevenueCatState> get copyWith =>
      __$$_RevenueCatStateCopyWithImpl<_$_RevenueCatState>(this, _$identity);
}

abstract class _RevenueCatState implements RevenueCatState {
  factory _RevenueCatState(
      {final CustomerInfo? customerInfo,
      final Offerings? offerings,
      final Exception? exception}) = _$_RevenueCatState;

  @override
  CustomerInfo? get customerInfo => throw _privateConstructorUsedError;
  @override
  Offerings? get offerings => throw _privateConstructorUsedError;
  @override
  Exception? get exception => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RevenueCatStateCopyWith<_$_RevenueCatState> get copyWith =>
      throw _privateConstructorUsedError;
}
