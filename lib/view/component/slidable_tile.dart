import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
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
              label: '削除',
              icon: Icons.delete,
              backgroundColor: Theme.of(context).errorColor,
              autoClose: false,
              onPressed: (context) async {
                final okCancelResult = await showOkCancelAlertDialog(
                  context: context,
                  title: alertTitle,
                  message: alertMessage,
                  isDestructiveAction: true,
                );
                if (okCancelResult == OkCancelResult.ok) {
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
              label: '名前変更',
              autoClose: false,
              icon: Icons.edit,
              backgroundColor: Theme.of(context).toggleableActiveColor,
              onPressed: (context) async => await editFunc!(),
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
              backgroundColor: Theme.of(context).errorColor,
              autoClose: false,
              onPressed: (context) async {
                final okCancelResult = await showOkCancelAlertDialog(
                  context: context,
                  title: alertTitle,
                  message: alertMessage,
                  isDestructiveAction: true,
                );
                if (okCancelResult == OkCancelResult.ok) {
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
              backgroundColor: Theme.of(context).toggleableActiveColor,
              onPressed: (context) async => await editFunc!(),
            ),
        ],
      ),
      child: Builder(builder: (context) {
        return ExpansionTileCard(
          onExpansionChanged: onExpansionChanged,
          elevation: 0,
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
        );
      }),
    );
  }
}
