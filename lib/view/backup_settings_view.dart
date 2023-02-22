import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tcg_manager/helper/premium_plan_dialog.dart';
import 'package:tcg_manager/provider/backup_provider.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
import 'package:tcg_manager/repository/record_firestore_repository.dart';

class BackupSettingsView extends HookConsumerWidget {
  const BackupSettingsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final autoBackup = ref.watch(backupNotifierProvider);
    final isPremium = ref.watch(revenueCatNotifierProvider.select((value) => value.isPremium));
    return Scaffold(
      appBar: AppBar(
        title: const Text('バックアップ設定'),
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
        sections: [
          SettingsSection(
            tiles: [
              SettingsTile.switchTile(
                initialValue: autoBackup,
                onToggle: (value) async {
                  if (isPremium) {
                    ref.read(backupNotifierProvider.notifier).changeSetting(value);
                  } else {
                    await premiumPlanDialog(context);
                  }
                },
                title: const Text('自動でバックアップする'),
                description: const Text('自動でバックアップをONにすると常に最新の状態がバックアップされます。'),
              ),
              SettingsTile.navigation(
                title: const Text('手動でバックアップ'),
                leading: const Icon(Icons.backup_outlined),
                onPressed: (context) async {
                  await ref.read(firestoreRepository).setAll();
                },
              ),
              SettingsTile.navigation(
                title: const Text('バックアップから復元'),
                description: const Text('最終バックアップ：'),
                leading: const Icon(Icons.restore),
                onPressed: (context) async {
                  await ref.read(firestoreRepository).restoreAll();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
