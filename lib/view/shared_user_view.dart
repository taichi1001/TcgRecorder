import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tcg_manager/enum/access_roll.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';
import 'package:tcg_manager/view/host_share_game_view.dart';

class SharedUserView extends HookConsumerWidget {
  const SharedUserView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentSharedUser);
    return Scaffold(
      appBar: AppBar(
        title: Text(user.currentUserData!.name ?? user.currentUserData!.id),
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
      value: GestureDetector(
        onTap: () async {
          {
            showCupertinoModalBottomSheet(
              expand: false,
              context: context,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(8),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            const Icon(Icons.folder_shared),
                            const SizedBox(width: 16),
                            Text(
                              'アクセス権限設定',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      ...AccessRoll.values
                          .map(
                            (roll) => GestureDetector(
                              onTap: () async {
                                final share = ref.read(currentSharedUser).share;
                                final isSuccess = await ref.read(firestoreShareRepository).updateUserRoll(user!, roll, share.docName);
                                if (isSuccess) ref.read(currentShareUserProvider.notifier).state = user.copyWith(roll: roll);
                                if (context.mounted) Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Opacity(
                                      opacity: user!.roll == roll ? 1 : 0,
                                      child: const Icon(Icons.check),
                                    ),
                                    const SizedBox(width: 32),
                                    Text(
                                      roll.displayName,
                                      style: user.roll == roll
                                          ? Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.primary)
                                          : Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).hoverColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Text(user!.roll.displayName),
          ),
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
    final share = ref.watch(currentSharedUser);
    return SettingsTile(
      onPressed: (context) async {
        final okCancel = await showOkCancelAlertDialog(
          context: context,
          title: 'データの共有を解除します',
          message: '解除されたユーザーはデータが閲覧できなくなります。よろしいですか？',
        );
        if (okCancel == OkCancelResult.ok) {
          await ref.read(firestoreShareRepository).revokeUser(user!, share.share.docName);
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
