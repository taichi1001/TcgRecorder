import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/model/record_contents_model.dart';

class InputRecordContentsScreen extends StatelessWidget {
  const InputRecordContentsScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> _controllers = [];
    final _formKey = GlobalKey<FormState>();

    return Consumer2<Record, RecordContentsModel>(
      builder: (context, record, recordContentsModel, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('New Record'),
          ),
          body: Form(
            key: _formKey,
            child: Container(
              height: 400,
              width: 300,
              child: Column(
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: record.numberPeople,
                    itemBuilder: (BuildContext context, int index) {
                      _controllers.add(TextEditingController());
                      return Row(
                        children: <Widget>[
                          Text(recordContentsModel
                              .nameModel.recordNameList[index].name),
                          Container(
                            width: 200,
                            child: TextFormField(
                              controller: _controllers[index],
                              validator: (value) {
                                if (value.isEmpty) {
                                  return '値を入力してください';
                                } else if (int.tryParse(value) is! int) {
                                  return '数字を入力してください';
                                } else if (int.tryParse(value) >
                                        record.numberPeople ||
                                    int.tryParse(value) < 1) {
                                  return '範囲内の値を入力してください';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  _OkButton(
                    controllers: _controllers,
                    formKey: _formKey,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _OkButton extends StatelessWidget {
  final List<TextEditingController> controllers;
  final GlobalKey<FormState> formKey;

  const _OkButton({
    @required this.controllers,
    @required this.formKey,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordContentsModel>(
      builder: (context, recordContentsModel, _) => RaisedButton(
        child: const Text('OK'),
        color: Colors.amber[800],
        textColor: Colors.white,
        onPressed: () async{
          if (formKey.currentState.validate()) {
            await recordContentsModel.addNewRecordContents(controllers);
            formKey.currentState.save();
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
