import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.onChanged,
    this.labelText,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.maxLines = 1,
    Key? key,
  }) : super(key: key);

  final Function(String)? onChanged;
  final String? labelText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Align(
            alignment: const AlignmentDirectional(-1, 0),
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              onChanged: onChanged,
              keyboardType: keyboardType,
              maxLines: maxLines,
              obscureText: false,
              decoration: InputDecoration(
                labelText: labelText,
                labelStyle: Theme.of(context).textTheme.caption,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }
}
