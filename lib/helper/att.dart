import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

// Singleton
class ATT {
  static final ATT instance = ATT._();

  ATT._();

  Future<bool> requestPermission() async {
    var result = false;

    // 2021.10.02
    // AppTrackingTransparency内でAndroidの判定が入っていることがわかったのでコメントアウト
    //if (Platform.isIOS) {
    TrackingStatus trackingStatus = await AppTrackingTransparency.trackingAuthorizationStatus;
    debugPrint("trackingStatus:$trackingStatus");

    try {
      if (trackingStatus == TrackingStatus.notDetermined) {
        var status = await AppTrackingTransparency.requestTrackingAuthorization();
        debugPrint("requestTrackingAuthorization:$status");

        if (status == TrackingStatus.authorized) {
          result = true;
        }
      } else if (trackingStatus == TrackingStatus.authorized) {
        result = true;
      } else if (trackingStatus == TrackingStatus.notSupported) {
        result = true;
      }
    } on PlatformException {
      debugPrint('PlatformException was thrown');
    }
    //} else {
    //  result = true;
    //}

    final idfa = await AppTrackingTransparency.getAdvertisingIdentifier();
    debugPrint('[AppTrackingTransparency]IDFA:$idfa');
    debugPrint('[AppTrackingTransparency]result:$result');

    return result;
  }
}
