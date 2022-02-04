import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tcg_manager/helper/db_helper.dart';

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
