import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputRow extends StatelessWidget {
  const InputRow({
    @required this.child,
    Key key,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: 300.w,
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: child,
    );
  }
}
