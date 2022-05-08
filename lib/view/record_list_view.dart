import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
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
              preferredSize: const Size.fromHeight(30),
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
                    : SlidableAutoCloseBehavior(
                        child: ListView.builder(
                          itemCount: recordList.length,
                          itemBuilder: (context, index) {
                            // if (index % 5 == 0 && index != 0) return const AdaptiveBannerAd();
                            return ProviderScope(
                              overrides: [
                                currentMargedRecord.overrideWithValue(recordList[index]),
                              ],
                              child: Padding(
                                padding: index == recordList.length - 1 // 最後の要素だった場合
                                    ? const EdgeInsets.only(top: 8, bottom: 8)
                                    : const EdgeInsets.only(top: 8),
                                // 広告挟むようにするときコメントアウト

                                // child: index % 1 == 0 && index != 0
                                //     ? Column(
                                //         children: [
                                //           const AdaptiveBannerAd(),
                                //           const SizedBox(
                                //             height: 8,
                                //           ),
                                //           const _BrandListTile(),
                                //         ],
                                //       )
                                //     : const _BrandListTile(),
                                child: const _BrandListTile(),
                              ),
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

final currentMargedRecord = Provider<MargedRecord>((ref) => MargedRecord(
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
    final record = ref.watch(currentMargedRecord);
    final outputFormat = DateFormat('yyyy年 MM月 dd日');
    final isMemo = record.memo != null && record.memo != '';
    return SlidableExpansionTileCard(
      key: UniqueKey(),
      isExpansion: isMemo,
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
          const SizedBox(height: 8),
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
          Row(
            children: [
              Icon(
                Icons.tag,
                size: 12,
                color: Theme.of(context).textTheme.caption?.color!,
              ),
              Flexible(
                child: Text(
                  record.tag ?? 'aa',
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
          // const SizedBox(height: 8),
          // Text(
          //   outputFormat.format(record.date),
          //   style: Theme.of(context).textTheme.overline,
          // ),
        ],
      ),
      trailing: SizedBox(
        width: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            isMemo ? const Icon(Icons.description) : const SizedBox(width: 24),
            Container(
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: Text(
                  record.firstSecond == FirstSecond.first ? '先' : '後',
                  style: Theme.of(context).primaryTextTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                ),
              ),
            ),
            Container(
              width: 45,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(6),
                color: record.winLoss == WinLoss.win ? const Color(0xFFA21F16) : const Color(0xFF3547AC),
              ),
              child: Center(
                child: Text(
                  record.winLoss == WinLoss.win ? 'Win' : 'Loss',
                  style: GoogleFonts.bangers(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      deleteFunc: () async => await recordListNotifier.delete(record.recordId),
      editFunc: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => ProviderScope(
              overrides: [currentMargedRecord.overrideWithValue(record)],
              child: RecordEditView(
                margedRecord: record,
              ),
            ),
          ),
        );
        await Slidable.of(context)?.close();
      },
      alertMessage: '',
      alertTitle: '',
      children: [
        FractionallySizedBox(
          widthFactor: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(record.memo ?? ''),
          ),
        ),
      ],
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => ProviderScope(
              overrides: [currentMargedRecord.overrideWithValue(record)],
              child: RecordEditView(
                margedRecord: record,
              ),
            ),
          ),
        );
      },
    );
  }
}
