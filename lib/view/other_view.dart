import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:launch_review/launch_review.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/helper/db_helper.dart';
import 'package:tcg_manager/provider/bottom_navigation_bar_provider.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/provider/text_editing_controller_provider.dart';
import 'package:tcg_manager/provider/theme_provider.dart';
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
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: FlexScheme.values.length,
        itemBuilder: ((context, index) => TextButton(
              onPressed: () => themeNotifier.changeTheme(FlexScheme.values[index]),
              child: Text(FlexScheme.values[index].name),
            )),
      ),
    );
  }
}
