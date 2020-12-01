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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: labelText ?? labelText,
        labelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        hintText: hintText ?? hintText,
        hintStyle: const TextStyle(fontSize: 12),
        counterText: '',
      ),
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        // color: Colors.black87,
      ),
      maxLength: 12,
      controller: controller,
      onChanged: onChanged,
    );
  }
}
