import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

part 'adaptive_banner_ad_state.freezed.dart';

@freezed
abstract class AdaptiveBannerAdState with _$AdaptiveBannerAdState {
  factory AdaptiveBannerAdState({
    final BannerAd? ad,
    final AdSize? adSize,
  }) = _AdaptiveBannerAdState;
}
