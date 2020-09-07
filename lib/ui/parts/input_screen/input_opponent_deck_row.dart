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
      child: Stack(
        alignment: Alignment.centerRight,
        children: const [
          _InputOpponentDeckTextField(),
          _ShowCupertinoPickerButton(),
        ],
      ),
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
      decoration: const InputDecoration(
        // icon: Icon(Icons.settings),
        border: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(10.0),
            ),
        labelText: '相手デッキ',
        hintText: 'Enter 相手デッキ',
      ),
      controller:
          context.select((TextEditingControllerModel model) => model.opponentDeckController),
      onChanged: (String value) {
        context.read<DeckModel>().changeSelectedOpponentDeckUsingString(value);
      },
    );
  }
}

class _ShowCupertinoPickerButton extends StatelessWidget {
  const _ShowCupertinoPickerButton({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_drop_down),
      onPressed: () {
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
      },
    );
  }
}
