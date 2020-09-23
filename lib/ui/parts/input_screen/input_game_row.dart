import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/game_model.dart';
import 'package:tcg_recorder/model/text_editing_controller_model.dart';
import 'package:tcg_recorder/ui/parts/show_cupertino_picker_button.dart';
import 'package:tcg_recorder/ui/parts/input_text_field.dart';
import 'package:tcg_recorder/ui/parts/input_row.dart';

class InputGameRow extends StatelessWidget {
  const InputGameRow({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InputRow(
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          InputTextField(
            controller: context.select((TextEditingControllerModel model) => model.gameController),
            onChanged: (String value) {
              context.read<GameModel>().changeSelectedGameUsingString(value);
              context.read<TextEditingControllerModel>().tagController.clear();
              context.read<TextEditingControllerModel>().useDeckController.clear();
              context.read<TextEditingControllerModel>().opponentDeckController.clear();
            },
            labelText: 'ゲーム名',
            hintText: 'Enter your ゲーム名',
          ),
          ShowCupertinoPickerButton(
            onSelectedItemChanged: (int value) {
              context.read<GameModel>().changeSelectedGameUsingIndex(value);
              context
                  .read<TextEditingControllerModel>()
                  .setGameController(context.read<GameModel>().selectedGame.game);
            },
            children: context
                .select((GameModel model) => model.allGameList)
                .map((game) => Text(game.game))
                .toList(),
          ),
        ],
      ),
    );
  }
}
