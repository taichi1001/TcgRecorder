import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/share_user.dart';
import 'package:tcg_manager/enum/access_roll.dart';
import 'package:tcg_manager/main.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
import 'package:tcg_manager/provider/user_info_settings_provider.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';
import 'package:tcg_manager/service/firebase_dynamic_links.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:tcg_manager/view/premium_plan_purchase_view.dart';
import 'package:tcg_manager/view/user_info_settings_view.dart';

final dynamicLinksRepository =
    Provider.autoDispose<DynamicLinksRepository>((ref) => DynamicLinksRepository(ref.watch(firebaseDynamicLinksProvider), ref));

class DynamicLinksRepository {
  final FirebaseDynamicLinks _dynamicLinks;
  final Ref ref;
  DynamicLinksRepository(this._dynamicLinks, this.ref);

  Future<Uri> createInviteDynamicLink(String user, String gameName, AccessRoll roll) async {
    final link = Uri.parse('https://tcgmanager.page.link/share_data?uid=$user-$gameName&roll=${roll.displayName}');
    final parameters = DynamicLinkParameters(
      uriPrefix: 'https://tcgmanager.page.link',
      link: link,
      androidParameters: const AndroidParameters(
        packageName: 'com.taichi1001.tcg_manager',
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.taichi1001.tcg-manager',
        appStoreId: '1609073371',
      ),
    );
    final dynamicUrl = await _dynamicLinks.buildShortLink(parameters);
    return dynamicUrl.shortUrl;
  }

  Future linkRecive(BuildContext context) async {
    final initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null && context.mounted) {
      final uid = initialLink.link.queryParameters['uid'];
      final gameName = uid?.split('-');
      final roll = AccessRoll.values.byName(initialLink.link.queryParameters['roll']!);
      final result = await _showDialog(context, gameName?[0], gameName?[1]);
      if (result == OkCancelResult.ok) {
        ref
            .read(firestoreShareRepository)
            .requestDataShare(uid!, ShareUser(id: ref.read(firebaseAuthNotifierProvider).user!.uid, roll: roll));
      }
    }
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
      if (context.mounted) {
        final uid = dynamicLinkData.link.queryParameters['uid'];
        final roll = AccessRoll.values.byName(dynamicLinkData.link.queryParameters['roll']!);
        final gameName = uid?.split('-');
        final result = await _showDialog(context, gameName?[0], gameName?[1]);
        if (result == OkCancelResult.ok) {
          ref
              .read(firestoreShareRepository)
              .requestDataShare(uid!, ShareUser(id: ref.read(firebaseAuthNotifierProvider).user!.uid, roll: roll));
        }
      }
    });
  }

  Future<OkCancelResult> _showDialog(BuildContext context, String? uid, String? gameName) async {
    final userInfo = ref.read(userInfoSettingsProvider);
    final shareCount = await ref.read(guestShareCountProvider.future);
    final isPremium = ref.read(revenueCatNotifierProvider).isPremium;
    var result = false;
    if (userInfo.name == null && context.mounted) {
      final okCancel = await showOkCancelAlertDialog(
        context: context,
        title: 'プロフィールを設定してください',
        message: 'この機能の利用にはプロフィールの設定が必要です。',
        isDestructiveAction: true,
      );
      if (okCancel == OkCancelResult.ok && context.mounted) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserInfoSettingsView(),
          ),
        );
        final newUserInfo = ref.read(userInfoSettingsProvider);
        if (newUserInfo.name != null) {
          result = true;
        }
      }
      return result ? OkCancelResult.ok : OkCancelResult.cancel;
    }
    if (shareCount > 1 && context.mounted && !isPremium) {
      final result = await showOkCancelAlertDialog(
        context: context,
        title: '共有個数制限に達しました。',
        message: '参加できるゲーム数は最大2つまでです。プレミアムプランに加入することでこの制限を解除することができます。',
        okLabel: 'OK',
        cancelLabel: 'プレミアムプラン詳細',
        isDestructiveAction: true,
      );
      if (result == OkCancelResult.cancel && context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => const PremiumPlanPurchaseView(),
          ),
        );
      }
      return OkCancelResult.cancel;
    }
    if (context.mounted) {
      return await showOkCancelAlertDialog(
        context: context,
        title: 'データ共有申請',
        message: '$uidがホストの$gameNameにゲストとして参加申請しますか？',
        isDestructiveAction: true,
      );
    }
    return await showOkCancelAlertDialog(
      context: context,
      title: 'データ共有申請',
      message: '$uidがホストの$gameNameにゲストとして参加申請しますか？',
      isDestructiveAction: true,
    );
  }
}
