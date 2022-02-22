import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/state/adaptive_banner_ad_state.dart';

class AdaptiveBannerAdNotifier extends StateNotifier<AdaptiveBannerAdState> {
  AdaptiveBannerAdNotifier() : super(AdaptiveBannerAdState());

  String getBannerAdUnitId() {
    bool isDebug = false;
    assert(isDebug = true);
    if (isDebug) {
      if (Platform.isAndroid) {
        return "ca-app-pub-3940256099942544/6300978111"; // テスト用
      } else if (Platform.isIOS) {
        return "ca-app-pub-3940256099942544/2934735716"; // テスト用
      } else {
        throw UnsupportedError("Unsupported platform");
      }
    } else {
      if (Platform.isAndroid) {
        return 'ca-app-pub-2720030553523537/6556965640'; // 本番用
      } else if (Platform.isIOS) {
        return 'ca-app-pub-2720030553523537/8651278967'; // 本番用
      } else {
        throw UnsupportedError("Unsupported platform");
      }
    }
  }

  Future getAd(BuildContext context) async {
    final adSize = await AdSize.getAnchoredAdaptiveBannerAdSize(
        MediaQuery.of(context).orientation == Orientation.portrait ? Orientation.portrait : Orientation.landscape,
        MediaQuery.of(context).size.width.toInt()) as AdSize;

    state = state.copyWith(adSize: adSize);
  }
}

final adaptiveBannerAdNotifierProvider = StateNotifierProvider<AdaptiveBannerAdNotifier, AdaptiveBannerAdState>(
  (ref) => AdaptiveBannerAdNotifier(),
);
