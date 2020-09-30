import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/model/deck_model.dart';
import 'package:tcg_recorder/model/record_model.dart';
import 'package:tcg_recorder/model/tag_model.dart';
import 'package:tcg_recorder/ui/record_detail_view.dart';

class RecordListView extends StatelessWidget {
  const RecordListView({
    Key key,
    this.game,
  }) : super(key: key);
  final Game game;

  @override
  Widget build(BuildContext context) {
    final recordList = context.select((RecordModel model) => model.gameRecordList(game));
    return recordList.isEmpty
        ? const Center(child: Text('No Items'))
        : ListView.builder(
            itemCount: recordList.length,
            itemBuilder: (BuildContext context, int index) {
              context.read<DeckModel>().findMyDeckFromRecord(recordList[index]);
              context.read<DeckModel>().findOpponentDeckFromRecord(recordList[index]);
              return _RecordListTile(
                record: recordList[index],
              );
            },
          );
  }
}

class _RecordListTile extends StatelessWidget {
  const _RecordListTile({
    this.record,
    Key key,
  }) : super(key: key);
  final Record record;

  @override
  Widget build(BuildContext context) {
    final them = Theme.of(context);
    return Card(
      child: Slidable(
        actionPane: const SlidableScrollActionPane(),
        key: ObjectKey(record),
        secondaryActions: [
          IconSlideAction(
            caption: '削除',
            color: Colors.red,
            icon: Icons.remove,
            onTap: () {
              context.read<RecordModel>().remove(record);
            },
          ),
        ],
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: const [0.02, 0.02],
              colors: [if (record.winOrLose == 1) Colors.red else Colors.blue, them.canvasColor],
            ),
          ),
          child: ListTile(
            title: Text('使用デッキ：${record.myDeck}\n 対戦デッキ：${record.opponentDeck}'),
            subtitle: Text(
              '${record.date.year}年${record.date.month}月${record.date.day}日${record.date.hour}:${record.date.minute}',
            ),
            trailing: record.winOrLose == 1
                ? const Icon(
                    Icons.radio_button_unchecked,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.close,
                    color: Colors.blue,
                  ),
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
        ),
      ),
    );
  }
}
