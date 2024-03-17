import 'dart:async';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tcg_manager/provider/user_activity_provider.dart';

part 'reward_ad_state_provider.g.dart';

@Riverpod(keepAlive: true)
class RewardAdStateNotifier extends _$RewardAdStateNotifier {
  @override
  RewardedAd? build() {
    return null;
  }

  String _getAdUnitId() {
    bool isDebug = false;
    assert(isDebug = true);

    if (isDebug) {
      if (Platform.isAndroid) {
        return "ca-app-pub-3940256099942544/5224354917"; // テスト用
      } else if (Platform.isIOS) {
        return "ca-app-pub-3940256099942544/1712485313"; // テスト用
      } else {
        throw UnsupportedError("Unsupported platform");
      }
    } else {
      if (Platform.isAndroid) {
        return 'ca-app-pub-2720030553523537/6562493550'; // 本番用
      } else if (Platform.isIOS) {
        return 'ca-app-pub-2720030553523537/1336472631'; // 本番用
      } else {
        throw UnsupportedError("Unsupported platform");
      }
    }
  }

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: _getAdUnitId(),
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          // Ad loaded
          state = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          // Ad failed to load
        },
      ),
    );
  }

  Future _showRewardedAd(Function rewardFunc) async {
    if (state == null) {
      // Warning: attempt to show a rewarded ad before loaded.
      return;
    }
    final completer = Completer();

    state!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) {}, // Ad showed
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
        state = null;
        loadRewardedAd();
        completer.complete();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        ad.dispose();
        // Ad failed to show
        completer.completeError(error);
      },
    );

    state!.setImmersiveMode(true);
    await state!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) async {
      rewardFunc();
    });
    await completer.future;
  }

  showLimitRewardAd() async {
    await _showRewardedAd(() => ref.read(userActivityLogNotifierProvider.notifier).showLimitRewardAd());
  }
}
