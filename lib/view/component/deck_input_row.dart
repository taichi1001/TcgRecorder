import 'package:flutter/material.dart';
import 'package:tcg_manager/view/component/custom_textfield.dart';

class DeckInputRow extends StatelessWidget {
  final String labelText;
  final Function(String) onChanged;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isUserDeck;
  final Function onPressed;

  const DeckInputRow({
    Key? key,
    required this.labelText,
    required this.onChanged,
    required this.controller,
    required this.focusNode,
    required this.isUserDeck,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        CustomTextField(
          labelText: labelText,
          onChanged: onChanged,
          controller: controller,
          focusNode: focusNode,
        ),
        IconButton(
          icon: const Icon(Icons.arrow_drop_down),
          onPressed: onPressed as void Function()?,
        ),
      ],
    );
  }
}
