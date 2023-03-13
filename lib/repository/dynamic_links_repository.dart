import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/share_user.dart';
import 'package:tcg_manager/enum/access_roll.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';
import 'package:tcg_manager/service/firebase_dynamic_links.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

final dynamicLinksRepository =
    Provider.autoDispose<DynamicLinksRepository>((ref) => DynamicLinksRepository(ref.watch(firebaseDynamicLinksProvider), ref));

class DynamicLinksRepository {
  final FirebaseDynamicLinks _dynamicLinks;
  final Ref ref;
  DynamicLinksRepository(this._dynamicLinks, this.ref);

  Future<Uri?> createInviteDynamicLink(String user, String gameName, AccessRoll roll) async {
    final link = Uri.parse('https://tcgmanager.page.link/share_data?uid=$user-$gameName&roll=${roll.displayName}');
    final parameters = DynamicLinkParameters(
      uriPrefix: 'https://tcgmanager.page.link',
      link: link,
      androidParameters: const AndroidParameters(
        packageName: 'com.taichi1001.tcg_manager',
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.taichi1001.tcg-manager',
      ),
    );
    final dynamicUrl = await _dynamicLinks.buildShortLink(parameters);
    return dynamicUrl.shortUrl;
  }

  Future linkRecive(BuildContext context) async {
    final initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null && context.mounted) {
      final result = await _showDialog(context);
      if (result == OkCancelResult.ok) {
        _parseReciveQuery(initialLink.link.queryParameters);
        final uid = initialLink.link.queryParameters['uid'];
        final roll = AccessRoll.values.byName(initialLink.link.queryParameters['roll']!);
        ref
            .read(firestoreShareRepository)
            .requestDataShare(uid!, ShareUser(id: ref.read(firebaseAuthNotifierProvider).user!.uid, roll: roll));
      }
    }
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
      if (context.mounted) {
        final result = await _showDialog(context);
        if (result == OkCancelResult.ok) {
          final uid = dynamicLinkData.link.queryParameters['uid'];
          final roll = AccessRoll.values.byName(dynamicLinkData.link.queryParameters['roll']!);
          ref
              .read(firestoreShareRepository)
              .requestDataShare(uid!, ShareUser(id: ref.read(firebaseAuthNotifierProvider).user!.uid, roll: roll));
        }
        _parseReciveQuery(dynamicLinkData.link.queryParameters);
      }
    });
  }

  Future<OkCancelResult> _showDialog(BuildContext context) async {
    return await showOkCancelAlertDialog(
      context: context,
      message: '招待されたぜ',
      isDestructiveAction: true,
    );
  }

  void _parseReciveQuery(Map<String, String> query) {
    final uid = query['uid'];
    final roll = query['roll'];
  }
}
