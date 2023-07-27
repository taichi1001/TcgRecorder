import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/enum/domain_data_type.dart';
import 'package:tcg_manager/enum/sort.dart';
import 'package:tcg_manager/helper/convert_sort_string.dart';
import 'package:tcg_manager/provider/select_domain_data_view_provider.dart';
import 'package:tcg_manager/view/select_domain_data_bottom_sheet/reordable_domain_data_view.dart';

class AllListSectionBar extends HookConsumerWidget {
  const AllListSectionBar({
    required this.enableVisiblity,
    required this.dataType,
    key,
  }) : super(key: key);

  final bool enableVisiblity;
  final DomainDataType dataType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(selectDomainDataViewNotifierProvider(dataType).select((value) => value.sortType));
    final selectDomainDataViewNotifier = ref.watch(selectDomainDataViewNotifierProvider(dataType).notifier);
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '一覧',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Row(
            children: [
              Visibility(
                visible: sort == Sort.custom,
                child: CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReordableDomainDataView(
                          datatype: dataType,
                          enableVisiblity: enableVisiblity,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    '設定',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: () => selectDomainDataViewNotifier.changeSort(),
                child: Text(
                  ConvertSortString.convert(context, sort),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
