import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/model/game_model.dart';
import 'package:tcg_recorder/ui/data_screen.dart';

class DataListScreen extends StatelessWidget {
  const DataListScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Game'),
      ),
      body: const GraphListView(),
    );
  }
}

class GraphListView extends StatelessWidget {
  const GraphListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _gameList = context.select((GameModel model) => model.graphListAllGameList);
    return _gameList.isEmpty
        ? const Center(
            child: Text('No Items'),
          )
        : ListView.builder(
            itemCount: _gameList.length,
            itemBuilder: (BuildContext context, int index) => GraphListTile(
              game: _gameList[index],
            ),
          );
  }
}

class GraphListTile extends StatelessWidget {
  const GraphListTile({
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
              builder: (context) => DataScreen(game: game),
            ),
          );
        },
      ),
    );
  }
}
