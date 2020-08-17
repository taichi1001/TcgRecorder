import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/tag_model.dart';
import 'package:tcg_recorder/model/game_model.dart';
import 'package:tcg_recorder/model/text_editing_controller_model.dart';

class InputTagRow extends StatelessWidget {
  const InputTagRow({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: 100,
            width: _size.width * (70 / 100),
            padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: const _InputTagTextField()),
        Container(
            height: 80,
            width: _size.width * (15 / 100),
            padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: const _ShowTagModalPicker()),
      ],
    );
  }
}

class _InputTagTextField extends StatelessWidget {
  const _InputTagTextField({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _selectedTag = context.select((TagModel model) => model.selectedTag);
    final _textModel =
        Provider.of<TextEditingControllerModel>(context, listen: false);
    _textModel.setTagController(_selectedTag != null
        ? TextEditingController(text: _selectedTag.tag)
        : TextEditingController());

    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.settings),
        border: OutlineInputBorder(),
        labelText: 'タグ名',
        hintText: 'Enter タグ名',
      ),
      autovalidate: false,
      controller: context
          .select((TextEditingControllerModel model) => model.tagController),
      onFieldSubmitted: (String value) {
        context.read<TagModel>().selectedTagChangeToString(value);
      },
      validator: (value) {
        if (value == null) {
          return '入力されていません';
        }
        return null;
      },
    );
  }
}

class _ShowTagModalPicker extends StatelessWidget {
  const _ShowTagModalPicker({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _gameTagList = context.select((TagModel model) => model.gameTagList);
    final tagModel = Provider.of<TagModel>(context, listen: false);
    final selectedGame =
        context.select((GameModel model) => model.selectedGame);
    if (selectedGame != null) {
      tagModel.getGameTagList(selectedGame.gameId);
    }
    return RaisedButton(
      onPressed: _gameTagList.length == 1 || selectedGame == null
          ? null
          : () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CupertinoPicker(
                        itemExtent: 40,
                        children:
                            _gameTagList.map((tag) => Text(tag.tag)).toList(),
                        onSelectedItemChanged:
                            tagModel.selectedTagChangeToIndex,
                      ),
                    ),
                  );
                },
              );
            },
      child: const Text('選択'),
    );
  }
}
