import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:launch_review/launch_review.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/helper/db_helper.dart';
import 'package:tcg_manager/helper/theme_data.dart';
import 'package:tcg_manager/provider/bottom_navigation_bar_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/input_view_settings_provider.dart';
import 'package:tcg_manager/provider/text_editing_controller_provider.dart';
import 'package:tcg_manager/provider/theme_provider.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/selector/game_tag_list_selector.dart';
import 'package:tcg_manager/view/component/custom_textfield.dart';
import 'package:tcg_manager/view/component/slidable_tile.dart';
import 'package:tcg_manager/view/component/web_view_screen.dart';

class OtherView extends HookConsumerWidget {
  const OtherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          S.of(context).otherTitle,
          style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
            title: Text(S.of(context).settingSection),
            tiles: [
              // テーマ設定画面を開放するときにコメントアウト
              // SettingsTile.navigation(
              //   title: Text(S.of(context).themeChange),
              //   leading: const Icon(Icons.palette),
              //   onPressed: (context) {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const _ThemeChangeView(),
              //       ),
              //     );
              //   },
              // ),
              SettingsTile.navigation(
                title: Text(S.of(context).inputViewSettings),
                leading: const Icon(Icons.settings_applications),
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const _InputViewSettingsView(),
                    ),
                  );
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text(S.of(context).editSection),
            tiles: [
              SettingsTile.navigation(
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
              SettingsTile.navigation(
                title: Text(S.of(context).deckEdit),
                leading: const Icon(Icons.edit),
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const _GameSelectView(
                        nextPage: _DeckListView(),
                      ),
                    ),
                  );
                },
              ),
              SettingsTile.navigation(
                title: Text(S.of(context).tagEdit),
                leading: const Icon(Icons.edit),
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const _GameSelectView(
                        nextPage: _TagListView(),
                      ),
                    ),
                  );
                },
              ),
              SettingsTile.navigation(
                title: Text(
                  S.of(context).allDelete,
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                ),
                leading: Icon(
                  Icons.delete_forever,
                  color: Theme.of(context).errorColor,
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

class _InputViewSettingsView extends HookConsumerWidget {
  const _InputViewSettingsView({key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fixUseDeck = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.fixUseDeck));
    final fixOpponentDeck = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.fixOpponentDeck));
    final fixTag = ref.watch(inputViewSettingsNotifierProvider.select((value) => value.fixTag));
    final inputiViewSettingsController = ref.watch(inputViewSettingsNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          '入力画面設定',
          style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
            title: const Text('入力固定オプション'),
            tiles: [
              SettingsTile.switchTile(
                initialValue: fixUseDeck,
                onToggle: (settings) => inputiViewSettingsController.changeFixUseDeck(settings),
                title: const Text('使用デッキ'),
                leading: const Icon(Icons.settings_applications),
              ),
              SettingsTile.switchTile(
                initialValue: fixOpponentDeck,
                onToggle: (settings) => inputiViewSettingsController.changeFixOpponentDeck(settings),
                title: const Text('対戦相手デッキ'),
                leading: const Icon(Icons.settings_applications),
              ),
              SettingsTile.switchTile(
                initialValue: fixTag,
                onToggle: (settings) => inputiViewSettingsController.changeFixTag(settings),
                title: const Text('タグ'),
                leading: const Icon(Icons.settings_applications),
              ),
            ],
          ),
          CustomSettingsSection(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '設定ON:  記録保存時に入力欄の設定ONの項目が保持されます。',
                    style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 10),
                  ),
                  Text(
                    '設定OFF: 記録保存時に入力欄の設定OFFの項目がリセットされます。',
                    style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ),
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
    final gameList = ref.watch(allGameListProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          S.of(context).gameEdit,
          style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: gameList.when(
        data: (gameList) {
          return ListView.separated(
            itemCount: gameList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8, child: Divider(height: 1)),
            itemBuilder: (context, index) {
              return SlidableTile(
                key: ObjectKey(gameList[index]),
                title: Text(gameList[index].game),
                alertMessage: '削除したゲームのデータが全て削除されます。(デッキ名やタグ名も削除されます。)',
                deleteFunc: () async => await ref.read(dbHelper).deleteGame(gameList[index]),
                editFunc: () async {
                  final newName = await showTextInputDialog(
                    context: context,
                    title: '名前変更',
                    textFields: [DialogTextField(initialText: gameList[index].game)],
                  );
                  if (newName != null && newName.first != '') {
                    try {
                      await ref.read(dbHelper).updateGameName(newName.first, index);
                    } catch (e) {
                      if (e.toString().contains('2067')) {
                        await showOkAlertDialog(
                          context: context,
                          title: 'エラー',
                          message: '既に登録されているゲームです。',
                        );
                      } else {
                        await showOkAlertDialog(
                          context: context,
                          title: '予期せぬエラー',
                        );
                      }
                    }
                  }
                },
              );
            },
          );
        },
        error: (error, stack) => Text('$error'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

final currentGameProvider = Provider<Game>((ref) {
  return throw UnimplementedError();
});

class _GameSelectView extends HookConsumerWidget {
  const _GameSelectView({
    required this.nextPage,
    key,
  }) : super(key: key);

  final Widget nextPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameList = ref.watch(allGameListProvider);
    return gameList.when(
      data: (gameList) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              'ゲーム選択',
              style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          body: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                color: Theme.of(context).colorScheme.surface,
                child: ListTile(
                  title: Text(gameList[index].game),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProviderScope(
                          overrides: [currentGameProvider.overrideWithValue(gameList[index])],
                          child: nextPage,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(indent: 16, thickness: 1, height: 0),
            itemCount: gameList.length,
          ),
        );
      },
      error: (error, stack) => Text('$error'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _DeckListView extends HookConsumerWidget {
  const _DeckListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentGame = ref.watch(currentGameProvider);
    final deckList = ref.watch(currentGameDeckListProvider(currentGame));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          S.of(context).deckEdit,
          style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: deckList.when(
        data: (deckList) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: deckList.length,
            separatorBuilder: (context, index) => const Divider(indent: 16, thickness: 1, height: 0),
            itemBuilder: (context, index) {
              return Container(
                color: Theme.of(context).colorScheme.surface,
                child: SlidableTile(
                  key: ObjectKey(deckList[index]),
                  title: Text(
                    deckList[index].deck,
                    style: deckList[index].isVisibleToPicker
                        ? Theme.of(context).textTheme.bodyMedium
                        : Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).disabledColor,
                            ),
                  ),
                  alertMessage: '選択したデッキのデータが全て削除されます。',
                  deleteFunc: () async => await ref.read(dbHelper).deleteDeck(deckList[index]),
                  editFunc: () async {
                    final newName = await showTextInputDialog(
                      context: context,
                      title: '名前変更',
                      textFields: [DialogTextField(initialText: deckList[index].deck)],
                    );
                    if (newName != null && newName.first != '') {
                      try {
                        await ref.read(dbHelper).updateDeckName(newName.first, index);
                      } catch (e) {
                        if (e.toString().contains('2067')) {
                          await showOkAlertDialog(
                            context: context,
                            title: 'エラー',
                            message: '既に登録されているデッキです。',
                          );
                        } else {
                          await showOkAlertDialog(
                            context: context,
                            title: '予期せぬエラー',
                          );
                        }
                      }
                    }
                  },
                ),
              );
            },
          );
        },
        error: (error, stack) => Text('$error'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _TagListView extends HookConsumerWidget {
  const _TagListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentGame = ref.watch(currentGameProvider);
    final tagList = ref.watch(currentTagDeckListProvider(currentGame));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          S.of(context).tagEdit,
          style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: tagList.when(
        data: (tagList) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: tagList.length,
            separatorBuilder: (context, index) => const Divider(indent: 16, thickness: 1, height: 0),
            itemBuilder: (context, index) {
              return Container(
                color: Theme.of(context).colorScheme.surface,
                child: SlidableTile(
                  key: ObjectKey(tagList[index]),
                  title: Text(
                    tagList[index].tag,
                    style: tagList[index].isVisibleToPicker
                        ? Theme.of(context).textTheme.bodyMedium
                        : Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).disabledColor,
                            ),
                  ),
                  alertMessage: '選択したタグを削除し、そのタグが設定されているデータからタグを削除します。',
                  deleteFunc: () async => await ref.read(dbHelper).deleteTag(tagList[index]),
                  editFunc: () async {
                    final newName = await showTextInputDialog(
                      context: context,
                      title: '名前変更',
                      textFields: [DialogTextField(initialText: tagList[index].tag)],
                    );
                    if (newName != null && newName.first != '') {
                      try {
                        await ref.read(dbHelper).updateTagName(newName.first, index);
                      } catch (e) {
                        if (e.toString().contains('2067')) {
                          await showOkAlertDialog(
                            context: context,
                            title: 'エラー',
                            message: '既に登録されているタグです。',
                          );
                        } else {
                          await showOkAlertDialog(
                            context: context,
                            title: '予期せぬエラー',
                          );
                        }
                      }
                    }
                  },
                ),
              );
            },
          );
        },
        error: (error, stack) => Text('$error'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

// ignore: unused_element
class _ThemeChangeView extends HookConsumerWidget {
  const _ThemeChangeView({key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeNotifierProvider.notifier);
    final currentScheme = ref.watch(themeNotifierProvider.select((value) => value.scheme));
    final previewScheme = ref.watch(themeNotifierProvider.select((value) => value.previewScheme));
    final previewThemeDataList = ref.watch(previewThemeDataListProvider);
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
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
              style: Theme.of(context).primaryTextTheme.bodyText1,
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
                child: Scrollbar(
                  controller: ScrollController(),
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
                                primary: previewThemeDataList[index].primaryColor,
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
