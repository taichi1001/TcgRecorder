import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tcg_manager/enum/Sort.dart';
import 'package:tcg_manager/helper/convert_sort_string.dart';
import 'package:tcg_manager/provider/record_list_view_provider.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/selector/game_tag_list_selector.dart';
import 'package:tcg_manager/view/component/custom_modal_list_picker.dart';
import 'package:tcg_manager/view/component/custom_modal_picker.dart';

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordListViewState = ref.watch(recordListViewNotifierProvider);
    final recordListViewNotifier = ref.watch(recordListViewNotifierProvider.notifier);
    final gameDeck = ref.watch(gameDeckListProvider);
    final gameTag = ref.watch(gameTagListProvider);
    final outputFormat = DateFormat('yyyy/MM/dd');

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
                    onPressed: recordListViewNotifier.resetFilter,
                    child: const Text('リセット'),
                  ),
                ],
              ),
              if (showSort)
                const Text(
                  '並び替え',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    leadingDistribution: TextLeadingDistribution.even,
                    height: 1,
                  ),
                ),
              if (showSort)
                _SelectableRow(
                  submited: recordListViewNotifier.setSort,
                  onSelectedItemChanged: recordListViewNotifier.scrollSort,
                  showAlooButton: false,
                  selectableList: Sort.values
                      .map(
                        (sort) => Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Text(
                            ConvertSortString.convert(context, sort),
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
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
                    '日付',
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
                        return SizedBox(
                          height: 350,
                          child: CustomModalPicker(
                            shoModalButton: false,
                            child: SfDateRangePicker(
                              selectionMode: DateRangePickerSelectionMode.range,
                              view: DateRangePickerView.month,
                              showActionButtons: true,
                              minDate: DateTime(2000, 01, 01),
                              maxDate: DateTime.now(),
                              initialSelectedRange: PickerDateRange(recordListViewState.startDate, recordListViewState.endDate),
                              onSubmit: (value) {
                                if (value is PickerDateRange) {
                                  recordListViewNotifier.setStartDate(value.startDate!);
                                  recordListViewNotifier.setEndDate(value.endDate);
                                  Navigator.pop(context);
                                }
                              },
                              onCancel: () => Navigator.pop(context),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        recordListViewState.startDate == null && recordListViewState.endDate == null
                            ? const Text('全て')
                            : Row(
                                children: [
                                  Text(outputFormat.format(recordListViewState.startDate!)),
                                  const Text(' - '),
                                  Text(outputFormat.format(recordListViewState.endDate!)),
                                ],
                              ),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
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
                _SelectableRow(
                  submited: recordListViewNotifier.setUseDeck,
                  onSelectedItemChanged: recordListViewNotifier.scrollUseDeck,
                  selectableList: gameDeck
                      .map(
                        (deck) => Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Text(
                            deck.deck,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
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
                _SelectableRow(
                  submited: recordListViewNotifier.setOpponentDeck,
                  onSelectedItemChanged: recordListViewNotifier.scrollOpponentDeck,
                  selectableList: gameDeck
                      .map(
                        (deck) => Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Text(
                            deck.deck,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
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
                _SelectableRow(
                  submited: recordListViewNotifier.setTag,
                  onSelectedItemChanged: recordListViewNotifier.scrollTag,
                  selectableList: gameTag
                      .map(
                        (tag) => Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Text(
                            tag.tag,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        recordListViewState.tag == null ? const Text('全て') : Text(recordListViewState.tag!.tag),
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
    this.showAlooButton = true,
    key,
  }) : super(key: key);
  final void Function() submited;
  final Function(int) onSelectedItemChanged;
  final List<Widget> selectableList;
  final Widget child;
  final bool showAlooButton;

  @override
  Widget build(BuildContext context) {
    if (showAlooButton) {
      selectableList.insert(
        0,
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Text(
            '全て',
            softWrap: false,
            overflow: TextOverflow.ellipsis,
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
