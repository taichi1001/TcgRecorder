import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/model/game_model.dart';
import 'package:tcg_recorder/ui/record_list_screen.dart';

class GameListScreen extends StatelessWidget {
  const GameListScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Records'),
      ),
      body: const GameListView(),
    );
  }
}

class GameListView extends StatelessWidget {
  const GameListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _gameList = context.select((GameModel model) => model.allGameList);
    if (_gameList.isEmpty) {
      return const Center(child: Text('No Items'));
    }

    return ListView.builder(
      itemCount: _gameList.length,
      itemBuilder: (BuildContext context, int index) => GameListTile(
        game: _gameList[index],
      ),
    );
  }
}

class GameListTile extends StatelessWidget {
  const GameListTile({
    this.game,
    Key key,
  }) : super(key: key);
  final Game game;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(game.game),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RecordListScreen(game: game),
            ),
          );
        },
      ),
    );
  }
}
