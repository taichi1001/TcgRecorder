import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/game_model.dart';

void main() => runApp(InputScreen());

class InputScreen extends StatelessWidget {
  const InputScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('データ入力'),
      ),
      body: Center(
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
    final _gameController = TextEditingController(
        text: context.select((GameModel model) => model.selectedGame.game));
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.settings),
                  border: OutlineInputBorder(),
                  labelText: "ゲーム名",
                  hintText: 'Enter your email',
                ),
                autovalidate: false,
                controller: _gameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return '入力されていません';
                  }
                  return null;
                },
              ),
              _ShowModalPicker(),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShowModalPicker extends StatelessWidget {
  const _ShowModalPicker({Key key}) : super(key: key);
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
                  onSelectedItemChanged: gameModel.selectedGameChange,
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
