import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/helper/convert_sort_string.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/record_list_view_provider.dart';
import 'package:tcg_manager/selector/marged_record_list_selector.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/component/custom_scaffold.dart';
import 'package:tcg_manager/view/component/slidable_tile.dart';
import 'package:tcg_manager/view/filter_modal_bottom_sheet.dart';
import 'package:tcg_manager/view/record_detail_view.dart';

class RecordListView extends HookConsumerWidget {
  const RecordListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordList = ref.watch(margedRecordListProvider).margedRecordList;
    final recordListViewNotifier = ref.read(recordListViewNotifierProvider.notifier);
    final sort = ref.watch(recordListViewNotifierProvider.select((value) => value.sort));
    final isLoaded = ref.watch(allRecordListNotifierProvider.select((value) => value.isLoaded));
    return Column(
      children: [
        Expanded(
          child: CustomScaffold(
            rightButton: IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                showCupertinoModalBottomSheet(
                  expand: false,
                  context: context,
                  builder: (context) => const FilterModalBottomSheet(showSort: false),
                );
              },
            ),
            appBarBottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      recordListViewNotifier.toggleSort();
                    },
                    child: Text(
                      ConvertSortString.convert(context, sort),
                      style: Theme.of(context).primaryTextTheme.bodyText2,
                    ),
                  ),
                ],
              ),
            ),
            body: recordList!.isEmpty
                ? Center(child: Text(S.of(context).noDataMessage))
                : isLoaded
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(height: 8, child: Divider(height: 1)),
                          itemCount: recordList.length,
                          itemBuilder: (context, index) {
                            return ProviderScope(
                              overrides: [
                                currentRecord.overrideWithValue(recordList[index]),
                              ],
                              child: const _BrandListTile(),
                            );
                          },
                        ),
                      ),
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
    final recordListNotifier = ref.read(allRecordListNotifierProvider.notifier);
    final record = ref.watch(currentRecord);
    final outputFormat = DateFormat('yyyy年 MM月 dd日');

    return SlidableTile(
      key: UniqueKey(),
      trailing: Text(
        record.winLoss == WinLoss.win ? 'Win' : 'Loss',
        style: GoogleFonts.bangers(
          fontSize: 34,
          color: record.winLoss == WinLoss.win ? const Color(0xFFA21F16) : const Color(0xFF3547AC),
        ),
      ),
      subtitle: Text(
        outputFormat.format(record.date),
        style: Theme.of(context).textTheme.overline,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).listUseDeck,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      leadingDistribution: TextLeadingDistribution.even,
                      height: 1,
                      fontSize: 10,
                    ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  record.useDeck,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        leadingDistribution: TextLeadingDistribution.even,
                        height: 1,
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
                style: Theme.of(context).textTheme.caption?.copyWith(
                      leadingDistribution: TextLeadingDistribution.even,
                      height: 1,
                      fontSize: 10,
                    ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  record.opponentDeck,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        leadingDistribution: TextLeadingDistribution.even,
                        height: 1,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
      deleteFunc: () async => await recordListNotifier.delete(record.recordId),
      alertMessage: '',
      alertTitle: '',
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
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
