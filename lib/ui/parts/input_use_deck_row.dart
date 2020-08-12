import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/deck_model.dart';
import 'package:tcg_recorder/model/game_model.dart';
import 'package:tcg_recorder/model/text_editing_controller_model.dart';

class InputUseDeckRow extends StatelessWidget {
  const InputUseDeckRow({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
            height: 100,
            width: _size.width * (70 / 100),
            child: const _InputUseDeckTextField()),
        Container(
            height: 100,
            width: _size.width * (70 / 100),
            child: const _ShowUseDeckModalPicker()),
      ],
    );
  }
}

class _InputUseDeckTextField extends StatelessWidget {
  const _InputUseDeckTextField({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _selectedUseDeck =
        context.select((DeckModel model) => model.selectedUseDeck);

    context.select((TextEditingControllerModel model) =>
        model.useDeckController = _selectedUseDeck != null
            ? TextEditingController(text: _selectedUseDeck.deck)
            : TextEditingController());

    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.settings),
        border: OutlineInputBorder(),
        labelText: '使用デッキ',
        hintText: 'Enter 使用デッキ',
      ),
      autovalidate: false,
      controller: context.select(
          (TextEditingControllerModel model) => model.useDeckController),
      onFieldSubmitted: (String value) {
        context.read<DeckModel>().selectedUseDeckChangeToString(value);
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

class _ShowUseDeckModalPicker extends StatelessWidget {
  const _ShowUseDeckModalPicker({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _gameDeckList =
        context.select((DeckModel model) => model.gameDeckList);
    final deckModel = Provider.of<DeckModel>(context, listen: false);
    final selectedGame =
        context.select((GameModel model) => model.selectedGame);
    if (selectedGame != null) {
      deckModel.getGameDeckList(selectedGame.gameId);
    }
    return RaisedButton(
      onPressed: _gameDeckList.length == 1 || selectedGame == null
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
                        children: _gameDeckList
                            .map((deck) => Text(deck.deck))
                            .toList(),
                        onSelectedItemChanged:
                            deckModel.selectedUseDeckChangeToIndex,
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
