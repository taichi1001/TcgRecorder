// ignore_for_file: unused_result

import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:launch_review/launch_review.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/helper/list_to_csv.dart';
import 'package:tcg_manager/helper/premium_plan_dialog.dart';
import 'package:tcg_manager/helper/theme_data.dart';
import 'package:tcg_manager/main.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/provider/theme_provider.dart';
import 'package:tcg_manager/provider/user_info_settings_provider.dart';
import 'package:tcg_manager/selector/marged_record_list_selector.dart';
import 'package:tcg_manager/view/backup_settings_view.dart';
import 'package:tcg_manager/view/bottom_navigation_view.dart';
import 'package:tcg_manager/view/component/custom_textfield.dart';
import 'package:tcg_manager/view/component/web_view_screen.dart';
import 'package:tcg_manager/view/user_info_settings_view.dart';

class OtherView extends HookConsumerWidget {
  const OtherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPremium = ref.watch(revenueCatProvider.select((value) => value?.isPremium));
    final user = ref.watch(firebaseAuthNotifierProvider.select((value) => value.user));
    final isAnonymous = user?.phoneNumber == null;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          S.of(context).otherTitle,
        ),
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
            title: const Text(''),
            tiles: [
              const _UserInfoSettingsTile(),
              SettingsTile.navigation(
                title: const Text('バックアップ・復元'),
                leading: const Icon(
                  Icons.backup_outlined,
                  color: Colors.lightBlue,
                ),
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BackupSettingsView(),
                    ),
                  );
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text(S.of(context).otherSection),
            tiles: [
              SettingsTile.navigation(
                title: Text(S.of(context).themeChange),
                leading: const Icon(Icons.palette),
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const _ThemeChangeView(),
                    ),
                  );
                },
              ),
              SettingsTile.navigation(
                title: Row(
                  children: [
                    const Text('CSV出力'),
                    if (!isPremium!) const SizedBox(width: 8),
                    if (!isPremium) const Icon(Icons.lock, size: 14),
                  ],
                ),
                leading: const Icon(FontAwesomeIcons.fileCsv),
                onPressed: (context) async {
                  if (isPremium) {
                    final margedRecordList = await ref.read(allMargedRecordListProvider.future);
                    final csv = ListToCSV.margeRecordListToCSV(margedRecordList);
                    final savePath = ref.read(imagePathProvider);
                    final logPath = '$savePath/tcg_manager_output_${DateFormat('yyyy-MM-dd').format(DateTime.now())}.csv';
                    final textfilePath = File(logPath);
                    await textfilePath.writeAsString(csv);
                    Share.shareXFiles([XFile(logPath)]);
                  } else {
                    await premiumPlanDialog(context);
                  }
                },
              ),
              SettingsTile.navigation(
                title: Text(S.of(context).review),
                leading: const Icon(Icons.reviews),
                onPressed: (context) async {
                  LaunchReview.launch(iOSAppId: '1609073371');
                },
              ),
              SettingsTile.navigation(
                title: Text(S.of(context).contactForm),
                leading: const Icon(Icons.mail),
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WebViewScreen(
                        url: 'https://docs.google.com/forms/d/e/1FAIpQLSd5ilK8mF76ZnLIPirTFPo0A5fQucYTMf9uDkdD--SkRbczjA/viewform',
                      ),
                    ),
                  );
                },
              ),
              SettingsTile.navigation(
                title: const Text('利用規約'),
                leading: const Icon(Icons.assignment_turned_in),
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WebViewScreen(
                        url: 'https://phrygian-jellyfish-595.notion.site/067af33073004575b08a958497083e30',
                      ),
                    ),
                  );
                },
              ),
              SettingsTile.navigation(
                title: Text(S.of(context).privacyPolicy),
                leading: const Icon(Icons.privacy_tip),
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WebViewScreen(
                        url: 'https://phrygian-jellyfish-595.notion.site/Privacy-Policy-057b29da8fb74d76bccd700d80db53e1',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          CustomSettingsSection(
            child: TextButton(
              onPressed: () async {
                final okCancelResult = await showOkCancelAlertDialog(
                  context: context,
                  title: 'ログアウト',
                  message: isAnonymous
                      ? 'ログアウトするとこれまで記録したデータにアクセスできなくなります。ログアウトしてもよろしいですか？\n(電話番号認証を有効にしデータをバックアップすると、ログアウト後にもバックアップから復帰できるようになります。)'
                      : 'ログアウトしてもよろしいですか？',
                  isDestructiveAction: true,
                );
                if (okCancelResult == OkCancelResult.ok) {
                  await ref.read(firebaseAuthNotifierProvider.notifier).singOut();
                  ref.read(selectIndexProvider.notifier).state = 0;
                }
              },
              child: const Text('ログアウト'),
            ),
          ),
          CustomSettingsSection(
            child: TextButton(
              onPressed: () async {
                final okCancelResult = await showOkCancelAlertDialog(
                  context: context,
                  title: '退会する',
                  message: '退会すると全てのデータが削除され復元不可能になります。退会してもよろしいですか？',
                  isDestructiveAction: true,
                );
                if (okCancelResult == OkCancelResult.ok) {
                  await ref.read(firebaseAuthNotifierProvider.notifier).quiteUser();
                  ref.read(selectGameNotifierProvider.notifier).changeGame(null);
                }
              },
              child: const Text('退会する'),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserInfoSettingsTile extends AbstractSettingsTile {
  const _UserInfoSettingsTile();
  @override
  Widget build(BuildContext context) {
    return const _UserInfoSettingsTileHooksConsumerWidget();
  }
}

class _UserInfoSettingsTileHooksConsumerWidget extends HookConsumerWidget {
  const _UserInfoSettingsTileHooksConsumerWidget();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoSettings = ref.watch(userInfoSettingsProvider);
    return SettingsTile.navigation(
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Theme.of(context).colorScheme.primary,
        backgroundImage: userInfoSettings.iconPath == null ? null : CachedNetworkImageProvider(userInfoSettings.iconPath!),
        child: userInfoSettings.iconPath == null
            ? Text(
                userInfoSettings.name == null ? '名' : userInfoSettings.name![0],
                style: Theme.of(context).primaryTextTheme.bodyMedium,
              )
            : null,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(userInfoSettings.name ?? '名前未設定'),
          const SizedBox(height: 4),
          Row(
            children: [
              if (userInfoSettings.isPhoneAuth)
                Text(
                  '電話認証済',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                ),
              if (!userInfoSettings.isPhoneAuth)
                Text(
                  '電話未認証',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.error),
                ),
              Text(
                '、',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (userInfoSettings.isPremium)
                Text(
                  'プレミアムプラン加入中',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                ),
              if (!userInfoSettings.isPremium)
                Text(
                  'プレミアムプラン未加入',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.error),
                ),
            ],
          ),
        ],
      ),
      onPressed: (context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserInfoSettingsView(),
          ),
        );
      },
    );
  }
}

final currentGameProvider = Provider<Game>((ref) {
  return throw UnimplementedError();
});

class _ThemeChangeView extends HookConsumerWidget {
  const _ThemeChangeView({key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeNotifierProvider.notifier);
    final currentScheme = ref.watch(themeNotifierProvider.select((value) => value.scheme));
    final previewScheme = ref.watch(themeNotifierProvider.select((value) => value.previewScheme));
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final previewThemeDataList = ref.watch(previewThemeDataListProvider(isDarkMode));
    final itemScrollController = ItemScrollController();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) => itemScrollController.jumpTo(index: currentScheme.index));
      return;
    }, const []);

    return WillPopScope(
      onWillPop: () async {
        themeNotifier.changePreview(currentScheme);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 115,
          leading: TextButton(
            onPressed: () {
              themeNotifier.changePreview(currentScheme);
              Navigator.of(context).pop();
            },
            child: Text(
              S.of(context).cancel,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                themeNotifier.changeTheme();
                Navigator.of(context).pop();
              },
              child: Text(
                S.of(context).submit,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 500.h,
                        width: 300.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isDarkMode ? Colors.white : Colors.black,
                            width: 2,
                          ),
                        ),
                        child: const _InputViewMock(),
                      ),
                      Container(
                        height: 500.h,
                        width: 300.w,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Container(
                height: 100,
                color: Theme.of(context).dividerColor,
                child: ScrollablePositionedList.builder(
                  itemScrollController: itemScrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: FlexScheme.values.length - 1, // 最後の要素はカスタムカラーのため取り除く
                  itemBuilder: ((context, index) => Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: SizedBox(
                          width: 55,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: previewThemeDataList[index].primaryColor,
                              shape: CircleBorder(
                                side: previewScheme == FlexScheme.values[index]
                                    ? BorderSide(
                                        color: isDarkMode ? Colors.white : Colors.black,
                                        width: 2,
                                      )
                                    : BorderSide.none,
                              ),
                            ),
                            onPressed: () => themeNotifier.changePreview(FlexScheme.values[index]),
                            child: const Text(''),
                          ),
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InputViewMock extends HookConsumerWidget {
  const _InputViewMock({key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lightThemeData = ref.watch(previewLightThemeDataProvider);
    final darkThemeData = ref.watch(previewDarkThemeDataProvider);
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Theme(
      data: isDarkMode ? darkThemeData : lightThemeData,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('プレビュー'),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('2022年 01月 01日'),
                      Icon(Icons.calendar_today_rounded),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 135,
                    child: Card(
                      child: Column(
                        children: [
                          RadioListTile(
                            title: Text(S.of(context).first),
                            value: 1,
                            groupValue: 1,
                            onChanged: (value) {},
                            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                            dense: true,
                          ),
                          RadioListTile(
                            title: Text(S.of(context).second),
                            value: 2,
                            groupValue: int,
                            onChanged: (value) {},
                            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                            dense: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 135,
                    child: Card(
                      child: Column(
                        children: [
                          RadioListTile(
                            title: Text(S.of(context).win),
                            value: 1,
                            groupValue: 1,
                            onChanged: (value) {},
                            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                            dense: true,
                          ),
                          RadioListTile(
                            title: Text(S.of(context).loss),
                            value: 2,
                            groupValue: int,
                            onChanged: (value) {},
                            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                            dense: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          CustomTextField(
                            labelText: S.of(context).useDeck,
                          ),
                          const Icon(Icons.arrow_drop_down)
                        ],
                      ),
                      const SizedBox(height: 8),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          CustomTextField(
                            labelText: S.of(context).opponentDeck,
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          CustomTextField(
                            labelText: S.of(context).tag,
                          ),
                          const Icon(Icons.arrow_drop_down)
                        ],
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        labelText: S.of(context).memoTag,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(S.of(context).save),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
