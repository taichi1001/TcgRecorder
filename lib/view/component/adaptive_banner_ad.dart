import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/adaptive_banner_ad_provider.dart';

class AdaptiveBannerAd extends HookConsumerWidget {
  const AdaptiveBannerAd({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adSize = ref.read(adaptiveBannerAdNotifierProvider).adSize;
    final ad = BannerAd(
      size: adSize!,
      adUnitId: ref.read(adaptiveBannerAdNotifierProvider.notifier).getBannerAdUnitId(),
      listener: const BannerAdListener(),
      request: const AdRequest(),
    );
    ad.load();

    return Container(
      alignment: Alignment.center,
      height: adSize.height.toDouble(),
      width: adSize.width.toDouble(),
      child: AdWidget(ad: ad),
    );
  }
}
