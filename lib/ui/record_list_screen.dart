import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/model/deck_model.dart';
import 'package:tcg_recorder/model/record_model.dart';
import 'package:tcg_recorder/model/tag_model.dart';
import 'package:tcg_recorder/ui/record_detail_view.dart';

class RecordListScreen extends StatelessWidget {
  const RecordListScreen({
    Key key,
    this.game,
  }) : super(key: key);
  final Game game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.game),
      ),
      body: RecordListView(
        game: game,
      ),
    );
  }
}

class RecordListView extends StatelessWidget {
  const RecordListView({
    Key key,
    this.game,
  }) : super(key: key);
  final Game game;

  @override
  Widget build(BuildContext context) {
    final recordList =
        context.select((RecordModel model) => model.gameRecordList(game));
    return recordList.isEmpty
        ? const Center(child: Text('No Items'))
        : ListView.builder(
            itemCount: recordList.length,
            itemBuilder: (BuildContext context, int index) {
              context.read<DeckModel>().findMyDeckFromRecord(recordList[index]);
              context
                  .read<DeckModel>()
                  .findOpponentDeckFromRecord(recordList[index]);
              return RecordListTile(
                record: recordList[index],
              );
            },
          );
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
    return Card(
      color: record.winOrLose == 1 ? Colors.red : Colors.blue,
      child: ListTile(
        title: Text('使用デッキ：${record.myDeck}\n 対戦デッキ：${record.opponentDeck}'),
        subtitle: Text(
          '${record.date.year}年${record.date.month}月${record.date.day}日${record.date.hour}:${record.date.minute}',
        ),
        trailing: record.winOrLose == 1
            ? const Icon(Icons.radio_button_unchecked)
            : const Icon(Icons.close),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                context.watch<TagModel>().findTagUsingRecord(record);
                return RecordDetailView(record: record);
              },
            ),
          );
        },
      ),
    );
  }
}
