import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/model/deck_model.dart';
import 'package:tcg_recorder/model/text_editing_controller_model.dart';
import 'package:tcg_recorder/ui/parts/show_cupertino_picker_button.dart';
import 'package:tcg_recorder/ui/parts/input_text_field.dart';
import 'package:tcg_recorder/ui/parts/input_row.dart';

class InputUseDeckRow extends StatelessWidget {
  const InputUseDeckRow({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InputRow(
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          InputTextField(
            controller: context.select(
                (TextEditingControllerModel model) => model.useDeckController),
            onChanged: (String value) {
              context.read<DeckModel>().changeSelectedUseDeckUsingString(value);
            },
            labelText: '使用デッキ',
            hintText: 'Enter 使用デッキ',
          ),
          ShowCupertinoPickerButton(
            onSelectedItemChanged: (int index) {
              context.read<DeckModel>().changeSelectedUseDeckUsingIndex(index);
              context.read<TextEditingControllerModel>().setUseDeckController(
                  context.read<DeckModel>().selectedUseDeck.deck);
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
