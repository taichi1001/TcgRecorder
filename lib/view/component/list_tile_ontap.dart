import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListTileOnTap extends HookConsumerWidget {
  const ListTileOnTap({
    required this.title,
    this.onTap,
    this.trailing,
    super.key,
  });
  final String title;
  final Function()? onTap;
  final Widget? trailing;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      type: MaterialType.button,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
