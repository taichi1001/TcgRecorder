import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/state/adaptive_banner_ad_state.dart';

class AdaptiveBannerAdNotifier extends StateNotifier<AdaptiveBannerAdState> {
  AdaptiveBannerAdNotifier() : super(AdaptiveBannerAdState());

  String _getBannerAdUnitId() {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/6300978111";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/2934735716";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  Future getAd(BuildContext context) async {
    if (state.adSize != null) {
      return state.adSize;
    }

    final adSize = await AdSize.getAnchoredAdaptiveBannerAdSize(
        MediaQuery.of(context).orientation == Orientation.portrait ? Orientation.portrait : Orientation.landscape,
        MediaQuery.of(context).size.width.toInt()) as AdSize;

    final ad = BannerAd(
      size: adSize,
      adUnitId: _getBannerAdUnitId(),
      listener: const BannerAdListener(),
      request: const AdRequest(),
    );

    state = state.copyWith(ad: ad, adSize: adSize);
    state.ad!.load();
  }
}

final adaptiveBannerAdNotifierProvider = StateNotifierProvider<AdaptiveBannerAdNotifier, AdaptiveBannerAdState>(
  (ref) => AdaptiveBannerAdNotifier(),
);
