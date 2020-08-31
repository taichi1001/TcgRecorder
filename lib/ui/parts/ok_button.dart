import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/model/deck_model.dart';
import 'package:tcg_recorder/model/game_model.dart';
import 'package:tcg_recorder/model/record_model.dart';
import 'package:tcg_recorder/model/tag_model.dart';

class OkButton extends StatelessWidget {
  const OkButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _deckModel = Provider.of<DeckModel>(context, listen: false);
    final _selectedGame = context.select((GameModel model) => model.selectedGame);
    final _selectedTag = context.select((TagModel model) => model.selectedTag);
    final _selectedUseDeck = context.select((DeckModel model) => model.selectedUseDeck);
    final _selectedOpponentDeck = context.select((DeckModel model) => model.selectedOpponentDeck);
    final _selectedFirstOrSecond = context.select((RecordModel model) => model.firstOrSecond);
    final _selectedWinOrLose = context.select((RecordModel model) => model.winOrLose);

    if (_selectedGame != null) {
      _deckModel.getGameDeckList(_selectedGame.gameId);
    }
    return Container(
      height: _size.height * (10 / 100),
      width: _size.width * (80 / 100),
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: RaisedButton(
        onPressed:
            _selectedGame == null || _selectedUseDeck == null || _selectedOpponentDeck == null
                ? null
                : () async {
                    await context.read<GameModel>().addSelectedGame();
                    await context.read<TagModel>().addSelectedTag();
                    await context.read<DeckModel>().addSelectedUseDeck();
                    await context.read<DeckModel>().addSelectedOpponentDeck();
                    await context.read<RecordModel>().add(
                          Record(
                            date: DateTime.now(),
                            gameId: _selectedGame.gameId,
                            tagId: _selectedTag == null ? null : _selectedTag.tagId,
                            myDeckId: _selectedUseDeck.deckId,
                            opponentDeckId: _selectedOpponentDeck.deckId,
                            firstOrSecond: _selectedFirstOrSecond,
                            winOrLose: _selectedWinOrLose,
                            memo: null,
                          ),
                        );
                    context.read<TagModel>().changeSelectedTagUsingString('');
                    context.read<DeckModel>().changeSelectedUseDeckUsingString('');
                    context.read<DeckModel>().changeSelectedOpponentDeckUsingString('');
                  },
        child: const Text('OK'),
      ),
    );
  }
}
