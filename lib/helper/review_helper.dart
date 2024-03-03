import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

class ReviewHelper {
  static final InAppReview _inAppReview = InAppReview.instance;

  // URLを定数化
  static const String _urlAppStore =
      'https://apps.apple.com/jp/app/%E3%83%88%E3%83%AC%E3%82%AB%E6%88%A6%E7%B8%BE%E7%AE%A1%E7%90%86%E3%82%A2%E3%83%97%E3%83%AA-%E3%83%88%E3%83%AC%E3%83%9E%E3%83%8D/id1609073371';
  static const String _urlPlayStore = 'https://play.google.com/store/apps/details?id=com.taichi1001.tcg_manager';

  static void launchStoreReview(BuildContext context) async {
    // ScaffoldMessengerのBuildContextを保存
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      if (await _inAppReview.isAvailable()) {
        _inAppReview.requestReview();
      } else {
        // ストアのURLにフォールバック
        final url = Platform.isIOS ? _urlAppStore : _urlPlayStore;

        if (!await launchUrl(Uri.parse(url))) {
          throw 'Cannot launch the store URL';
        }
      }
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('ストアページを開けませんでした')),
      );
    }
  }
}
