import 'package:flutter/material.dart';

class SliverHeader extends StatelessWidget {
  const SliverHeader({
    required this.title,
    super.key,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
