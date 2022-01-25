import 'package:flutter/cupertino.dart';
import 'package:tcg_recorder2/view/component/custom_modal_picker.dart';

class CustomModalListPicker extends StatelessWidget {
  const CustomModalListPicker({
    required this.submited,
    required this.onSelectedItemChanged,
    required this.children,
    key,
  }) : super(key: key);
  final void Function() submited;
  final Function(int) onSelectedItemChanged;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return CustomModalPicker(
      submitedAction: submited,
      child: CupertinoPicker(
        itemExtent: 40,
        onSelectedItemChanged: onSelectedItemChanged,
        children: children,
      ),
    );
  }
}
