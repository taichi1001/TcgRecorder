import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/entity/deck.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/entity/tag.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/model/deck_model.dart';
import 'package:tcg_recorder/model/game_model.dart';
import 'package:tcg_recorder/model/record_model.dart';
import 'package:tcg_recorder/model/tag_model.dart';

class OkButton extends StatelessWidget {
  const OkButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _deckModel = Provider.of<DeckModel>(context, listen: false);
    final _tagModel = Provider.of<TagModel>(context, listen: false);
    final _selectedGame = context.select((GameModel model) => model.selectedGame);
    final _selectedTag = context.select((TagModel model) => model.selectedTag);
    final _selectedUseDeck = context.select((DeckModel model) => model.selectedUseDeck);
    final _selectedOpponentDeck = context.select((DeckModel model) => model.selectedOpponentDeck);
    final _selectedFirstOrSecond = context.select((RecordModel model) => model.firstOrSecond);
    final _selectedWinOrLose = context.select((RecordModel model) => model.winOrLose);

    if (_selectedGame != null) {
      _deckModel.getGameDeckList(_selectedGame.gameId);
      _tagModel.getGameTagList(_selectedGame.gameId);
    } else {
      _deckModel.gameDeckList = [Deck(deck: '')];
      _tagModel.gameTagList = [Tag(tag: '')];
    }
    return Container(
      height: 80.h,
      width: 300.w,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: RaisedButton(
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: _selectedGame.game == '' ||
                _selectedUseDeck == null ||
                _selectedOpponentDeck == null
            ? null
            : () async {
                await showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(L10n.of(context).confirmation),
                      content: Text(L10n.of(context).confirmationText),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(L10n.of(context).cancel),
                        ),
                        FlatButton(
                          onPressed: () async {
                            _selectedTag ??
                                context.read<TagModel>().changeSelectedTagUsingString('none');
                            await context.read<GameModel>().addSelectedGame();
                            await context.read<TagModel>().addSelectedTag(_selectedGame);
                            await context.read<DeckModel>().addSelectedUseDeck(_selectedGame);
                            await context.read<DeckModel>().addSelectedOpponentDeck(_selectedGame);
                            await context.read<RecordModel>().add(
                                  Record(
                                    date: DateTime.now(),
                                    gameId: _selectedGame.gameId,
                                    tagId: _selectedTag.tagId,
                                    myDeckId: _selectedUseDeck.deckId,
                                    opponentDeckId: _selectedOpponentDeck.deckId,
                                    firstOrSecond: _selectedFirstOrSecond,
                                    winOrLose: _selectedWinOrLose,
                                  ),
                                );
                            Navigator.pop(context);
                          },
                          child: Text(L10n.of(context).ok),
                        ),
                      ],
                    );
                  },
                );
              },
        child: Text(
          L10n.of(context).submit,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
