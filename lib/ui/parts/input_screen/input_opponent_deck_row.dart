import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/deck_model.dart';
import 'package:tcg_recorder/model/text_editing_controller_model.dart';

class InputOpponentDeckRow extends StatelessWidget {
  const InputOpponentDeckRow({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      height: _size.height * (10 / 100),
      width: _size.width * (80 / 100),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: const _InputOpponentDeckTextField(),
    );
  }
}

class _InputOpponentDeckTextField extends StatelessWidget {
  const _InputOpponentDeckTextField({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _selectedOpponentDeck = context.select((DeckModel model) => model.selectedOpponentDeck);
    Provider.of<TextEditingControllerModel>(context, listen: false).setOpponentDeckController(
        _selectedOpponentDeck != null
            ? TextEditingController(text: _selectedOpponentDeck.deck)
            : TextEditingController());

    return TextFormField(
      // style: const TextStyle(
      //   fontSize: 13,
      // ),
      decoration: InputDecoration(
        // icon: Icon(Icons.settings),
        border: const OutlineInputBorder(
            // borderRadius: BorderRadius.circular(10.0),
            ),
        labelText: '相手デッキ',
        hintText: 'Enter 相手デッキ',
        suffixIcon: IconButton(
          icon: const Icon(Icons.arrow_drop_down),
          onPressed: () {
            _showCupertinoPicker(context);
          },
        ),
      ),
      controller:
          context.select((TextEditingControllerModel model) => model.opponentDeckController),
      onFieldSubmitted: (String value) {
        context.read<DeckModel>().changeSelectedOpponentDeckUsingString(value);
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
            onSelectedItemChanged: (int index) =>
                context.read<DeckModel>().changeSelectedOpponentDeckUsingIndex(index),
            children: context
                .select((DeckModel model) => model.gameDeckList)
                .map((deck) => Text(deck.deck))
                .toList(),
          ),
        ),
      );
    },
  );
}
