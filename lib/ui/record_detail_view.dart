import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/record.dart';

class RecordDetailView extends StatelessWidget {
  const RecordDetailView({this.record, Key key}) : super(key: key);
  final Record record;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('詳細'),
      ),
      body: Center(
        child: Text('タグ名：${record.tag}\nデッキ名：${record.myDeck}'),
      ),
    );
  }
}
