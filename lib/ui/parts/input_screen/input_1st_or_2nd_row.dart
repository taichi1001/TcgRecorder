import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tcg_recorder/localization/l10n.dart';
import 'package:tcg_recorder/model/record_model.dart';
import 'package:tcg_recorder/ui/parts/toggle_switch.dart';

class InputFirstOrSecondRow extends StatelessWidget {
  const InputFirstOrSecondRow({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _firstOrSecond = context.select((RecordModel model) => model.firstOrSecond);
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 8),
      child: ToggleSwitch(
        initialLabelIndex: _firstOrSecond ? 0 : 1,
        // minWidth: _size.width * (40 / 100),
        // minHeight: _size.height * (6 / 100),
        minHeight: 54.h,
        minWidth: 150.w,
        labels: [L10n.of(context).first, L10n.of(context).second],
        activeFgColor: Colors.white,
        inactiveFgColor: Colors.white,
        activeBgColor: Theme.of(context).buttonColor,
        onToggle: (index) {
          context.read<RecordModel>().changeFirstOrSecond(index);
        },
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
