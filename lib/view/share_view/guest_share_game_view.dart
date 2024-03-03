import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';
import 'package:tcg_manager/view/share_view/share_view.dart';

class GuestShareGameView extends HookConsumerWidget {
  const GuestShareGameView({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameName = ref.watch(currentShareProvider.select((value) => value.game.name));
    return Scaffold(
      appBar: AppBar(
        title: Text(gameName),
      ),
      body: SettingsList(
        lightTheme: SettingsThemeData(
          settingsSectionBackground: Theme.of(context).canvasColor,
          settingsListBackground: Theme.of(context).scaffoldBackgroundColor,
        ),
        darkTheme: SettingsThemeData(
          settingsSectionBackground: Theme.of(context).canvasColor,
          settingsListBackground: Theme.of(context).scaffoldBackgroundColor,
        ),
        sections: const [
          SettingsSection(
            title: Text('共有状態'),
            tiles: [
              _ShareStatusTile(),
              _PermissionSettingsTile(),
            ],
          ),
          SettingsSection(
            tiles: [
              _RevokeShareTile(),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShareStatusTile extends AbstractSettingsTile {
  const _ShareStatusTile();
  @override
  Widget build(BuildContext context) {
    return const _ShareStatusTileHooksConsumerWidget();
  }
}

class _ShareStatusTileHooksConsumerWidget extends HookConsumerWidget {
  const _ShareStatusTileHooksConsumerWidget();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final share = ref.watch(currentShareProvider);
    final myself = ref.watch(firebaseAuthNotifierProvider.select((value) => value.user));

    final isShared = share.shareUserList.where((shareUser) => shareUser.id == myself?.uid).isNotEmpty;
    final isPending = share.pendingUserList.where((shareUser) => shareUser.id == myself?.uid).isNotEmpty;

    Widget shareStatusText() {
      if (isShared) return const Text('共有中');
      if (isPending) return const Text('共有許可待ち');
      return const Text('未共有');
    }

    return SettingsTile(
      title: const Text('共有状況'),
      value: shareStatusText(),
    );
  }
}

class _PermissionSettingsTile extends AbstractSettingsTile {
  const _PermissionSettingsTile();
  @override
  Widget build(BuildContext context) {
    return const _PermissionSettingsTileHooksConsumerWidget();
  }
}

class _PermissionSettingsTileHooksConsumerWidget extends HookConsumerWidget {
  const _PermissionSettingsTileHooksConsumerWidget();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final share = ref.watch(currentShareProvider);
    final myself = ref.watch(firebaseAuthNotifierProvider.select((value) => value.user));

    final isShared = share.shareUserList.where((shareUser) => shareUser.id == myself?.uid).isNotEmpty;

    Widget permissionText() {
      if (isShared) {
        final shareUser = share.shareUserList.where((element) => element.id == myself?.uid).first;
        return Text(shareUser.roll.displayName);
      }
      return const Text('-');
    }

    return SettingsTile(
      title: const Text('アクセス権限'),
      value: permissionText(),
    );
  }
}

class _RevokeShareTile extends AbstractSettingsTile {
  const _RevokeShareTile();
  @override
  Widget build(BuildContext context) {
    return const _RevokeShareTileHooksConsumerWidget();
  }
}

class _RevokeShareTileHooksConsumerWidget extends HookConsumerWidget {
  const _RevokeShareTileHooksConsumerWidget();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myself = ref.watch(firebaseAuthNotifierProvider.select((value) => value.user));
    final share = ref.watch(currentShareProvider);

    final isShared = share.shareUserList.where((shareUser) => shareUser.id == myself?.uid).isNotEmpty;
    final isPending = share.pendingUserList.where((shareUser) => shareUser.id == myself?.uid).isNotEmpty;

    Future revoke(BuildContext context) async {
      if (isShared) {
        final okCancel = await showOkCancelAlertDialog(
          context: context,
          title: 'データの共有を解除します',
          message: 'このゲームのデータは閲覧できなくなります。よろしいですか？',
        );
        if (okCancel == OkCancelResult.ok) {
          final shareUser = share.shareUserList.where((element) => element.id == myself?.uid).first;
          await ref.read(firestoreShareRepository).revokeUser(shareUser, share.docName);
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        }
      } else if (isPending) {
        final okCancel = await showOkCancelAlertDialog(
          context: context,
          title: '共有申請をキャンセルする',
          message: 'データ共有申請をキャンセルします。よろしいですか？',
        );
        if (okCancel == OkCancelResult.ok) {
          final shareUser = share.pendingUserList.where((element) => element.id == myself?.uid).first;
          await ref.read(firestoreShareRepository).noallowSharing(shareUser, share.docName);
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        }
      }
    }

    Widget buttonText() {
      if (isShared) {
        return Text(
          'データ共有を解除',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        );
      }
      if (isPending) {
        return Text(
          'データ共有申請をキャンセル',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        );
      }
      return const Text('共有されていません');
    }

    return SettingsTile(
      onPressed: revoke,
      title: Center(
        child: buttonText(),
      ),
    );
  }
}
