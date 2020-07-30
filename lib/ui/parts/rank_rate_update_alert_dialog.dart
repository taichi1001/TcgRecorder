import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/model/record_contents_model.dart';

class RankRateUpdateAlertDialog extends StatelessWidget {
  const RankRateUpdateAlertDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> _controllers = [];
    return Consumer2<Record, RecordContentsModel>(
      builder: (context, record, recordContentsModel, _) {
        for (final rankRate in recordContentsModel.recordRankRateList) {
          final _controller =
              TextEditingController(text: rankRate.rate.toString());
          _controllers.add(_controller);
        }

        return AlertDialog(
          title: const Text('レート変更'),
          content: SingleChildScrollView(
            child: Consumer<Record>(
              builder: (context, record, _) => Container(
                height: 50.0 * record.numberPeople,
                width: 150.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: record.numberPeople,
                  itemBuilder: (BuildContext context, int index) {
                    return TextField(
                      controller: _controllers[index],
                    );
                  },
                ),
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: const Text('OK'),
              onPressed: () async {
                await recordContentsModel.updateRankRate(_controllers);
                _controllers = [];
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
