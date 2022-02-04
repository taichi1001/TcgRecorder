import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tcg_manager/helper/db_helper.dart';
import 'package:tcg_manager/provider/bottom_navigation_bar_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';

class OtherView extends HookConsumerWidget {
  const OtherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0.0,
        title: const Text(
          'その他',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SettingsList(
        lightTheme: const SettingsThemeData(
          settingsListBackground: Colors.white,
        ),
        sections: [
          SettingsSection(
            title: const Text('編集'),
            tiles: [
              SettingsTile(
                title: const Text('ゲーム編集'),
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
                title: const Text(
                  '全データ削除',
                  style: TextStyle(
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
                    title: '全データを削除します',
                    message: '全てのデータが削除され元に戻らなくなりますがよろしいですか？',
                    isDestructiveAction: true,
                  );
                  if (okCancelResult == OkCancelResult.ok) {
                    ref.read(bottomNavigationBarNotifierProvider.notifier).select(0);
                    await ref.read(dbHelper).deleteAll();
                  }
                },
              ),
            ],
          ),
          SettingsSection(
            title: const Text('その他'),
            tiles: [
              SettingsTile(
                title: const Text('アプリをレビュー'),
                leading: const Icon(Icons.reviews),
                onPressed: (context) async {
                  // await AppReview.requestReview.then((value) => print(value));
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
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0.0,
        title: const Text(
          'ゲーム編集',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: gameList == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF18204E),
              ),
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
                        title: 'ゲーム名編集',
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
