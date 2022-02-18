import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/record_list_view_provider.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/selector/marged_record_list_selector.dart';
import 'package:tcg_manager/state/input_view_state.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/component/custom_modal_list_picker.dart';
import 'package:tcg_manager/view/component/custom_modal_picker.dart';
import 'package:tcg_manager/view/component/custom_scaffold.dart';
import 'package:tcg_manager/view/component/fade_page_route.dart';
import 'package:tcg_manager/view/record_detail_view.dart';

class RecordListView extends HookConsumerWidget {
  const RecordListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordList = ref.watch(margedRecordListProvider).margedRecordList;
    final recordListNotifier = ref.read(allRecordListNotifierProvider.notifier);
    final isLoaded = ref.watch(allRecordListNotifierProvider.select((value) => value.isLoaded));

    return Column(
      children: [
        Expanded(
          child: CustomScaffold(
            rightButton: IconButton(
              icon: const Icon(Icons.filter_list),
              color: Colors.black,
              onPressed: () {
                showCupertinoModalBottomSheet(
                  expand: false,
                  context: context,
                  builder: (context) => const _FilterModalBottomSheet(),
                );
              },
            ),
            body: recordList!.isEmpty
                ? Center(child: Text(S.of(context).noDataMessage))
                : isLoaded
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF18204E),
                        ),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(height: 8, child: Divider(height: 1)),
                        itemCount: recordList.length,
                        itemBuilder: (context, index) {
                          return ProviderScope(
                            overrides: [
                              currentRecord.overrideWithValue(recordList[index]),
                            ],
                            child: Dismissible(
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              confirmDismiss: (direction) async {
                                final okCancelResult = await showOkCancelAlertDialog(
                                  context: context,
                                  message: S.of(context).deleteMessage,
                                  isDestructiveAction: true,
                                );
                                if (okCancelResult == OkCancelResult.ok) {
                                  return true;
                                } else {
                                  return false;
                                }
                              },
                              onDismissed: (direction) async {
                                await recordListNotifier.delete(recordList[index].recordId);
                              },
                              key: UniqueKey(),
                              child: const _BrandListTile(),
                            ),
                          );
                        }),
          ),
        ),
        const AdaptiveBannerAd(),
      ],
    );
  }
}

final currentRecord = Provider<MargedRecord>((ref) => MargedRecord(
      recordId: 0,
      game: '',
      useDeck: '',
      opponentDeck: '',
      tag: '',
      firstSecond: FirstSecond.first,
      winLoss: WinLoss.win,
      date: DateTime.now(),
    ));

class _BrandListTile extends HookConsumerWidget {
  const _BrandListTile({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final record = ref.watch(currentRecord);
    final outputFormat = DateFormat('yyyy年 MM月 dd日');

    return ListTile(
      trailing: Text(
        record.winLoss == WinLoss.win ? 'Win' : 'Loss',
        style: GoogleFonts.bangers(
          fontSize: 34,
          color: record.winLoss == WinLoss.win ? const Color(0xFFA21F16) : const Color(0xFF3547AC),
        ),
      ),
      subtitle: Hero(
        tag: 'date' + record.recordId.toString(),
        child: Material(
          color: Colors.transparent,
          child: Text(
            outputFormat.format(record.date),
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                S.of(context).listUseDeck,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                  leadingDistribution: TextLeadingDistribution.even,
                  height: 1,
                ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Hero(
                  tag: 'useDeck' + record.recordId.toString(),
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      record.useDeck,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        leadingDistribution: TextLeadingDistribution.even,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                S.of(context).listOpponentDeck,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                  leadingDistribution: TextLeadingDistribution.even,
                  height: 1,
                ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Hero(
                  tag: 'opponentDeck' + record.recordId.toString(),
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      record.opponentDeck,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        leadingDistribution: TextLeadingDistribution.even,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
      onTap: () async {
        await Navigator.push(
          context,
          FadePageRoute(
            fullscreenDialog: true,
            builder: (context) => ProviderScope(
              overrides: [currentRecord.overrideWithValue(record)],
              child: RecordDetailView(
                margedRecord: record,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _FilterModalBottomSheet extends HookConsumerWidget {
  const _FilterModalBottomSheet({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordListViewState = ref.watch(recordListViewNotifierProvider);
    final recordListViewNotifier = ref.watch(recordListViewNotifierProvider.notifier);
    final gameDeck = ref.watch(gameDeckListProvider);
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
              const Text(
                '並び替え',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  leadingDistribution: TextLeadingDistribution.even,
                  height: 1,
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(context).pop(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('新しい順'),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '日付',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  leadingDistribution: TextLeadingDistribution.even,
                  height: 1,
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 350,
                        child: CustomModalPicker(
                          child: SfDateRangePicker(
                            selectionMode: DateRangePickerSelectionMode.range,
                            view: DateRangePickerView.month,
                            showActionButtons: true,
                            minDate: DateTime(2000, 01, 01),
                            maxDate: DateTime.now(),
                            onSelectionChanged: (args) {},
                            onSubmit: (value) {
                              if (value is PickerDateRange) {
                                recordListViewNotifier.setStartDate(value.startDate!);
                                recordListViewNotifier.setEndDate(value.endDate!);
                                Navigator.pop(context);
                              }
                            },
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
                    children: const [
                      Text('全て'),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '使用デッキ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  leadingDistribution: TextLeadingDistribution.even,
                  height: 1,
                ),
              ),
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
              const SizedBox(height: 8),
              const Text(
                '対戦デッキ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  leadingDistribution: TextLeadingDistribution.even,
                  height: 1,
                ),
              ),
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
              const SizedBox(height: 8),
              const Text(
                'タグ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  leadingDistribution: TextLeadingDistribution.even,
                  height: 1,
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(context).pop(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('全て'),
                      Icon(Icons.arrow_drop_down),
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
    key,
  }) : super(key: key);
  final void Function() submited;
  final Function(int) onSelectedItemChanged;
  final List<Widget> selectableList;
  final Widget child;

  @override
  Widget build(BuildContext context) {
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
