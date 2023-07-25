import 'package:flutter/material.dart';

class PremiumLockIcon extends StatelessWidget {
  const PremiumLockIcon({
    required this.child,
    this.isPremium = false,
    this.alignment = AlignmentDirectional.topEnd,
    super.key,
  });

  final Widget child;
  final bool isPremium;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: alignment,
      fit: StackFit.passthrough,
      children: [
        child,
        if (!isPremium)
          const Icon(
            Icons.lock,
            size: 16,
          ),
      ],
    );
  }
}
