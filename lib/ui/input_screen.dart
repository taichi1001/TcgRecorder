import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/model/deck_model.dart';
import 'package:tcg_recorder/model/game_model.dart';
import 'package:tcg_recorder/model/record_model.dart';
import 'package:tcg_recorder/model/tag_model.dart';
import 'package:tcg_recorder/ui/parts/input_game_row.dart';
import 'package:tcg_recorder/ui/parts/input_tag_row.dart';
import 'package:tcg_recorder/ui/parts/input_use_deck_row.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('データ入力'),
      ),
      body: const Center(
        child: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _selectedOpponentDeck =
        context.select((DeckModel model) => model.selectedOpponentDeck);
    final _opponentDeckController = _selectedOpponentDeck != null
        ? TextEditingController(text: _selectedOpponentDeck.deck)
        : TextEditingController();

    final column = Column(
      children: [
        const InputGameRow(),
        const InputTagRow(),
        const InputUseDeckRow(),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.settings),
            border: OutlineInputBorder(),
            labelText: '相手デッキ',
            hintText: 'Enter 相手デッキ',
          ),
          autovalidate: false,
          controller: _opponentDeckController,
          onFieldSubmitted: (String value) {
            context.read<DeckModel>().selectedOpponentDeckChangeToString(value);
          },
          validator: (value) {
            if (value == null) {
              return '入力されていません';
            }
            return null;
          },
        ),
        const _ShowOpponetDeckModalPicker(),
        const _OkButton(),
      ],
    );
    return Form(
      key: _formKey,
      child: column,
    );
  }
}



class _ShowOpponetDeckModalPicker extends StatelessWidget {
  const _ShowOpponetDeckModalPicker({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final deckModel = Provider.of<DeckModel>(context, listen: true);
    final selectedGame =
        context.select((GameModel model) => model.selectedGame);
    if (selectedGame != null) {
      deckModel.getGameDeckList(selectedGame.gameId);
    }
    return RaisedButton(
      onPressed: deckModel.gameDeckList.length == 1 || selectedGame == null
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
                        children: deckModel.gameDeckList
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

class _OkButton extends StatelessWidget {
  const _OkButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final deckModel = Provider.of<DeckModel>(context, listen: true);
    final _selectedGame =
        context.select((GameModel model) => model.selectedGame);
    final _selectedTag = context.select((TagModel model) => model.selectedTag);
    final _selectedUseDeck =
        context.select((DeckModel model) => model.selectedUseDeck);
    final _selectedOpponentDeck =
        context.select((DeckModel model) => model.selectedOpponentDeck);
    final _selectedFirstOrSeconde =
        context.select((RecordModel model) => model.firstOrSecond);
    final _selectedWinOrLose =
        context.select((RecordModel model) => model.winOrLose);

    if (_selectedGame != null) {
      deckModel.getGameDeckList(_selectedGame.gameId);
    }
    return RaisedButton(
      onPressed: _selectedGame == null ||
              _selectedUseDeck == null ||
              _selectedOpponentDeck == null
          ? null
          : () {
              context.read<RecordModel>().add(
                    Record(
                      date: DateTime.now(),
                      gameId: _selectedGame.gameId,
                      tagId: _selectedTag == null ? null : _selectedTag.tagId,
                      myDeckId: _selectedUseDeck.deckId,
                      opponentDeckId: _selectedOpponentDeck.deckId,
                      firstOrSecond: _selectedFirstOrSeconde,
                      winOrLose: _selectedWinOrLose,
                      memo: null,
                    ),
                  );
              context.read<TagModel>().selectedTagChangeToString('');
              context.read<DeckModel>().selectedUseDeckChangeToString('');
              context.read<DeckModel>().selectedOpponentDeckChangeToString('');
            },
      child: const Text('OK'),
    );
  }
}
