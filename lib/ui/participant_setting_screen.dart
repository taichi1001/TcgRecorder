import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/entity/util.dart';
import 'package:tcg_recorder/model/record_contents_model.dart';
import 'package:tcg_recorder/model/record_model.dart';
import 'package:tcg_recorder/ui/record_contents_screen.dart';

class ParticipantSettingScreen extends StatelessWidget {
  const ParticipantSettingScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> _controllers = [];
    final recordModel = Provider.of<RecordModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Consumer<Record>(
            builder: (context, record, _) => Text(record.title)),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text('モード'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _SettingMode(),
              )
            ],
          ),
          Row(
            children: <Widget>[
              const Text('人数'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _SettingNumberPeople(),
              )
            ],
          ),
          SingleChildScrollView(
            child: _InputName(controllers: _controllers),
          ),
          FlatButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          Consumer2<Record, RecordContentsModel>(
            builder: (context, record, recordContentsModel, child) =>
                FlatButton(
              child: const Text('OK'),
              onPressed: () async {
                await recordContentsModel.nameModel.setNewName(_controllers);
                await recordContentsModel.initRankRate();
                recordContentsModel.calcScore();
                recordModel.notify();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider.value(value: record),
                        ChangeNotifierProvider.value(
                            value: recordContentsModel),
                        ChangeNotifierProvider.value(
                            value: recordContentsModel.nameModel),
                      ],
                      child: const RecordContentsScreen(),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _InputName extends StatelessWidget {
  const _InputName({
    Key key,
    @required List<TextEditingController> controllers,
  })  : _controllers = controllers,
        super(key: key);

  final List<TextEditingController> _controllers;

  @override
  Widget build(BuildContext context) {
    return Consumer<Record>(
      builder: (context, record, _) => Container(
        // height: 50.0 * record.numberPeople,
        width: 150.0,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: record.numberPeople,
          itemBuilder: (BuildContext context, int index) {
            _controllers.add(TextEditingController());
            return TextField(
              controller: _controllers[index],
            );
          },
        ),
      ),
    );
  }
}

class _SettingNumberPeople extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecordModel>(context, listen: false);
    return Consumer<Record>(
      builder: (context, record, _) => DropdownButton<String>(
        value: record.numberPeople.toString(),
        icon: const Icon(Icons.arrow_downward),
        iconSize: 18,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String newValue) {
          record.changeNumberPeople(int.parse(newValue));
          model.update(record);
        },
        items: rangeNumberCount.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

class _SettingMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecordModel>(context, listen: false);
    return Consumer<Record>(
      builder: (context, record, _) => DropdownButton<String>(
        value: record.mode,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 18,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String newValue) {
          record.changeMode(newValue);
          model.update(record);
        },
        items: modeList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
