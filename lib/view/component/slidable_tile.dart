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
