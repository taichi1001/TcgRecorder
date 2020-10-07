import 'package:flutter/material.dart';

class InputRow extends StatelessWidget {
  const InputRow({
    @required this.child,
    Key key,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      height: _size.height * (12 / 100),
      width: _size.width * (80 / 100),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: child,
    );
  }
}
