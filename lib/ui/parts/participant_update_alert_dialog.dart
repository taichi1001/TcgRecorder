import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/model/name_model.dart';

class ParticipantUpdateAlertDialog extends StatelessWidget {
  const ParticipantUpdateAlertDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> _controllers = [];
    final List<TextEditingController> _controllersTmp = [];

    return Consumer2<Record, NameModel>(
      builder: (context, record, nameModel, _) {
        for (final name in nameModel.recordNameList) {
          final _controller = TextEditingController(text: name.name);
          final _controllerTmp = TextEditingController(text: name.name);
          _controllers.add(_controller);
          _controllersTmp.add(_controllerTmp);
        }

        return AlertDialog(
          title: const Text('名前変更'),
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
              onPressed: () {
                nameModel.updateRecordName(_controllers, _controllersTmp);
                if (!nameModel.isUpdate) {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) =>
                          const Text('既に登録されている名前には変更できません'));
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
