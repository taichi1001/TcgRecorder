import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tcg_manager/helper/premium_plan_dialog.dart';
import 'package:tcg_manager/provider/backup_provider.dart';
import 'package:tcg_manager/provider/execution_limit_cound_provider.dart';
import 'package:tcg_manager/provider/input_view_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
import 'package:tcg_manager/provider/firestore_controller.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/provider/text_editing_controller_provider.dart';

class BackupSettingsView extends HookConsumerWidget {
  const BackupSettingsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final autoBackup = ref.watch(backupNotifierProvider);
    final isPremium = ref.watch(revenueCatNotifierProvider.select((value) => value.isPremium));
    final executionCount = ref.watch(executionCountProvider);
    final isLoading = useState(false);
    return Stack(
      children: [
        Scaffold(
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
                    title: const Text('自動バックアップをON'),
                    description: const Text('自動バックアップをONにすると常に最新の状態がバックアップされます。'),
                  ),
                  SettingsTile.navigation(
                    title: const Text('手動でバックアップ'),
                    leading: const Icon(Icons.backup_outlined),
                    description: Text('本日のバックアップ回数: $executionCount/3'),
                    onPressed: (context) async {
                      if (ref.read(canExecuteProvider)) {
                        isLoading.value = true;
                        await ref.read(firestoreController).addAll();
                        isLoading.value = false;
                        if (context.mounted) {
                          await showOkAlertDialog(
                            context: context,
                            title: 'バックアップ完了',
                            message: 'バックアップが正常に完了しました。',
                          );
                          if (context.mounted) {
                            ref.read(executionCountProvider.notifier).increment();
                          }
                        }
                      } else {
                        await showOkAlertDialog(
                          context: context,
                          title: 'バックアップ回数の上限到達',
                          message: '手動バックアップは一日に3回までです。明日以降に再実行してください。',
                        );
                      }
                    },
                  ),
                  SettingsTile.navigation(
                    title: const Text('バックアップから復元'),
                    description: const Text('最終バックアップ：'),
                    leading: const Icon(Icons.restore),
                    onPressed: (context) async {
                      isLoading.value = true;
                      await ref.read(firestoreController).restoreAll();
                      final recordList = await ref.read(allRecordListProvider.future);
                      if (recordList.isNotEmpty) {
                        await ref.read(selectGameNotifierProvider.notifier).changeGameForId(recordList.last.gameId!);
                        await ref.read(inputViewNotifierProvider.notifier).init();
                        ref.read(textEditingControllerNotifierProvider.notifier).resetInputViewController();
                      } else {
                        await ref.read(selectGameNotifierProvider.notifier).changeGameForLast();
                        await ref.read(inputViewNotifierProvider.notifier).init();
                        ref.read(textEditingControllerNotifierProvider.notifier).resetInputViewController();
                      }
                      isLoading.value = false;
                      if (context.mounted) {
                        await showOkAlertDialog(
                          context: context,
                          title: '復元完了',
                          message: 'データの復元が正常に完了しました。',
                        );
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        if (isLoading.value)
          const Opacity(
            opacity: 0.7,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.black,
            ),
          ),
        if (isLoading.value)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
