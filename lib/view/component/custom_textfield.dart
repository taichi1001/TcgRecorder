import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.onChanged,
    this.indexOnChanged,
    this.labelText,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.maxLines = 1,
    this.index,
    Key? key,
  }) : super(key: key);

  final Function(String)? onChanged;
  final Function(String, int)? indexOnChanged;
  final String? labelText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? index;

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
              onChanged: ((value) {
                if (onChanged != null) {
                  onChanged!(value);
                } else if (indexOnChanged != null && index != null) {
                  indexOnChanged!(value, index!);
                }
              }),
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
