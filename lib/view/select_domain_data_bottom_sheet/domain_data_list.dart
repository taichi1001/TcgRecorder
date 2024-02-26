import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tcg_manager/entity/domain_data.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/view/select_domain_data_bottom_sheet/domain_data_options.dart';

class DomainDataList extends HookConsumerWidget {
  const DomainDataList({
    required this.domainDataList,
    required this.selectedDomainDataList,
    required this.rootContext,
    required this.selectDomainDataFunc,
    required this.enableVisibility,
    required this.tagCount,
    required this.returnSelecting,
    this.isShareHost = false,
    this.isShowMenu = true,
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
  final bool isShareHost;
  final bool isShowMenu;
  final bool enableVisibility;
  final bool returnSelecting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: ((context, index) {
        final domainData = domainDataList[index];
        if (enableVisibility && !domainData.isVisibleToPicker) return Container();
        final isSelected = selectedDomainDataList.contains(domainData);
        return GestureDetector(
          onTap: () async {
            if (isSelected) {
              if (deselectionFunc != null) deselectionFunc!(domainData);
            } else {
              await selectDomainDataFunc(domainData, tagCount);
              if (returnSelecting && rootContext.mounted) Navigator.pop(rootContext);
              if (afterFunc != null) afterFunc!();
            }
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            color: isSelected ? Theme.of(context).hoverColor : Theme.of(context).colorScheme.surface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (domainData is Game && domainData.isShare) const Icon(Icons.share),
                    if (domainData is Game && domainData.isShare) const SizedBox(width: 8),
                    Text(
                      domainData.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                if (isShowMenu)
                  IconButton(
                    onPressed: () {
                      ref.read(currentDomainDataProvider.notifier).state = domainDataList[index];
                      ref.read(currentDomainDataIsShareHostProvider.notifier).state = isShareHost;
                      showCupertinoModalBottomSheet(
                        context: context,
                        builder: (context) => DomainDataOptions(isShareHost: isShareHost),
                      );
                    },
                    icon: const Icon(Icons.more_vert),
                  ),
                if (!isShowMenu) const SizedBox(width: 48, height: 48) // iconbutonと同じ大きさのウィジェットを設定
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
