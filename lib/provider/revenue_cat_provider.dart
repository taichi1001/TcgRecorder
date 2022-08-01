import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:tcg_manager/state/revenue_cat_state.dart';

class RevenueCatNotifier extends StateNotifier<RevenueCatState> {
  RevenueCatNotifier() : super(RevenueCatState());

  static const String iosAPIKey = '';
  static const String androidAPIKey = '';

  Future init() async {
    final revenueCatAPIKey = Platform.isIOS ? iosAPIKey : androidAPIKey;

    try {
      await Purchases.setDebugLogsEnabled(kDebugMode);
      await Purchases.configure(PurchasesConfiguration(revenueCatAPIKey));
      final info = await Purchases.getCustomerInfo();
      final offerings = await Purchases.getOfferings();
      state = state.copyWith(customerInfo: info, offerings: offerings);
    } catch (e) {
      print(e);
    }
  }

  // Future purchase(Package package) async {
  //   try {
  //     final pu
  //   } catch (e) {}
  // }
}

final revenueCatNotifierProvider = StateNotifierProvider<RevenueCatNotifier, RevenueCatState>(
  (ref) => RevenueCatNotifier(),
);

final revenueCatProvider = Provider<RevenueCatState>((ref) => throw UnimplementedError);
