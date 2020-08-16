import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/deck_model.dart';
import 'package:tcg_recorder/model/game_model.dart';
import 'package:tcg_recorder/model/text_editing_controller_model.dart';

class InputOpponentDeckRow extends StatelessWidget {
  const InputOpponentDeckRow({Key key}) : super(key: key);
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
            child: const _InputOpponentDeckTextField()),
        Container(
            height: 80,
            width: _size.width * (15 / 100),
            padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: const _ShowOpponentDeckModalPicker()),
      ],
    );
  }
}

class _InputOpponentDeckTextField extends StatelessWidget {
  const _InputOpponentDeckTextField({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _selectedOpponentDeck =
        context.select((DeckModel model) => model.selectedOpponentDeck);

    // context.select((TextEditingControllerModel model) =>
    //     model.opponentDeckController = _selectedOpponentDeck != null
    //         ? TextEditingController(text: _selectedOpponentDeck.deck)
    //         : TextEditingController());

    final _textModel =
        Provider.of<TextEditingControllerModel>(context, listen: false);
    _textModel.setOpponentDeckController(_selectedOpponentDeck != null
        ? TextEditingController(text: _selectedOpponentDeck.deck)
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
          (TextEditingControllerModel model) => model.opponentDeckController),
      onFieldSubmitted: (String value) {
        context.read<DeckModel>().selectedOpponentDeckChangeToString(value);
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

class _ShowOpponentDeckModalPicker extends StatelessWidget {
  const _ShowOpponentDeckModalPicker({Key key}) : super(key: key);
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
                            deckModel.selectedOpponentDeckChangeToIndex,
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
