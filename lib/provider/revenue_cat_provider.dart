import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/state/revenue_cat_state.dart';

class RevenueCatNotifier extends StateNotifier<AsyncValue<RevenueCatState>> {
  RevenueCatNotifier(this.ref) : super(const AsyncValue.loading()) {
    init();
  }

  static const String iosAPIKey = 'appl_qGfPwLpLoCrmULsxbiCIsWgWDpx';
  static const String androidAPIKey = 'goog_EntwIwTLCjSQZSHJLqDefQxbvmF';
  static final revenueCatAPIKey = Platform.isIOS ? iosAPIKey : androidAPIKey;
  Ref ref;

  Future init() async {
    try {
      final user = ref.read(firebaseAuthNotifierProvider).user;
      await Purchases.setLogLevel(LogLevel.debug);
      await Purchases.configure(PurchasesConfiguration(revenueCatAPIKey)..appUserID = user!.uid);
      final info = await Purchases.getCustomerInfo();
      final offerings = await Purchases.getOfferings();
      final newState = RevenueCatState(
        customerInfo: info,
        offerings: offerings,
        isPremium: info.entitlements.all['premium']?.isActive ?? false,
      );
      state = AsyncValue.data(newState);
    } catch (e) {
      final newState = RevenueCatState(exception: e as Exception, isPremium: false);
      state = AsyncValue.data(newState);
    }
  }

  Future purchasePremiumMonthly() async {
    state.whenData(
      (data) async {
        try {
          final package = data.offerings?.current?.monthly;
          if (package == null) return;
          state = AsyncValue.data(data.copyWith(isLoading: true));
          await Purchases.purchasePackage(package);
          final purchaseseInfo = await Purchases.getCustomerInfo();
          final isPremium = purchaseseInfo.entitlements.all['premium']?.isActive;
          state = AsyncValue.data(data.copyWith(isPremium: isPremium ?? false, isLoading: false, customerInfo: purchaseseInfo));
        } catch (e) {
          state = AsyncValue.data(data.copyWith(isLoading: false));
          rethrow;
        }
      },
    );
  }

  Future purchasePremiumYearly() async {
    state.whenData(
      (data) async {
        try {
          final package = data.offerings?.current?.annual;
          if (package == null) return;
          state = AsyncValue.data(data.copyWith(isLoading: true));
          await Purchases.purchasePackage(package);
          final purchaseseInfo = await Purchases.getCustomerInfo();
          final isPremium = purchaseseInfo.entitlements.all['premium']?.isActive;
          state = AsyncValue.data(data.copyWith(isPremium: isPremium ?? false, isLoading: false));
        } catch (e) {
          state = AsyncValue.data(data.copyWith(isLoading: false));
          rethrow;
        }
      },
    );
  }

  Future restorePremium() async {
    state.whenData(
      (data) async {
        try {
          state = AsyncValue.data(data.copyWith(isLoading: true));
          final restoredInfo = await Purchases.restorePurchases();
          final isPremium = restoredInfo.entitlements.all['premium']?.isActive;
          state = AsyncValue.data(data.copyWith(isPremium: isPremium ?? false, isLoading: false));
        } catch (e) {
          state = AsyncValue.data(data.copyWith(isLoading: false));
        }
      },
    );
  }
}

final revenueCatNotifierProvider = StateNotifierProvider<RevenueCatNotifier, AsyncValue<RevenueCatState>>((ref) => RevenueCatNotifier(ref));

final revenueCatProvider = Provider((ref) {
  return ref.watch(revenueCatNotifierProvider).asData?.value;
});
