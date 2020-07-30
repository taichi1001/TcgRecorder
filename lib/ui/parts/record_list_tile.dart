import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/model/record_contents_model.dart';
import 'package:tcg_recorder/model/record_model.dart';
import 'package:tcg_recorder/ui/participant_setting_screen.dart';
import 'package:tcg_recorder/ui/record_contents_screen.dart';
import 'package:tcg_recorder/ui/setting_tag_screen.dart';

class RecordListTile extends StatelessWidget {
  const RecordListTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Consumer2<Record, RecordContentsModel>(
        builder: (context, record, recordContentsModel, _) => ListTile(
          leading: const _CheckBoxButton(),
          title: Text(record.title),
          subtitle: Text(
              '${record.date.year}年${record.date.month}月${record.date.day}日${record.date.hour}:${record.date.minute}'),
          trailing: Container(
            width: 180,
            child: Row(
              children: const <Widget>[
                _TagButton(),
                _RemoveButton(),
              ],
            ),
          ),
          onTap: () async {
            if (recordContentsModel.nameModel.recordNameList.isEmpty) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider.value(value: record),
                      ChangeNotifierProvider.value(value: recordContentsModel),
                    ],
                    child: const ParticipantSettingScreen(),
                  ),
                ),
              );
            } else {
              await recordContentsModel.initRankRate();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    recordContentsModel.fetchAll();
                    return MultiProvider(
                      providers: [
                        ChangeNotifierProvider.value(value: record),
                        ChangeNotifierProvider.value(
                            value: recordContentsModel),
                        ChangeNotifierProvider.value(
                            value: recordContentsModel.nameModel),
                      ],
                      child: const RecordContentsScreen(),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _CheckBoxButton extends StatelessWidget {
  const _CheckBoxButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecordModel>(context, listen: false);
    return Consumer<Record>(
      builder: (context, record, _) => FlatButton(
        child: record.isEdit
            ? const Icon(Icons.check_box)
            : const Icon(Icons.check_box_outline_blank),
        onPressed: () {
          model.toggleIsDone(record);
        },
      ),
    );
  }
}

class _TagButton extends StatelessWidget {
  const _TagButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Record>(
      builder: (context, record, child) => FlatButton(
        child: const Icon(Icons.bookmark_border),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider.value(value: record),
                ],
                child: const SettingTagScreen(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RemoveButton extends StatelessWidget {
  const _RemoveButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecordModel>(context, listen: false);
    return Consumer<Record>(
      builder: (context, record, child) => FlatButton(
        child: const Icon(Icons.delete_forever),
        onPressed: () {
          model.removeRelatedData(record);
        },
      ),
    );
  }
}
