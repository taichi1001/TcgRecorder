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
    final adaptiveBannerAdNotifier = ref.read(adaptiveBannerAdNotifierProvider.notifier);
    final adSize = ref.read(adaptiveBannerAdNotifierProvider).adSize;
    final ad = ref.watch(adaptiveBannerAdNotifierProvider.select((value) => value.ad));

    useEffect(() {
      Future.microtask(() => adaptiveBannerAdNotifier.getAd(context));
      return;
    }, const []);

    return Container(
      alignment: Alignment.center,
      height: adSize != null ? adSize.height.toDouble() : 0,
      width: adSize != null ? adSize.width.toDouble() : 0,
      child: ad == null ? Container() : AdWidget(ad: ad),
    );
  }
}
