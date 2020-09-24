import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ShowCupertinoPickerButton extends StatelessWidget {
  const ShowCupertinoPickerButton({
    @required this.onSelectedItemChanged,
    @required this.children,
    key,
  }) : super(key: key);
  final Function(int) onSelectedItemChanged;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_drop_down),
      onPressed: children.isEmpty
          ? null
          : () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CupertinoPicker(
                        itemExtent: 40,
                        onSelectedItemChanged: onSelectedItemChanged,
                        children: children,
                      ),
                    ),
                  );
                },
              );
            },
    );
  }
}
