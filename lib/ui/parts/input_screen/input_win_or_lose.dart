import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/model/record_model.dart';
import 'package:tcg_recorder/ui/parts/toggle_switch.dart';

class InputWinOrLoseRow extends StatelessWidget {
  const InputWinOrLoseRow({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _winOrLose = context.select((RecordModel model) => model.winOrLose);
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 8),
      child: ToggleSwitch(
        labels: [L10n.of(context).win, L10n.of(context).lose],
        minHeight: 54.h,
        minWidth: 150.w,
        initialLabelIndex: _winOrLose ? 0 : 1,
        activeFgColor: Colors.white,
        activeBgColor: Theme.of(context).buttonColor,
        inactiveFgColor: Colors.white,
        onToggle: (index) {
          context.read<RecordModel>().changeWinOrLose(index);
        },
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
