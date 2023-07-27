import 'package:flutter/material.dart';
import 'package:tcg_manager/entity/domain_data.dart';

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
                  onPressed: () {},
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
