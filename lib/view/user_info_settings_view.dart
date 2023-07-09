import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
import 'package:tcg_manager/provider/user_info_settings_provider.dart';
import 'package:tcg_manager/view/phone_number_auth_view.dart';
import 'package:tcg_manager/view/phone_number_deactivation_view.dart';
import 'package:tcg_manager/view/premium_plan_purchase_view.dart';

class UserInfoSettingsView extends HookConsumerWidget {
  const UserInfoSettingsView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoSettings = ref.watch(userInfoSettingsProvider);
    final revenuecatInfo = ref.watch(revenueCatProvider);
    final dateFormat = DateFormat("yyyy-MM-dd");
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
                  onTap: () async {
                    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      final croppedFile = await ImageCropper().cropImage(
                        sourcePath: pickedFile.path,
                        compressQuality: 100,
                      );
                      if (croppedFile != null) {
                        await ref.read(userInfoSettingsProvider.notifier).setImagePath(croppedFile.path);
                      }
                    }
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        backgroundImage: userInfoSettings.iconPath == null ? null : CachedNetworkImageProvider(userInfoSettings.iconPath!),
                        child: userInfoSettings.iconPath == null
                            ? Text(
                                userInfoSettings.name == null ? '名' : userInfoSettings.name![0],
                                style: Theme.of(context).primaryTextTheme.bodyMedium,
                              )
                            : null,
                      ),
                      const Icon(Icons.photo_camera),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () async {
                    final newName = await showTextInputDialog(
                      context: context,
                      title: 'ユーザー名を編集',
                      textFields: [
                        DialogTextField(initialText: userInfoSettings.name),
                      ],
                    );
                    if (newName != null && newName.isNotEmpty && newName.first != '') {
                      ref.read(userInfoSettingsProvider.notifier).setUserName(newName.first);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userInfoSettings.name ?? '名前未設定',
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
                    await Clipboard.setData(ClipboardData(text: userInfoSettings.id!));
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
                        userInfoSettings.id ?? '',
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
                description: Text(revenuecatInfo?.customerInfo?.latestExpirationDate == null
                    ? ''
                    : 'サブスク有効期限：${dateFormat.format(DateTime.parse(revenuecatInfo!.customerInfo!.latestExpirationDate!))}'),
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
