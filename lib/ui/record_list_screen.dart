import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/model/deck_model.dart';
import 'package:tcg_recorder/model/game_model.dart';
import 'package:tcg_recorder/model/record_model.dart';
import 'package:tcg_recorder/model/tag_model.dart';
import 'package:tcg_recorder/ui/record_detail_view.dart';

class RecordListScreen extends StatelessWidget {
  const RecordListScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Records'),
      ),
      body: const RecordListView(),
    );
  }
}

class RecordListView extends StatelessWidget {
  const RecordListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recordList =
        context.select((RecordModel model) => model.allRecordList);
    if (recordList.isEmpty) {
      return const Center(child: Text('No Items'));
    }

    return ListView.builder(
        itemCount: recordList.length,
        itemBuilder: (BuildContext context, int index) =>
            RecordListTile(record: recordList[index]));
  }
}

class RecordListTile extends StatelessWidget {
  const RecordListTile({
    this.record,
    Key key,
  }) : super(key: key);
  final Record record;

  @override
  Widget build(BuildContext context) {
    context.read<GameModel>().findGameFromRecord(record);
    context.read<TagModel>().findTagFromRecord(record);
    context.read<DeckModel>().findMyDeckFromRecord(record);
    context.read<DeckModel>().findOpponentDeckFromRecord(record);
    return Card(
      child: ListTile(
        title: Text(record.game),
        subtitle: Text(
            '${record.date.year}年${record.date.month}月${record.date.day}日${record.date.hour}:${record.date.minute}'),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RecordDetailView(record: record),
            ),
          );
        },
      ),
    );
  }
}
