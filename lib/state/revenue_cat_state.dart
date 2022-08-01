import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purchases_flutter/object_wrappers.dart';

part 'revenue_cat_state.freezed.dart';

@freezed
abstract class RevenueCatState with _$RevenueCatState {
  factory RevenueCatState({
    final CustomerInfo? customerInfo,
    final Offerings? offerings,
    final Exception? exception,
  }) = _RevenueCatState;
}
