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
      child: Container(
        padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.5,
            ),
            top: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.5,
            ),
          ),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
