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
    return Container(
      height: _size.height * (10 / 100),
      width: _size.width * (80 / 100),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: const _InputGameTextField(),
    );
  }
}

class _InputGameTextField extends StatelessWidget {
  const _InputGameTextField({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _selectedGame = context.select((GameModel model) => model.selectedGame);
    Provider.of<TextEditingControllerModel>(context, listen: false).setGameController(
        _selectedGame != null
            ? TextEditingController(text: _selectedGame.game)
            : TextEditingController());

    return TextFormField(
      // style: const TextStyle(
      //   fontSize: 13,
      // ),
      decoration: InputDecoration(
        // icon: const Icon(Icons.settings),
        border: const OutlineInputBorder(
            // borderRadius: BorderRadius.circular(10.0),
            ),
        labelText: 'ゲーム名',
        hintText: 'Enter your ゲーム名',
        suffixIcon: IconButton(
          icon: const Icon(Icons.arrow_drop_down),
          onPressed: () {
            _showCupertinoPicker(context);
          },
        ),
      ),
      controller: context.select((TextEditingControllerModel model) => model.gameController),
      onFieldSubmitted: (String value) {
        context.read<GameModel>().changeSelectedGameUsingString(value);
        context.select((TextEditingControllerModel model) => model.tagController).clear();
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

void _showCupertinoPicker(BuildContext context) {
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
            onSelectedItemChanged: (int index) =>
                context.read<GameModel>().changeSelectedGameUsingIndex(index),
            children: context
                .select((GameModel model) => model.allGameList)
                .map((game) => Text(game.game))
                .toList(),
          ),
        ),
      );
    },
  );
}
