import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: Center(child: Text('設定'),),
    );
  }
}