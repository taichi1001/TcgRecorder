import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/deck_model.dart';
import 'package:tcg_recorder/model/game_model.dart';
import 'package:tcg_recorder/model/tag_model.dart';

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
    final _selectedGame =
        context.select((GameModel model) => model.selectedGame);
    final _selectedTag = context.select((TagModel model) => model.selectedTag);
    final _selectedUseDeck =
        context.select((DeckModel model) => model.selectedUseDeck);
    final _selectedOpponentDeck =
        context.select((DeckModel model) => model.selectedOpponentDeck);

    final _gameController = _selectedGame != null
        ? TextEditingController(text: _selectedGame.game)
        : TextEditingController();
    final _tagController = _selectedTag != null
        ? TextEditingController(text: _selectedTag.tag)
        : TextEditingController();
    final _useDeckController = _selectedUseDeck != null
        ? TextEditingController(text: _selectedUseDeck.deck)
        : TextEditingController();
    final _opponentDeckController = _selectedOpponentDeck != null
        ? TextEditingController(text: _selectedOpponentDeck.deck)
        : TextEditingController();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.settings),
              border: OutlineInputBorder(),
              labelText: 'ゲーム名',
              hintText: 'Enter your email',
            ),
            autovalidate: false,
            controller: _gameController,
            onFieldSubmitted: (String value) {
              context.read<GameModel>().selectedGameChangeToString(value);
              _tagController.clear();
            },
            validator: (value) {
              if (value == null) {
                return '入力されていません';
              }
              return null;
            },
          ),
          const _ShowGameModalPicker(),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.settings),
              border: OutlineInputBorder(),
              labelText: 'タグ名',
              hintText: 'Enter タグ名',
            ),
            autovalidate: false,
            controller: _tagController,
            onFieldSubmitted: (String value) {
              context.read<TagModel>().selectedTagChangeToString(value);
            },
            validator: (value) {
              if (value == null) {
                return '入力されていません';
              }
              return null;
            },
          ),
          const _ShowTagModalPicker(),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.settings),
              border: OutlineInputBorder(),
              labelText: '使用デッキ',
              hintText: 'Enter 使用デッキ',
            ),
            autovalidate: false,
            controller: _useDeckController,
            onFieldSubmitted: (String value) {
              context.read<DeckModel>().selectedUseDeckChangeToString(value);
            },
            validator: (value) {
              if (value == null) {
                return '入力されていません';
              }
              return null;
            },
          ),
          const _ShowUseDeckModalPicker(),
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
              context
                  .read<DeckModel>()
                  .selectedOpponentDeckChangeToString(value);
            },
            validator: (value) {
              if (value == null) {
                return '入力されていません';
              }
              return null;
            },
          ),
          const _ShowOpponetDeckModalPicker(),
        ],
      ),
    );
  }
}

class _ShowGameModalPicker extends StatelessWidget {
  const _ShowGameModalPicker({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final gameModel = Provider.of<GameModel>(context, listen: true);
    return RaisedButton(
      onPressed: gameModel.allGameList.length == 1
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
                        children: gameModel.allGameList
                            .map((game) => Text(game.game))
                            .toList(),
                        onSelectedItemChanged:
                            gameModel.selectedGameChangeToIndex,
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

class _ShowTagModalPicker extends StatelessWidget {
  const _ShowTagModalPicker({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final tagModel = Provider.of<TagModel>(context, listen: true);
    final selectedGame =
        context.select((GameModel model) => model.selectedGame);
    if (selectedGame != null) {
      tagModel.getGameTagList(selectedGame.gameId);
    }
    return RaisedButton(
      onPressed: tagModel.gameTagList.length == 1 || selectedGame == null
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
                        children: tagModel.gameTagList
                            .map((tag) => Text(tag.tag))
                            .toList(),
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

class _ShowUseDeckModalPicker extends StatelessWidget {
  const _ShowUseDeckModalPicker({Key key}) : super(key: key);
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