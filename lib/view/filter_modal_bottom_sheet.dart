import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/sort.dart';
import 'package:tcg_manager/helper/convert_sort_string.dart';
import 'package:tcg_manager/provider/record_list_view_provider.dart';
import 'package:tcg_manager/view/component/custom_modal_list_picker.dart';
import 'package:tcg_manager/view/component/cutom_date_time_range_picker.dart';
import 'package:tcg_manager/view/select_deck_view.dart';
import 'package:tcg_manager/view/select_tag_view.dart';

class FilterModalBottomSheet extends HookConsumerWidget {
  const FilterModalBottomSheet({
    this.showSort = true,
    this.showDatePickder = true,
    this.showUseDeck = true,
    this.showOpponentDeck = true,
    this.showTag = true,
    key,
  }) : super(key: key);
  final bool showSort;
  final bool showDatePickder;
  final bool showUseDeck;
  final bool showOpponentDeck;
  final bool showTag;

  String _makeTagString(List<Tag> tagList) {
    if (tagList.isEmpty) return '';
    var result = '';
    var count = 0;
    for (final tag in tagList) {
      if (count == 0) {
        result = tag.tag;
      } else {
        result = '$result,${tag.tag}';
      }
      count++;
    }
    return result;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordListViewState = ref.watch(recordListViewNotifierProvider);
    final recordListViewNotifier = ref.watch(recordListViewNotifierProvider.notifier);
    final controller = CustomModalDateTimeRangePickerController(
      initialDateRange: PickerDateRange(recordListViewState.startDate, recordListViewState.endDate),
      initialTimeRange: SfRangeValues(
        recordListViewState.startTime ?? DateTime(1994, 10, 1, 0, 0),
        recordListViewState.endTime ?? DateTime(1994, 10, 1, 23, 59),
      ),
    );
    final outputDateFormat = DateFormat('yyyy/MM/dd');
    final outputTimeFormat = DateFormat('HH:mm');

    return Material(
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    onPressed: recordListViewNotifier.resetFilter,
                    child: Text(
                      'リセット',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: Divider(height: 0),
              ),
              if (showSort)
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Text(
                    '並び替え',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      leadingDistribution: TextLeadingDistribution.even,
                      height: 1,
                    ),
                  ),
                ),
              if (showSort)
                _SelectableRow(
                  submited: recordListViewNotifier.setSort,
                  onSelectedItemChanged: recordListViewNotifier.scrollSort,
                  showAllButton: false,
                  selectableList: Sort.values
                      .map(
                        (sort) => Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Text(
                            ConvertSortString.convert(context, sort),
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(height: 1),
                          ),
                        ),
                      )
                      .toList(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(ConvertSortString.convert(context, recordListViewState.sort)),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              if (showDatePickder)
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Text(
                    '期間',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      leadingDistribution: TextLeadingDistribution.even,
                      height: 1,
                    ),
                  ),
                ),
              if (showDatePickder)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomModalDateTimeRangePicker(
                          controller: controller,
                          submitedAction: () {
                            recordListViewNotifier.setStartDate(controller.selectedDateRange.startDate);
                            recordListViewNotifier.setEndDate(controller.selectedDateRange.endDate);
                            recordListViewNotifier.setStartTime(controller.selectedTimeRange.start);
                            recordListViewNotifier.setEndTime(controller.selectedTimeRange.end);
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    recordListViewState.startDate == null && recordListViewState.endDate == null
                                        ? Row(
                                            children: [
                                              Text('日時:    ',
                                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
                                              const Text('全て'),
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              Text('日時:    ',
                                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
                                              Text(outputDateFormat.format(recordListViewState.startDate!)),
                                              const Text(' - '),
                                              Text(outputDateFormat.format(recordListViewState.endDate!)),
                                            ],
                                          ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    recordListViewState.startTime == null && recordListViewState.endTime == null
                                        ? Row(
                                            children: [
                                              Text('時間帯:    ',
                                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
                                              const Text('全て'),
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              Text('時間帯:    ',
                                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
                                              Text(outputTimeFormat.format(recordListViewState.startTime!)),
                                              const Text(' - '),
                                              Text(outputTimeFormat.format(recordListViewState.endTime!)),
                                            ],
                                          ),
                                  ],
                                ),
                              ],
                            ),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              if (showUseDeck)
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Text(
                    '使用デッキ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      leadingDistribution: TextLeadingDistribution.even,
                      height: 1,
                    ),
                  ),
                ),
              if (showUseDeck)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    showCupertinoModalBottomSheet(
                      expand: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) => SelectDeckView(
                        selectDeckFunc: recordListViewNotifier.selectUseDeck,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        recordListViewState.useDeck == null ? const Text('全て') : Text(recordListViewState.useDeck!.deck),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              if (showOpponentDeck)
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Text(
                    '対戦デッキ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      leadingDistribution: TextLeadingDistribution.even,
                      height: 1,
                    ),
                  ),
                ),
              if (showOpponentDeck)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    showCupertinoModalBottomSheet(
                      expand: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) => SelectDeckView(
                        selectDeckFunc: recordListViewNotifier.selectOpponentDeck,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        recordListViewState.opponentDeck == null ? const Text('全て') : Text(recordListViewState.opponentDeck!.deck),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              if (showTag)
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Text(
                    'タグ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      leadingDistribution: TextLeadingDistribution.even,
                      height: 1,
                    ),
                  ),
                ),
              if (showTag)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    showCupertinoModalBottomSheet(
                      expand: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) => SelectTagView(
                        tagCount: 0,
                        selectTagFunc: recordListViewNotifier.selectTag,
                        deselectionFunc: recordListViewNotifier.deselectionTag,
                        returnSelecting: false,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        recordListViewState.tagList.isEmpty ? const Text('全て') : Text(_makeTagString(recordListViewState.tagList)),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectableRow extends StatelessWidget {
  const _SelectableRow({
    required this.submited,
    required this.onSelectedItemChanged,
    required this.selectableList,
    required this.child,
    this.showAllButton = true,
    key,
  }) : super(key: key);
  final void Function() submited;
  final Function(int) onSelectedItemChanged;
  final List<Widget> selectableList;
  final Widget child;
  final bool showAllButton;

  @override
  Widget build(BuildContext context) {
    if (showAllButton) {
      selectableList.insert(
        0,
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Text(
            '全て',
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(height: 1),
          ),
        ),
      );
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) {
            return CustomModalListPicker(
              submited: () {
                submited();
                Navigator.pop(context);
              },
              onSelectedItemChanged: onSelectedItemChanged,
              children: selectableList,
            );
          },
        );
      },
      child: child,
    );
  }
}
