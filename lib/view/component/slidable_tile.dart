import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableTile extends StatelessWidget {
  const SlidableTile({
    required this.title,
    this.alertTitle = '選択データを削除します',
    this.trailing,
    this.subtitle,
    required this.alertMessage,
    this.deleteFunc,
    this.editFunc,
    this.onTap,
    this.isVisible,
    key,
  }) : super(key: key);

  final Widget title;
  final String alertTitle;
  final String alertMessage;
  final Widget? trailing;
  final Widget? subtitle;
  final Future Function()? deleteFunc;
  final Future Function()? editFunc;
  final Future Function()? onTap;
  final bool? isVisible;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: key,
      groupTag: '0',
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          if (deleteFunc != null)
            SlidableAction(
              icon: Icons.delete,
              backgroundColor: Theme.of(context).colorScheme.error,
              autoClose: false,
              label: '削除',
              onPressed: (context) async {
                final okCancelResult = await showOkCancelAlertDialog(
                  context: context,
                  title: alertTitle,
                  message: alertMessage,
                  isDestructiveAction: true,
                );
                if (okCancelResult == OkCancelResult.ok) {
                  // ignore: use_build_context_synchronously
                  Slidable.of(context)?.dismiss(
                    ResizeRequest(
                      const Duration(microseconds: 300),
                      () async => await deleteFunc!(),
                    ),
                  );
                }
              },
            ),
          if (editFunc != null)
            SlidableAction(
              autoClose: true,
              icon: Icons.edit,
              backgroundColor: Theme.of(context).hintColor,
              onPressed: (context) async => await editFunc!(),
              label: '名前変更',
            ),
        ],
      ),
      child: Builder(builder: (context) {
        return ListTile(
          title: title,
          subtitle: subtitle,
          trailing: trailing ??
              IconButton(
                icon: const Icon(Icons.navigate_before),
                onPressed: () {
                  Slidable.of(context)?.openEndActionPane();
                },
              ),
          onTap: onTap,
        );
      }),
    );
  }
}

class SlidableExpansionTileCard extends StatelessWidget {
  const SlidableExpansionTileCard({
    required this.title,
    this.alertTitle = '選択データを削除します',
    this.trailing,
    this.subtitle,
    this.leading,
    required this.alertMessage,
    this.isExpansion = true,
    this.children = const [],
    this.deleteFunc,
    this.editFunc,
    this.onTap,
    this.onExpansionChanged,
    key,
  }) : super(key: key);

  final Widget title;
  final String alertTitle;
  final String alertMessage;
  final Widget? trailing;
  final Widget? subtitle;
  final Widget? leading;
  final List<Widget> children;
  final bool isExpansion;
  final Future Function()? deleteFunc;
  final Future Function()? editFunc;
  final Future Function()? onTap;
  final void Function(bool)? onExpansionChanged;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      groupTag: '0',
      key: key,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          if (deleteFunc != null)
            SlidableAction(
              label: '削除',
              icon: Icons.delete,
              backgroundColor: Theme.of(context).colorScheme.error,
              autoClose: false,
              onPressed: (context) async {
                final okCancelResult = await showOkCancelAlertDialog(
                  context: context,
                  title: alertTitle,
                  message: alertMessage,
                  isDestructiveAction: true,
                );
                if (okCancelResult == OkCancelResult.ok) {
                  // ignore: use_build_context_synchronously
                  Slidable.of(context)?.dismiss(
                    ResizeRequest(
                      const Duration(microseconds: 300),
                      () async => await deleteFunc!(),
                    ),
                  );
                }
              },
            ),
          if (editFunc != null)
            SlidableAction(
              label: '編集',
              autoClose: false,
              icon: Icons.edit,
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              onPressed: (context) async => await editFunc!(),
            ),
        ],
      ),
      child: Builder(builder: (context) {
        return isExpansion
            ? ExpansionTile(
                tilePadding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                onExpansionChanged: onExpansionChanged,
                backgroundColor: Theme.of(context).colorScheme.surface,
                title: title,
                leading: leading,
                subtitle: subtitle,
                trailing: trailing ??
                    IconButton(
                      icon: const Icon(Icons.navigate_before),
                      onPressed: () {
                        Slidable.of(context)?.openEndActionPane();
                      },
                    ),
                children: children,
              )
            : ListTile(
                contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                title: title,
                leading: leading,
                trailing: trailing,
              );
      }),
    );
  }
}
