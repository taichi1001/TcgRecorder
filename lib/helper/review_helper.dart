import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

class ReviewHelper {
  static final InAppReview _inAppReview = InAppReview.instance;

  // URLを定数化
  // TODO トレマネのURLに変更する
  static const String _urlAppStore =
      'https://apps.apple.com/jp/app/%E3%83%88%E3%83%AC%E3%82%AB%E7%A2%BA%E7%8E%87%E3%82%B7%E3%83%9F%E3%83%A5%E3%83%AC%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%82%A2%E3%83%97%E3%83%AA-%E3%83%88%E3%83%AC%E3%82%B7%E3%83%9F%E3%83%A5/id6475571696?ign-mpt=uo%3D4';
  static const String _urlPlayStore = 'https://play.google.com/store/apps/details?id=com.taichi1001.tcg_calc';

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
