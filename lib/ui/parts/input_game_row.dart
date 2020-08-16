import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/game_model.dart';
import 'package:tcg_recorder/model/text_editing_controller_model.dart';

class InputGameRow extends StatelessWidget {
  const InputGameRow({Key key}) : super(key: key);
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
          child: const _InputGameTextField(),
        ),
        Container(
          height: 80,
          padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
          width: _size.width * (15 / 100),
          child: const _ShowGameModalPicker(),
        ),
      ],
    );
  }
}

class _InputGameTextField extends StatelessWidget {
  const _InputGameTextField({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _selectedGame =
        context.select((GameModel model) => model.selectedGame);
    // context.select((TextEditingControllerModel model) => model.gameController =
    //     _selectedGame != null
    //         ? TextEditingController(text: _selectedGame.game)
    //         : TextEditingController());
    final _textModel =
        Provider.of<TextEditingControllerModel>(context, listen: false);
    _textModel.setGameController(_selectedGame != null
        ? TextEditingController(text: _selectedGame.game)
        : TextEditingController());

    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.settings),
        border: OutlineInputBorder(),
        labelText: 'ゲーム名',
        hintText: 'Enter your email',
      ),
      autovalidate: false,
      controller: context
          .select((TextEditingControllerModel model) => model.gameController),
      onFieldSubmitted: (String value) {
        context.read<GameModel>().selectedGameChangeToString(value);
        context
            .select((TextEditingControllerModel model) => model.tagController)
            .clear();
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

class _ShowGameModalPicker extends StatelessWidget {
  const _ShowGameModalPicker({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _allGameList = context.select((GameModel model) => model.allGameList);
    return RaisedButton(
      onPressed: _allGameList.length == 1
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
                        children: _allGameList
                            .map((game) => Text(game.game))
                            .toList(),
                        onSelectedItemChanged: (int index) => context
                            .read<GameModel>()
                            .selectedGameChangeToIndex(index),
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
