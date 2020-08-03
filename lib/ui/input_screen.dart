import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class InputScreen extends StatelessWidget {
  const InputScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('データ入力'),
      ),
      body: Center(child: Text('入力'),),
    );
  }
}