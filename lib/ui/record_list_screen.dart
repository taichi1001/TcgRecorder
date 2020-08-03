import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class RecordListScreen extends StatelessWidget {
  const RecordListScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('データ一覧'),
      ),
      body: Center(child: Text('一覧'),),
    );
  }
}