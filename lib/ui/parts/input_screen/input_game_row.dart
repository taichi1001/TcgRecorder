import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/deck_model.dart';
import 'package:tcg_recorder/model/game_model.dart';
import 'package:tcg_recorder/model/tag_model.dart';
import 'package:tcg_recorder/model/text_editing_controller_model.dart';
import 'package:tcg_recorder/localization/l10n.dart';
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
            controller: context.select(
                (TextEditingControllerModel model) => model.gameController),
            onChanged: (String value) {
              context.read<GameModel>().changeSelectedGameUsingString(value);
              context.read<TextEditingControllerModel>().tagController.clear();
              context
                  .read<TextEditingControllerModel>()
                  .useDeckController
                  .clear();
              context
                  .read<TextEditingControllerModel>()
                  .opponentDeckController
                  .clear();
              // context.read<TagModel>().changeSelectedTagUsingString('');
              context.read<DeckModel>().changeSelectedUseDeckUsingString('');
              context
                  .read<DeckModel>()
                  .changeSelectedOpponentDeckUsingString('');
            },
            labelText: L10n.of(context).inputGameLabel,
            hintText: L10n.of(context).inputGameHint,
          ),
          ShowCupertinoPickerButton(
            onSelectedItemChanged: (int value) {
              context.read<GameModel>().changeSelectedGameUsingIndex(value);
              context.read<TextEditingControllerModel>().setGameController(
                  context.read<GameModel>().selectedGame.game);
              context.read<TextEditingControllerModel>().tagController.clear();
              context
                  .read<TextEditingControllerModel>()
                  .useDeckController
                  .clear();
              context
                  .read<TextEditingControllerModel>()
                  .opponentDeckController
                  .clear();
              // context.read<TagModel>().changeSelectedTagUsingString('');
              context.read<DeckModel>().changeSelectedUseDeckUsingString('');
              context
                  .read<DeckModel>()
                  .changeSelectedOpponentDeckUsingString('');
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
