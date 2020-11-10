import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/model/deck_model.dart';
import 'package:tcg_recorder/model/graph_model.dart';
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
        ? Center(child: Text(L10n.of(context).noItem))
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
    final slidableController = SlidableController();
    return Card(
      child: Slidable(
        actionPane: const SlidableScrollActionPane(),
        key: ObjectKey(record),
        controller: slidableController,
        secondaryActions: [
          IconSlideAction(
            caption: L10n.of(context).delete,
            color: Colors.red,
            icon: Icons.delete,
            onTap: () async {
              await context.read<RecordModel>().remove(record);
              await context.read<GraphModel>().fetchAll();
            },
          ),
        ],
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: const [0.02, 0.02],
              colors: [
                if (record.winOrLose) Colors.redAccent else Colors.indigoAccent,
                Colors.white
              ],
            ),
          ),
          child: ListTile(
            title: Text(L10n.of(context).recordDeck(record.myDeck, record.opponentDeck)),
            subtitle: Text(
              '${record.date.year}年${record.date.month}月${record.date.day}日${record.date.hour}:${record.date.minute}',
            ),
            trailing: record.winOrLose
                ? const Icon(
                    Icons.radio_button_unchecked,
                    color: Colors.redAccent,
                  )
                : const Icon(
                    Icons.close,
                    color: Colors.indigoAccent,
                  ),
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) {
              //       context.watch<TagModel>().findTagUsingRecord(record);
              //       return RecordDetailView(record: record);
              //     },
              //   ),
              // );
            },
          ),
        ),
      ),
    );
  }
}
