import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:launch_review/launch_review.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/helper/db_helper.dart';
import 'package:tcg_manager/helper/theme_data.dart';
import 'package:tcg_manager/provider/bottom_navigation_bar_provider.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/provider/text_editing_controller_provider.dart';
import 'package:tcg_manager/provider/theme_provider.dart';
import 'package:tcg_manager/view/component/custom_textfield.dart';
import 'package:tcg_manager/view/component/web_view_screen.dart';

class OtherView extends HookConsumerWidget {
  const OtherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        title: Text(
          S.of(context).otherTitle,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
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
            title: Text(S.of(context).editSection),
            tiles: [
              SettingsTile(
                title: Text(S.of(context).gameEdit),
                leading: const Icon(Icons.edit),
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const _GameListView(),
                    ),
                  );
                },
              ),
              SettingsTile(
                title: Text(S.of(context).deckEdit),
                leading: const Icon(Icons.edit),
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const _DeckListView(),
                    ),
                  );
                },
              ),
              SettingsTile(
                title: Text(S.of(context).tagEdit),
                leading: const Icon(Icons.edit),
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const _TagListView(),
                    ),
                  );
                },
              ),
              SettingsTile(
                title: Text(
                  S.of(context).allDelete,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
                leading: const Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
                onPressed: (context) async {
                  final okCancelResult = await showOkCancelAlertDialog(
                    context: context,
                    title: S.of(context).allDeleteDialog,
                    message: S.of(context).allDeleteMessage,
                    isDestructiveAction: true,
                  );
                  if (okCancelResult == OkCancelResult.ok) {
                    ref.read(bottomNavigationBarNotifierProvider.notifier).select(0);
                    ref.read(textEditingControllerNotifierProvider.notifier).resetInputViewController();
                    await ref.read(dbHelper).deleteAll();
                  }
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text(S.of(context).otherSection),
            tiles: [
              SettingsTile(
                title: const Text('テーマ変更'),
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
              SettingsTile(
                title: Text(S.of(context).review),
                leading: const Icon(Icons.reviews),
                onPressed: (context) async {
                  LaunchReview.launch(iOSAppId: '1609073371');
                },
              ),
              SettingsTile(
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
              SettingsTile(
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
        ],
      ),
    );
  }
}

class _GameListView extends HookConsumerWidget {
  const _GameListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameList = ref.watch(allGameListNotifierProvider).allGameList;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        title: Text(
          S.of(context).gameEdit,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: gameList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemCount: gameList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8, child: Divider(height: 1)),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(gameList[index].game),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      final newName = await showTextInputDialog(
                        context: context,
                        title: S.of(context).gameEdit,
                        textFields: [DialogTextField(initialText: gameList[index].game)],
                      );
                      if (newName != null && newName.first != '') {
                        ref.read(allGameListNotifierProvider.notifier).updateName(newName.first, index);
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}

class _DeckListView extends HookConsumerWidget {
  const _DeckListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deckList = ref.watch(allDeckListNotifierProvider).allDeckList;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        title: Text(
          S.of(context).gameEdit,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: deckList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemCount: deckList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8, child: Divider(height: 1)),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(deckList[index].deck),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      final newName = await showTextInputDialog(
                        context: context,
                        title: S.of(context).gameEdit,
                        textFields: [DialogTextField(initialText: deckList[index].deck)],
                      );
                      if (newName != null && newName.first != '') {
                        ref.read(allDeckListNotifierProvider.notifier).updateName(newName.first, index);
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}

class _TagListView extends HookConsumerWidget {
  const _TagListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagList = ref.watch(allTagListNotifierProvider).allTagList;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        title: Text(
          S.of(context).gameEdit,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: tagList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemCount: tagList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8, child: Divider(height: 1)),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tagList[index].tag),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      final newName = await showTextInputDialog(
                        context: context,
                        title: S.of(context).gameEdit,
                        textFields: [DialogTextField(initialText: tagList[index].tag)],
                      );
                      if (newName != null && newName.first != '') {
                        ref.read(allTagListNotifierProvider.notifier).updateName(newName.first, index);
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}

class _ThemeChangeView extends HookConsumerWidget {
  const _ThemeChangeView({key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeNotifierProvider.notifier);
    final currentScheme = ref.watch(themeNotifierProvider.select((value) => value.scheme));
    final previewScheme = ref.watch(themeNotifierProvider.select((value) => value.previewScheme));
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return WillPopScope(
      onWillPop: () async {
        themeNotifier.changePreview(currentScheme);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 115,
          leading: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'キャンセル',
              style: Theme.of(context).primaryTextTheme.bodyText1,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => themeNotifier.changeTheme(),
              child: Text(
                '決定',
                style: Theme.of(context).primaryTextTheme.bodyText1,
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
                        height: 500,
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isDarkMode ? Colors.white : Colors.black,
                            width: 2,
                          ),
                        ),
                        child: const _InputViewMock(),
                      ),
                      Container(
                        height: 500,
                        width: 300,
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
                child: Scrollbar(
                  isAlwaysShown: true,
                  controller: ScrollController(),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: FlexScheme.values.length - 1, // 最後の要素はカスタムカラーのため取り除く
                    itemBuilder: ((context, index) => Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: SizedBox(
                            width: 55,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: FlexThemeData.light(scheme: FlexScheme.values[index]).primaryColor,
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
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
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
                    width: 145,
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
                    width: 145,
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
                  padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
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
                      const SizedBox(height: 16),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          CustomTextField(
                            labelText: S.of(context).opponentDeck,
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          CustomTextField(
                            labelText: S.of(context).tag,
                          ),
                          const Icon(Icons.arrow_drop_down)
                        ],
                      ),
                      const SizedBox(height: 16),
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
                        child: Text(S.of(context).save),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
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
