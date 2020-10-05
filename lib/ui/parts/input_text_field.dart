import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    @required this.controller,
    @required this.onChanged,
    this.labelText,
    this.hintText,
    Key key,
  }) : super(key: key);
  final TextEditingController controller;
  final Function(String) onChanged;
  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // style: const TextStyle(
      //   fontSize: 13,
      // ),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            // borderRadius: BorderRadius.circular(10.0),
            ),
        labelText: labelText ?? labelText,
        hintText: hintText ?? hintText,
      ),
      // focusNode: _focusNode,
      controller: controller,
      onChanged: onChanged,
    );
  }
}
