import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcg_manager/view/component/custom_modal_picker.dart';

class CustomModalListPicker extends StatelessWidget {
  const CustomModalListPicker({
    required this.submited,
    required this.onSelectedItemChanged,
    required this.children,
    this.actionButton,
    key,
  }) : super(key: key);
  final void Function() submited;
  final Function(int) onSelectedItemChanged;
  final Widget? actionButton;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return CustomModalPicker(
      submitedAction: submited,
      actionButton: actionButton,
      child: CupertinoTheme(
        data: CupertinoThemeData(brightness: Theme.of(context).brightness),
        child: CupertinoPicker(
          itemExtent: 40,
          onSelectedItemChanged: onSelectedItemChanged,
          children: children,
        ),
      ),
    );
  }
}
