import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';
import 'package:tcg_manager/view/host_share_game_view.dart';

class SharedUserView extends HookConsumerWidget {
  const SharedUserView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentShareUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(user.id),
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
            tiles: [
              _PermissionSettingsTile(),
            ],
          ),
          SettingsSection(
            tiles: [_RevokeShareTile()],
          ),
        ],
      ),
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
    final user = ref.watch(currentShareUserProvider);
    return SettingsTile(
      title: const Text('アクセス権限'),
      value: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).hoverColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Text(user.roll.displayName),
        ),
      ),
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
    final user = ref.watch(currentShareUserProvider);
    final share = ref.watch(currentShare);
    return SettingsTile(
      onPressed: (context) async {
        final okCancel = await showOkCancelAlertDialog(
          context: context,
          title: 'データの共有を解除します',
          message: '解除されたユーザーはデータが閲覧できなくなります。よろしいですか？',
        );
        if (okCancel == OkCancelResult.ok) {
          await ref.read(firestoreShareRepository).revokeUser(user, share.docName);
          if (context.mounted) Navigator.of(context).pop();
        }
      },
      title: Center(
        child: Text(
          'データの共有を解除',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      ),
    );
  }
}
