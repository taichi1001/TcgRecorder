import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListTileOnTap extends HookConsumerWidget {
  const ListTileOnTap({
    required this.title,
    this.onTap,
    this.trailing,
    this.leading,
    this.textStyle,
    super.key,
  });
  final String title;
  final Function()? onTap;
  final Widget? trailing;
  final Widget? leading;
  final TextStyle? textStyle;
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
              if (leading != null)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: leading!,
                ),
              Expanded(
                child: Text(
                  title,
                  style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
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
