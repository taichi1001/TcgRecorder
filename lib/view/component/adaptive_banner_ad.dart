import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';

class AdaptiveBannerAd extends HookConsumerWidget {
  const AdaptiveBannerAd({super.key});

  final iosDevAdUnitId = 'ca-app-pub-3940256099942544/2934735716';
  final iosAdUnitId = 'ca-app-pub-2720030553523537/8651278967';
  final androidDevAdUnitId = 'ca-app-pub-3940256099942544/6300978111';
  final androidAdUnitId = 'ca-app-pub-2720030553523537/6556965640';

  String _getAdUnitId() {
    bool isDebug = false;
    assert(isDebug = true);
    if (isDebug) {
      if (Platform.isIOS) {
        return iosDevAdUnitId;
      } else if (Platform.isAndroid) {
        return iosDevAdUnitId;
      } else {
        throw UnsupportedError("Unsupported platform");
      }
    } else {
      if (Platform.isIOS) {
        return iosAdUnitId;
      } else if (Platform.isAndroid) {
        return androidAdUnitId;
      } else {
        throw UnsupportedError("Unsupported platform");
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final anchoredAdaptiveAd = useState<BannerAd?>(null);
    final isLoaded = useState(false);
    final isPremium = ref.watch(revenueCatProvider.select((value) => value?.isPremium)) ?? false;

    useEffect(() {
      Future<void> loadAd() async {
        final AnchoredAdaptiveBannerAdSize? size =
            await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(MediaQuery.of(context).size.width.truncate());

        if (size == null) {
          return;
        }
        final ad = BannerAd(
          adUnitId: _getAdUnitId(),
          size: size,
          request: const AdRequest(),
          listener: BannerAdListener(
            onAdLoaded: (Ad ad) {
              anchoredAdaptiveAd.value = ad as BannerAd;
              isLoaded.value = true;
            },
            onAdFailedToLoad: (Ad ad, LoadAdError error) {
              ad.dispose();
            },
          ),
        );
        ad.load();
      }

      Future.microtask(() => loadAd());

      return () {
        anchoredAdaptiveAd.value?.dispose();
      };
    }, const []);

    return anchoredAdaptiveAd.value != null && isLoaded.value && !isPremium
        ? Container(
            color: Colors.green,
            width: anchoredAdaptiveAd.value!.size.width.toDouble(),
            height: anchoredAdaptiveAd.value!.size.height.toDouble(),
            child: AdWidget(ad: anchoredAdaptiveAd.value!),
          )
        : const SizedBox.shrink();
  }
}
