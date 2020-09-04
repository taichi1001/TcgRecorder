import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/tag_model.dart';
import 'package:tcg_recorder/model/text_editing_controller_model.dart';

class InputTagRow extends StatelessWidget {
  const InputTagRow({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      height: _size.height * (10 / 100),
      width: _size.width * (80 / 100),
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: const _InputTagTextField(),
    );
  }
}

class _InputTagTextField extends StatelessWidget {
  const _InputTagTextField({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _selectedTag = context.select((TagModel model) => model.selectedTag);
    Provider.of<TextEditingControllerModel>(context, listen: true).setTagController(
        _selectedTag != null
            ? TextEditingController(text: _selectedTag.tag)
            : TextEditingController());

    return TextFormField(
      // style: const TextStyle(
      //   fontSize: 13,
      // ),
      decoration: InputDecoration(
        // icon: Icon(Icons.settings),
        border: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(10.0),
            ),
        labelText: 'タグ名',
        hintText: 'Enter タグ名',
        suffixIcon: IconButton(
          icon: const Icon(Icons.arrow_drop_down),
          onPressed: () {
            _showCupertinoPicker(context);
          },
        ),
      ),
      autovalidate: false,
      controller: context.select((TextEditingControllerModel model) => model.tagController),
      onFieldSubmitted: (String value) {
        context.read<TagModel>().changeSelectedTagUsingString(value);
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

void _showCupertinoPicker(BuildContext context) {
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
            children: context
                .select((TagModel model) => model.gameTagList)
                .map((tag) => Text(tag.tag))
                .toList(),
            onSelectedItemChanged: (int index) =>
                context.read<TagModel>().changeSelectedTagUsingIndex(index),
          ),
        ),
      );
    },
  );
}
