import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:tcg_manager/state/revenue_cat_state.dart';

class RevenueCatNotifier extends StateNotifier<RevenueCatState> {
  RevenueCatNotifier(this.revenueCatState) : super(revenueCatState);

  final RevenueCatState revenueCatState;
  static const String iosAPIKey = 'appl_qGfPwLpLoCrmULsxbiCIsWgWDpx';
  static const String androidAPIKey = '';
  static final revenueCatAPIKey = Platform.isIOS ? iosAPIKey : androidAPIKey;

  Future init() async {
    try {
      await Purchases.setDebugLogsEnabled(kDebugMode);
      await Purchases.configure(PurchasesConfiguration(revenueCatAPIKey));
      final info = await Purchases.getCustomerInfo();
      final offerings = await Purchases.getOfferings();
      state = state.copyWith(customerInfo: info, offerings: offerings);
    } catch (e) {
      state = state.copyWith(exception: e as Exception);
    }
  }

  Future purchasePremiumMonthly() async {
    try {
      final package = state.offerings?.current?.monthly;
      if (package == null) return;
      await Purchases.purchasePackage(package);
      final purchaseseInfo = await Purchases.getCustomerInfo();
      final isPremium = purchaseseInfo.entitlements.all['premium']?.isActive;
      state = state.copyWith(isPremium: isPremium ?? false);
    } catch (e) {
      rethrow;
    }
  }
}

final revenueCatNotifierProvider = StateNotifierProvider<RevenueCatNotifier, RevenueCatState>(
  (ref) {
    final revenueCat = ref.watch(revenueCatProvider);
    return RevenueCatNotifier(revenueCat);
  },
);

final revenueCatProvider = Provider<RevenueCatState>((ref) => throw UnimplementedError);
