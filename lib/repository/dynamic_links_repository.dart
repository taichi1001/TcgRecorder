import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/enum/access_roll.dart';
import 'package:tcg_manager/service/firebase_dynamic_links.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

final dynamicLinksRepository =
    Provider.autoDispose<DynamicLinksRepository>((ref) => DynamicLinksRepository(ref.watch(firebaseDynamicLinksProvider)));

class DynamicLinksRepository {
  final FirebaseDynamicLinks _dynamicLinks;
  DynamicLinksRepository(this._dynamicLinks);

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
      print(initialLink.link);
      final okCancelResult = await showOkCancelAlertDialog(
        context: context,
        message: '招待されたぜ',
        isDestructiveAction: true,
      );
    }
    FirebaseDynamicLinks.instance.onLink.listen(
      (dynamicLinkData) async {
        print(dynamicLinkData.link.query);
        if (context.mounted) {
          final okCancelResult = await showOkCancelAlertDialog(
            context: context,
            message: '招待されたぜ',
            isDestructiveAction: true,
          );
        }
      },
    );
  }
}

class DynamicLinksReceiver {}
