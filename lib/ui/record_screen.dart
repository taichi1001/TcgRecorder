import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/record_model.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/entity/tag.dart';
import 'package:tcg_recorder/model/tag_model.dart';
import 'package:tcg_recorder/ui/parts/record_list_view.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Records'),
        actions: const <Widget>[SettingButton()],
      ),
      body: Column(
        children: <Widget>[
          const SelectTag(),
           Container(
               height: 300,
               child: const RecordListView()),
        ],
      ),
      floatingActionButton: const AddTodoButton(),
    );
  }
}

class SettingButton extends StatelessWidget {
  const SettingButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Text('a')));
      },
    );
  }
}

class SelectTag extends StatelessWidget {
  const SelectTag({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recordModel = Provider.of<RecordModel>(context, listen: true);
    final tagModel = Provider.of<TagModel>(context, listen: true);

    return DropdownButton<String>(
      value: recordModel.selectedTag,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 18,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String value) {
        recordModel.changeSelectedTag(value, tagModel);
      },
      items: tagModel.recordScreenTagList.map<DropdownMenuItem<String>>((Tag tag) {
        return DropdownMenuItem<String>(
          value: tag.tag,
          child: Text(tag.tag),
        );
      }).toList(),
    );
  }
}

class AddTodoButton extends StatelessWidget {
  const AddTodoButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const AddTodoDialog();
            });
      },
    );
  }
}

class AddTodoDialog extends StatelessWidget {
  const AddTodoDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recordModel = Provider.of<RecordModel>(context, listen: true);
    final titleTextEditingController = TextEditingController();
    return AlertDialog(
      title: const Text('新規作成'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              controller: titleTextEditingController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
          ],
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
              recordModel.add(Record(
                  date: DateTime.now(),
                  title: titleTextEditingController.text));
              Navigator.pop(context);
            }),
      ],
    );
  }
}
