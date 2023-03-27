import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/user_info_settings_provider.dart';
import 'package:tcg_manager/view/phone_number_auth_view.dart';
import 'package:tcg_manager/view/phone_number_deactivation_view.dart';
import 'package:tcg_manager/view/premium_plan_purchase_view.dart';

class UserInfoSettingsView extends HookConsumerWidget {
  const UserInfoSettingsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoSettings = ref.watch(userInfoSettingsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザー情報設定'),
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
          CustomSettingsSection(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // TODO iconデータをFirestoreに保存する処理記載
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        backgroundImage: userInfoSettings.iconPath == null ? null : CachedNetworkImageProvider(userInfoSettings.iconPath!),
                        child: userInfoSettings.iconPath == null ? Text(userInfoSettings.name[0]) : null,
                      ),
                      const Icon(Icons.photo_camera),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    final newName = showTextInputDialog(
                      context: context,
                      title: 'ユーザー名を編集',
                      textFields: [
                        DialogTextField(initialText: userInfoSettings.name),
                      ],
                    );
                    // TODO newNameをfirestoreに保存する処理を記載
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userInfoSettings.name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.edit, size: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: userInfoSettings.id));
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('IDをコピーしました'),
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userInfoSettings.id,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.copy, size: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SettingsSection(
            title: const Text(''),
            tiles: [
              SettingsTile.navigation(
                title: Text(S.of(context).premiumPlan),
                leading: const Icon(
                  Icons.auto_awesome,
                  color: Colors.orange,
                ),
                value: Text(
                  userInfoSettings.isPremium ? '登録済み' : '未登録',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => const PremiumPlanPurchaseView(),
                    ),
                  );
                },
              ),
              SettingsTile.navigation(
                title: Text(userInfoSettings.isPhoneAuth ? '電話番号認証の解除' : '電話番号認証'),
                leading: const Icon(
                  Icons.phone,
                  color: Colors.green,
                ),
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return userInfoSettings.isPhoneAuth ? const PhoneNumberDeactivationView() : const PhoneNumberAuthView();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
