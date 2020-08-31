import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/deck_model.dart';
import 'package:tcg_recorder/model/text_editing_controller_model.dart';

class InputUseDeckRow extends StatelessWidget {
  const InputUseDeckRow({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
        height: _size.height * (10 / 100),
        width: _size.width * (80 / 100),
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: const _InputUseDeckTextField());
  }
}

class _InputUseDeckTextField extends StatelessWidget {
  const _InputUseDeckTextField({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _selectedUseDeck = context.select((DeckModel model) => model.selectedUseDeck);
    Provider.of<TextEditingControllerModel>(context, listen: false).setUseDeckController(
        _selectedUseDeck != null
            ? TextEditingController(text: _selectedUseDeck.deck)
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
        labelText: '使用デッキ',
        hintText: 'Enter 使用デッキ',
        suffixIcon: IconButton(
          icon: const Icon(Icons.arrow_drop_down),
          onPressed: () {
            _showCupertinoPicker(context);
          },
        ),
      ),
      autovalidate: false,
      controller: context.select((TextEditingControllerModel model) => model.useDeckController),
      onFieldSubmitted: (String value) {
        context.read<DeckModel>().changeSelectedUseDeckUsingString(value);
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
                .select((DeckModel model) => model.gameDeckList)
                .map((deck) => Text(deck.deck))
                .toList(),
            onSelectedItemChanged: (int index) =>
                context.read<DeckModel>().changeSelectedUseDeckUsingIndex(index),
          ),
        ),
      );
    },
  );
}
