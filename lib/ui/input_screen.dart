import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
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

    final _gameController = TextEditingController(text: _selectedGame.game);
    final _tagController = TextEditingController(text: _selectedTag.tag);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.settings),
              border: const OutlineInputBorder(),
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
              if (value.isEmpty) {
                return '入力されていません';
              }
              return null;
            },
          ),
          const _ShowGameModalPicker(),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.settings),
              border: const OutlineInputBorder(),
              labelText: 'タグ名',
              hintText: 'Enter タグ名',
            ),
            autovalidate: false,
            controller: _tagController,
            onFieldSubmitted: (String value) {
              context.read<TagModel>().selectedTagChangeToString(value, _selectedGame.gameId);
            },
            validator: (value) {
              if (value.isEmpty) {
                return '入力されていません';
              }
              return null;
            },
          ),
          const _ShowTagModalPicker(),
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
                  children: gameModel.allGameList
                      .map((game) => Text(game.game))
                      .toList(),
                  onSelectedItemChanged: gameModel.selectedGameChangeToIndex,
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
    tagModel.getGameTagList(
        context.select((GameModel model) => model.selectedGame.gameId));
    return RaisedButton(
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
                  children:
                      tagModel.gameTagList.map((tag) => Text(tag.tag)).toList(),
                  onSelectedItemChanged: tagModel.selectedTagChangeToIndex,
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
