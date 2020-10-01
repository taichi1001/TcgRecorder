import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/model/deck_model.dart';
import 'package:tcg_recorder/model/text_editing_controller_model.dart';
import 'package:tcg_recorder/ui/parts/show_cupertino_picker_button.dart';
import 'package:tcg_recorder/ui/parts/input_text_field.dart';
import 'package:tcg_recorder/ui/parts/input_row.dart';

class InputOpponentDeckRow extends StatelessWidget {
  const InputOpponentDeckRow({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InputRow(
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          InputTextField(
            controller:
                context.select((TextEditingControllerModel model) => model.opponentDeckController),
            onChanged: (String value) {
              context.read<DeckModel>().changeSelectedOpponentDeckUsingString(value);
            },
            labelText: L10n.of(context).inputOpponentDeckLabel,
            hintText: L10n.of(context).inputOpponentDeckHint,
          ),
          ShowCupertinoPickerButton(
            onSelectedItemChanged: (int index) {
              context.read<DeckModel>().changeSelectedOpponentDeckUsingIndex(index);
              context
                  .read<TextEditingControllerModel>()
                  .setOpponentDeckController(context.read<DeckModel>().selectedOpponentDeck.deck);
            },
            children: context
                .select((DeckModel model) => model.gameDeckList)
                .map((deck) => Text(deck.deck))
                .toList(),
          ),
        ],
      ),
    );
  }
}
