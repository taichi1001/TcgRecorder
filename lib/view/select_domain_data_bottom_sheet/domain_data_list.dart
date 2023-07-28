import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/domain_data.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/helper/db_helper.dart';

class DomainDataList extends StatelessWidget {
  const DomainDataList({
    required this.domainDataList,
    required this.selectedDomainDataList,
    required this.rootContext,
    required this.selectDomainDataFunc,
    required this.enableVisibility,
    required this.tagCount,
    required this.returnSelecting,
    this.deselectionFunc,
    this.afterFunc,
    key,
  }) : super(key: key);

  final List<DomainData> domainDataList;
  final List<DomainData> selectedDomainDataList;
  final BuildContext rootContext;
  final Function(DomainData, int) selectDomainDataFunc;
  final Function(DomainData)? deselectionFunc;
  final Function? afterFunc;
  final int tagCount;

  final bool enableVisibility;
  final bool returnSelecting;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: ((context, index) {
        if (enableVisibility && !domainDataList[index].isVisibleToPicker) return Container();
        final isSelected = selectedDomainDataList.contains(domainDataList[index]);
        return GestureDetector(
          onTap: () {
            if (isSelected) {
              if (deselectionFunc != null) deselectionFunc!(domainDataList[index]);
            } else {
              selectDomainDataFunc(domainDataList[index], tagCount);
              if (returnSelecting) Navigator.pop(rootContext);
              if (afterFunc != null) afterFunc!();
            }
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            color: isSelected ? Theme.of(context).hoverColor : Theme.of(context).colorScheme.surface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  domainDataList[index].name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                IconButton(
                  onPressed: () {
                    showCupertinoModalBottomSheet(
                      context: context,
                      builder: (context) => DomainDataOption(
                        domainData: domainDataList[index],
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                )
              ],
            ),
          ),
        );
      }),
      separatorBuilder: ((context, index) {
        if (enableVisibility && !domainDataList[index].isVisibleToPicker) return Container();
        return const Divider(
          indent: 16,
          thickness: 1,
          height: 0,
        );
      }),
      itemCount: domainDataList.length,
    );
  }
}

class DomainDataOption extends HookConsumerWidget {
  const DomainDataOption({
    required this.domainData,
    key,
  }) : super(key: key);

  final DomainData domainData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SelectableRow(text: domainData.name, icon: Icons.gamepad, width: 16),
          const Divider(),
          if (domainData is Game) _SelectableRow(text: '共有', icon: Icons.person_add_alt, onTap: () {}),
          _SelectableRow(
            text: '名前を変更',
            icon: Icons.edit,
            onTap: () async {
              final newName = await showTextInputDialog(
                context: context,
                title: '名前を変更',
                textFields: [DialogTextField(initialText: domainData.name)],
              );
              if (newName != null) {
                try {
                  switch (domainData) {
                    case Game():
                      await ref.read(dbHelper).updateGameName(domainData as Game, newName.first);
                    case Deck():
                      await ref.read(dbHelper).updateDeckName(domainData as Deck, newName.first);
                    case Tag():
                      await ref.read(dbHelper).updateTagName(domainData as Tag, newName.first);
                  }
                } on DatabaseException catch (e) {
                  if (e.isUniqueConstraintError() && context.mounted) {
                    await showOkAlertDialog(
                      context: context,
                      title: '既に登録されている名前です',
                      message: '「${newName.first}」は既に登録されているため名前を変更することはできませんでした。',
                    );
                  }
                }
              }
              if (context.mounted) Navigator.pop(context);
            },
          ),
          _SelectableRow(
            text: '削除',
            icon: Icons.delete,
            onTap: () async {
              final result = await showOkCancelAlertDialog(
                context: context,
                title: '${domainData.name}を削除しますか？',
                message: () {
                  switch (domainData) {
                    case Tag():
                      return '削除するとこれまでに保存した記録からも削除されます。';
                    default:
                      return '削除するとこれまでに保存していた記録も削除されます。';
                  }
                }(),
              );
              if (result == OkCancelResult.ok) {
                switch (domainData) {
                  case Game():
                    await ref.read(dbHelper).deleteGame(domainData as Game);
                  case Deck():
                    await ref.read(dbHelper).deleteDeck(domainData as Deck);
                  case Tag():
                    await ref.read(dbHelper).deleteTag(domainData as Tag);
                }
              }
              if (context.mounted) Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class _SelectableRow extends StatelessWidget {
  const _SelectableRow({
    required this.text,
    required this.icon,
    this.width = 32,
    this.onTap,
    key,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final Function()? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: width),
            Text(text),
          ],
        ),
      ),
    );
  }
}
