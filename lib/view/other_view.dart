// ignore_for_file: unused_result

import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:launch_review/launch_review.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/helper/db_helper.dart';
import 'package:tcg_manager/helper/edit_record_helper.dart';
import 'package:tcg_manager/helper/list_to_csv.dart';
import 'package:tcg_manager/helper/premium_plan_dialog.dart';
import 'package:tcg_manager/helper/theme_data.dart';
import 'package:tcg_manager/main.dart';
import 'package:tcg_manager/provider/backup_provider.dart';
import 'package:tcg_manager/provider/bottom_navigation_bar_provider.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/revenue_cat_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/provider/text_editing_controller_provider.dart';
import 'package:tcg_manager/provider/theme_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/provider/firestore_controller.dart';
import 'package:tcg_manager/repository/record_repository.dart';
import 'package:tcg_manager/repository/tag_repository.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/selector/game_tag_list_selector.dart';
import 'package:tcg_manager/selector/marged_record_list_selector.dart';
import 'package:tcg_manager/view/backup_settings_view.dart';
import 'package:tcg_manager/view/component/custom_textfield.dart';
import 'package:tcg_manager/view/component/slidable_tile.dart';
import 'package:tcg_manager/view/component/web_view_screen.dart';
import 'package:tcg_manager/view/phone_number_auth_view.dart';
import 'package:tcg_manager/view/phone_number_deactivation_view.dart';
import 'package:tcg_manager/view/premium_plan_purchase_view.dart';

class OtherView extends HookConsumerWidget {
  const OtherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPremium = ref.watch(revenueCatNotifierProvider.select((value) => value.isPremium));
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
            tiles: [
              SettingsTile.navigation(
                title: Text(S.of(context).premiumPlan),
                leading: const Icon(
                  Icons.auto_awesome,
                  color: Colors.orange,
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
                title: Text(isAnonymous ? '電話番号認証' : '電話番号認証の解除'),
                leading: const Icon(
                  Icons.phone,
                  color: Colors.green,
                ),
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return isAnonymous ? const PhoneNumberAuthView() : const PhoneNumberDeactivationView();
                      },
                    ),
                  );
                },
              ),
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
            title: Text(S.of(context).editSection),
            tiles: [
              SettingsTile.navigation(
                title: Text(
                  S.of(context).gameEdit,
                  style: TextStyle(color: Theme.of(context).disabledColor),
                ),
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
                title: Text(
                  S.of(context).deckEdit,
                  style: TextStyle(color: Theme.of(context).disabledColor),
                ),
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
                title: Text(
                  S.of(context).tagEdit,
                  style: TextStyle(color: Theme.of(context).disabledColor),
                ),
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
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                leading: Icon(
                  Icons.delete_forever,
                  color: Theme.of(context).colorScheme.error,
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
                title: const Text('CSV出力'),
                leading: const Icon(FontAwesomeIcons.fileCsv),
                onPressed: (context) async {
                  if (isPremium) {
                    final margedRecordList = await ref.read(allMargedRecordListProvider.future);
                    final csv = ListToCSV.margeRecordListToCSV(margedRecordList);
                    final savePath = ref.read(imagePathProvider);
                    final logPath = '$savePath/toremane_output.csv';
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
            child: Text(ref.read(firebaseAuthNotifierProvider).user!.uid),
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
                  ref.read(firebaseAuthNotifierProvider.notifier).singOut();
                }
              },
              child: const Text('ログアウト'),
            ),
          ),
          CustomSettingsSection(
            child: TextButton(
              onPressed: () {},
              child: const Text('退会する'),
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
        title: Text(S.of(context).gameEdit),
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
                      await ref.read(dbHelper).updateGameName(gameList[index], newName.first);
                    } catch (e) {
                      if (e.toString().contains('2067')) {
                        if (context.mounted) {
                          await showOkAlertDialog(
                            context: context,
                            title: '既に登録されているゲームです',
                          );
                        }
                        // if (result == OkCancelResult.ok) {
                        //   // ゲームを統合したことで、ゲームID違いで同じ名前だったデッキやタグが
                        //   // ゲームIDも同じになってしまうことで重複エラーが出るようになっているため修正必要
                        //   final oldGame = await ref.read(editRecordHelper).checkIfSelectedGameIsNew(newName.first);
                        //   final allRecordList = await ref.read(recordRepository).getAll();
                        //   final targetRecordList = allRecordList.where((record) => record.gameId == gameList[index].gameId).toList();
                        //   final List<Record> newRecordList = [];
                        //   for (var record in targetRecordList) {
                        //     record = record.copyWith(gameId: oldGame.game!.gameId);
                        //     newRecordList.add(record);
                        //   }
                        //   await ref.read(recordRepository).updateRecordList(newRecordList);

                        //   final allDeckList = await ref.read(deckRepository).getAll();
                        //   final targetDeckList = allDeckList.where((deck) => deck.gameId! == gameList[index].gameId).toList();
                        //   final List<Deck> newDeckList = [];
                        //   for (var deck in targetDeckList) {
                        //     deck = deck.copyWith(gameId: oldGame.game!.gameId);
                        //     newDeckList.add(deck);
                        //   }
                        //   await ref.read(deckRepository).updateDeckList(newDeckList);

                        //   final allTagList = await ref.read(tagRepository).getAll();
                        //   final targetTagList = allTagList.where((tag) => tag.gameId! == gameList[index].gameId).toList();
                        //   final List<Tag> newTagList = [];
                        //   for (var tag in targetTagList) {
                        //     tag = tag.copyWith(gameId: oldGame.game!.gameId);
                        //     newTagList.add(tag);
                        //   }
                        //   await ref.read(tagRepository).updateTagList(newTagList);

                        //   await ref.read(gameRepository).deleteById(gameList[index].gameId!);
                        //   ref.refresh(allTagListProvider);
                        //   ref.refresh(allDeckListProvider);
                        //   ref.refresh(allRecordListProvider);
                        // }
                      } else {
                        if (context.mounted) {
                          await showOkAlertDialog(
                            context: context,
                            title: '予期せぬエラー',
                          );
                        }
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
            title: const Text('ゲーム選択'),
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
        title: Text(S.of(context).deckEdit),
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
                    deckList[index].name,
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
                      textFields: [DialogTextField(initialText: deckList[index].name)],
                    );
                    if (newName != null && newName.first != '') {
                      try {
                        await ref.read(dbHelper).updateDeckName(deckList[index], newName.first);
                      } catch (e) {
                        if (e.toString().contains('2067') && context.mounted) {
                          final result = await showOkCancelAlertDialog(
                            context: context,
                            title: '既に登録されているデッキです',
                            message: '保存されている記録を統合しますか？',
                          );
                          if (result == OkCancelResult.ok) {
                            final oldDeck = await ref.read(editRecordHelper).checkIfSelectedUseDeckIsNew(newName.first);
                            var allRecordList = await ref.read(recordRepository).getAll();
                            final targetUseDeckList = allRecordList.where((record) => record.useDeckId! == deckList[index].id).toList();
                            final List<Record> newUseDeckRecordList = [];
                            for (var deck in targetUseDeckList) {
                              deck = deck.copyWith(useDeckId: oldDeck.deck!.id);
                              newUseDeckRecordList.add(deck);
                            }
                            await ref.read(recordRepository).updateRecordList(newUseDeckRecordList);

                            allRecordList = await ref.read(recordRepository).getAll();
                            final targetOpponentDeckList =
                                allRecordList.where((record) => record.opponentDeckId! == deckList[index].id).toList();
                            final List<Record> newOpponentDeckRecordList = [];
                            for (var deck in targetOpponentDeckList) {
                              deck = deck.copyWith(opponentDeckId: oldDeck.deck!.id);
                              newOpponentDeckRecordList.add(deck);
                            }
                            await ref.read(recordRepository).updateRecordList(newOpponentDeckRecordList);

                            await ref.read(deckRepository).deleteById(deckList[index].id!);

                            ref.refresh(allDeckListProvider);
                            ref.refresh(allRecordListProvider);
                            if (ref.read(backupNotifierProvider)) await ref.read(firestoreController).addAll();
                          }
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
        title: Text(S.of(context).tagEdit),
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
                    tagList[index].name,
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
                      textFields: [DialogTextField(initialText: tagList[index].name)],
                    );
                    if (newName != null && newName.first != '') {
                      try {
                        await ref.read(dbHelper).updateTagName(tagList[index], newName.first);
                      } catch (e) {
                        if (e.toString().contains('2067') && context.mounted) {
                          final result = await showOkCancelAlertDialog(
                            context: context,
                            title: '既に登録されているタグです。',
                            message: '保存されている記録を統合しますか？',
                          );
                          if (result == OkCancelResult.ok) {
                            final oldTag = await ref.read(editRecordHelper).checkIfSelectedTagIsNew(newName.first);
                            final allRecordList = await ref.read(recordRepository).getAll();
                            final isTagRecordList = allRecordList.where((record) => record.tagId.isNotEmpty);
                            final targetRecordList = isTagRecordList.where((record) => record.tagId.contains(tagList[index].id)).toList();

                            final List<Record> newTagRecordList = [];
                            for (var record in targetRecordList) {
                              List<int> newTagIdList = [];
                              for (final tagId in record.tagId) {
                                if (tagId == tagList[index].id) {
                                  newTagIdList.add(oldTag.tag!.id!);
                                } else {
                                  newTagIdList.add(tagId);
                                }
                              }
                              record = record.copyWith(tagId: newTagIdList.toSet().toList());
                              newTagRecordList.add(record);
                            }
                            await ref.read(recordRepository).updateRecordList(newTagRecordList);
                            await ref.read(tagRepository).deleteById(tagList[index].id!);

                            ref.refresh(allTagListProvider);
                            ref.refresh(allRecordListProvider);
                            if (ref.read(backupNotifierProvider)) await ref.read(firestoreController).addAll();
                          }
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
