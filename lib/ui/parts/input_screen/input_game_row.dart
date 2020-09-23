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
      child: Stack(
        alignment: Alignment.centerRight,
        children: const [
          _InputGameTextField(),
          _ShowCupertinoPickerButton(),
        ],
      ),
    );
  }
}

class _InputGameTextField extends StatelessWidget {
  const _InputGameTextField({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // style: const TextStyle(
      //   fontSize: 13,
      // ),
      decoration: const InputDecoration(
        // icon: const Icon(Icons.settings),
        border: OutlineInputBorder(
            // borderRadius: BorderRadius.circular(10.0),
            ),
        labelText: 'ゲーム名',
        hintText: 'Enter your ゲーム名',
      ),
      controller: context.select((TextEditingControllerModel model) => model.gameController),
      onChanged: (String value) {
        context.read<GameModel>().changeSelectedGameUsingString(value);
        context.read<TextEditingControllerModel>().tagController.clear();
        context.read<TextEditingControllerModel>().useDeckController.clear();
        context.read<TextEditingControllerModel>().opponentDeckController.clear();
      },
    );
  }
}

class _ShowCupertinoPickerButton extends StatelessWidget {
  const _ShowCupertinoPickerButton({key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_drop_down),
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
                  onSelectedItemChanged: (int index) {
                    context.read<GameModel>().changeSelectedGameUsingIndex(index);
                    context
                        .read<TextEditingControllerModel>()
                        .setGameController(context.read<GameModel>().selectedGame.game);
                  },
                  children: context
                      .select((GameModel model) => model.allGameList)
                      .map((game) => Text(game.game))
                      .toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
