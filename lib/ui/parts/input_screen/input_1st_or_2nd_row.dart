import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/model/record_model.dart';
import 'package:tcg_recorder/ui/parts/toggle_switch.dart';

class InputFirstOrSecondRow extends StatelessWidget {
  const InputFirstOrSecondRow({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _firstOrSecond = context.select((RecordModel model) => model.firstOrSecond);
    return ToggleSwitch(
      initialLabelIndex: _firstOrSecond ? 1 : 0,
      minWidth: _size.width * (40 / 100),
      minHeight: _size.height * (6 / 100),
      labels: [L10n.of(context).first, L10n.of(context).second],
      activeFgColor: Colors.white,
      inactiveFgColor: Colors.white,
      activeBgColor: Theme.of(context).buttonColor,
      onToggle: (index) {
        context.read<RecordModel>().changeFirstOrSecond(index);
      },
      fontWeight: FontWeight.bold,
    );
  }
}
