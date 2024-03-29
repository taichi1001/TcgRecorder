import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tcg_manager/entity/firestore_share.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/share_user.dart';
import 'package:tcg_manager/entity/user_data.dart';
import 'package:tcg_manager/enum/access_roll.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';

final currentSharedUserViewDataProvider = StateProvider<(UserData, ShareUser, FirestoreShare)>(
  (ref) => (
    UserData(id: ''),
    ShareUser(id: '', roll: AccessRoll.reader),
    FirestoreShare(game: Game(name: ''), authorName: '', docName: ''),
  ),
);

class SharedUserView extends HookConsumerWidget {
  const SharedUserView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentSharedUserViewDataProvider).$1;

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name ?? user.id),
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
    final user = useState(ref.watch(currentSharedUserViewDataProvider).$2);
    final share = ref.watch(currentSharedUserViewDataProvider).$3;
    return SettingsTile(
      title: const Text('アクセス権限'),
      value: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).hoverColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Text(user.value.roll.displayName),
        ),
      ),
      onPressed: (context) async {
        final delAuthorAccessRollList = List.of(AccessRoll.values)..remove(AccessRoll.author);
        if (user.value.roll == AccessRoll.author) {
          await showOkAlertDialog(
            context: context,
            title: '許可されていない操作です',
            message: 'ゲーム作成者のアクセス権限は変更できません。',
          );
        } else if (context.mounted) {
          showCupertinoModalBottomSheet(
            expand: false,
            context: context,
            builder: (context) => Material(
              child: Padding(
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
                      ...delAuthorAccessRollList
                          .map(
                            (roll) => InkWell(
                              onTap: () async {
                                final myself = ref.watch(firebaseAuthNotifierProvider).user;
                                final myselfShareUser = share.shareUserList.firstWhere((element) => element.id == myself?.uid);
                                if (myselfShareUser.roll != AccessRoll.author) {
                                  await showOkAlertDialog(
                                    context: context,
                                    title: '権限がありません。',
                                    message: 'この操作をする権限がありません。ゲームの管理者にお問い合わせください。',
                                  );
                                } else {
                                  final isSuccess =
                                      await ref.read(firestoreShareRepository).updateUserRoll(user.value, roll, share.docName);
                                  if (isSuccess) user.value = user.value.copyWith(roll: roll);
                                  if (context.mounted) Navigator.pop(context);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Opacity(
                                      opacity: user.value.roll == roll ? 1 : 0,
                                      child: const Icon(Icons.check),
                                    ),
                                    const SizedBox(width: 32),
                                    Text(
                                      roll.displayName,
                                      style: user.value.roll == roll
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
            ),
          );
        }
      },
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
    final user = ref.watch(currentSharedUserViewDataProvider).$2;
    final share = ref.watch(currentSharedUserViewDataProvider).$3;
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
