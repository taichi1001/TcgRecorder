import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/record_model.dart';
import 'package:tcg_recorder/model/record_contents_model.dart';
import 'package:tcg_recorder/ui/parts/record_list_tile.dart';

class RecordListView extends StatelessWidget {
  const RecordListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecordModel>(context, listen: true);
    if (model.toDisplayRecord.isEmpty) {
      return const Center(child: Text('No Items'));
    }

    return ListView.builder(
      itemCount: model.toDisplayRecord.length,
      itemBuilder: (BuildContext context, int index) {
        final recordContentsModel =
            RecordContentsModel(record: model.toDisplayRecord[index]);
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: model.toDisplayRecord[index]),
            ChangeNotifierProvider.value(
              value: recordContentsModel,
            ),
          ],
          child: const RecordListTile(),
        );
      },
    );
  }
}
