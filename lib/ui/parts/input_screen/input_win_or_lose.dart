import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/model/record_model.dart';
import 'package:tcg_recorder/ui/parts/toggle_switch.dart';

class InputWinOrLoseRow extends StatelessWidget {
  const InputWinOrLoseRow({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _winOrLose = context.select((RecordModel model) => model.winOrLose);
    return ToggleSwitch(
      labels: [L10n.of(context).win, L10n.of(context).lose],
      minWidth: _size.width * (40 / 100),
      minHeight: _size.height * (6 / 100),
      initialLabelIndex: _winOrLose ? 1 : 0,
      activeFgColor: Colors.white,
      activeBgColor: Theme.of(context).buttonColor,
      inactiveFgColor: Colors.white,
      onToggle: (index) {
        context.read<RecordModel>().changeWinOrLose(index);
      },
      fontWeight: FontWeight.bold,
    );
  }
}
