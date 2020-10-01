import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/model/tag_model.dart';
import 'package:tcg_recorder/model/text_editing_controller_model.dart';
import 'package:tcg_recorder/ui/parts/show_cupertino_picker_button.dart';
import 'package:tcg_recorder/ui/parts/input_text_field.dart';
import 'package:tcg_recorder/ui/parts/input_row.dart';

class InputTagRow extends StatelessWidget {
  const InputTagRow({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InputRow(
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          InputTextField(
            controller: context.select((TextEditingControllerModel model) => model.tagController),
            onChanged: (String value) {
              context.read<TagModel>().changeSelectedTagUsingString(value);
            },
            labelText: L10n.of(context).inputTagLabel,
            hintText: L10n.of(context).inputTagHint,
          ),
          ShowCupertinoPickerButton(
            onSelectedItemChanged: (int index) {
              context.read<TagModel>().changeSelectedTagUsingIndex(index);
              context
                  .read<TextEditingControllerModel>()
                  .setTagController(context.read<TagModel>().selectedTag.tag);
            },
            children: context
                .select((TagModel model) => model.gameTagList)
                .map((tag) => Text(tag.tag))
                .toList(),
          ),
        ],
      ),
    );
  }
}
