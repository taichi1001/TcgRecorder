import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/model/deck_model.dart';
import 'package:tcg_recorder/model/game_model.dart';
import 'package:tcg_recorder/model/record_model.dart';
import 'package:tcg_recorder/model/tag_model.dart';
import 'package:tcg_recorder/ui/graph_screen.dart';
import 'package:tcg_recorder/ui/record_detail_view.dart';

class GraphListScreen extends StatelessWidget {
  const GraphListScreen({Key key}) : super(key: key);
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
    final gameList = context.select((GameModel model) => model.allGameList);
    if (gameList.isEmpty) {
      return const Center(child: Text('No Items'));
    }

    return ListView.builder(
      itemCount: gameList.length,
      itemBuilder: (BuildContext context, int index) => GraphListTile(game: gameList[index]),
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
              builder: (context) => GraphScreen(game: game),
            ),
          );
        },
      ),
    );
  }
}
