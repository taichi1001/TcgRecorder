import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tcg_manager/view/component/custom_modal_picker.dart';

/// showCupertinoModalPopupから呼び出して使用するDatePicker
class CustomModalDatePicker extends HookWidget {
  const CustomModalDatePicker({
    required this.submited,
    required this.onDateTimeChanged,
    Key? key,
  }) : super(key: key);
  final Function() submited;
  final Function(DateTime) onDateTimeChanged;
  @override
  Widget build(BuildContext context) {
    return CustomModalPicker(
      submitedAction: submited,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        minimumYear: 2000,
        maximumYear: DateTime.now().year,
        onDateTimeChanged: onDateTimeChanged,
      ),
    );
  }
}
