import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

class OtherView extends HookConsumerWidget {
  const OtherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('その他'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('その他'),
            tiles: [
              SettingsTile(
                title: const Text('言語'),
                leading: const Icon(Icons.language),
                onPressed: (context) {},
              ),
              SettingsTile(
                title: const Text('言語'),
                leading: const Icon(Icons.language),
                onPressed: (context) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
