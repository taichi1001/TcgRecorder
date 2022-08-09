import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/enum/bo.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/helper/convert_sort_string.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/record_list_view_provider.dart';
import 'package:tcg_manager/repository/record_repository.dart';
import 'package:tcg_manager/selector/marged_record_list_selector.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/component/custom_scaffold.dart';
import 'package:tcg_manager/view/component/slidable_tile.dart';
import 'package:tcg_manager/view/filter_modal_bottom_sheet.dart';
import 'package:tcg_manager/view/record_edit_view.dart';

class RecordListView extends HookConsumerWidget {
  const RecordListView({Key? key}) : super(key: key);

  Map<String, List<MargedRecord>> _makeMap(List<MargedRecord>? recordList, BuildContext context) {
    final outputFormat = DateFormat(S.of(context).dateFormat);
    Map<String, List<MargedRecord>> result = {};
    if (recordList == null) return {};
    for (final record in recordList) {
      final date = outputFormat.format(record.date);
      if (!result.containsKey(date)) {
        result[date] = [record];
      } else {
        result[date] = result[date]!..add(record);
      }
    }
    return result;
  }

  List<Widget> _makeSliverList(BuildContext context, Map<String, List<MargedRecord>> list) {
    final List<Widget> result = [];
    list.forEach(
      (key, value) {
        result.add(
          SliverStickyHeader(
            header: Container(
              height: 30,
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text(key),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ProviderScope(
                  overrides: [
                    currentMargedRecord.overrideWithValue(list[key]![index]),
                  ],
                  child: const _BrandListTile(),
                ),
                childCount: list[key]!.length,
              ),
            ),
          ),
        );
      },
    );
    return result;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordList = ref.watch(margedRecordListProvider);
    final recordListViewNotifier = ref.read(recordListViewNotifierProvider.notifier);
    final sort = ref.watch(recordListViewNotifierProvider.select((value) => value.sort));

    return Column(
      children: [
        Expanded(
          child: CustomScaffold(
            padding: const EdgeInsets.all(0),
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
                  CupertinoButton(
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
            body: recordList.when(
              data: (recordList) {
                final recordMap = _makeMap(recordList, context);
                return recordList.isEmpty
                    ? Center(child: Text(S.of(context).noDataMessage))
                    : SlidableAutoCloseBehavior(
                        child: CustomScrollView(
                          slivers: _makeSliverList(context, recordMap),
                        ),
                      );
              },
              error: (error, stack) => Text('$error'),
              loading: () => const Center(child: CircularProgressIndicator()),
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
      bo: BO.bo1,
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
    final record = ref.watch(currentMargedRecord);
    final isMemo = record.memo != null && record.memo != '';
    final isImage = record.imagePaths != null && record.imagePaths != [];

    return SlidableExpansionTileCard(
      key: UniqueKey(),
      isExpansion: isMemo || record.bo == BO.bo3 || isImage,
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
                  record.tag ?? S.of(context).noTag,
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
        ],
      ),
      trailing: SizedBox(
        width: 130,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            isMemo ? const Icon(Icons.description) : const SizedBox(width: 24),
            Container(
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: record.bo == BO.bo1 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
              ),
              child: Center(
                child: Text(
                  record.bo == BO.bo1 ? 'BO1' : 'BO3',
                  style: Theme.of(context).primaryTextTheme.labelMedium?.copyWith(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                ),
              ),
            ),
            _FirstSecondIcon(firstSecond: record.firstSecond),
            _WinLossIcon(winLoss: record.winLoss),
          ],
        ),
      ),
      deleteFunc: () async {
        await ref.read(recordRepository).deleteById(record.recordId);
        ref.refresh(allRecordListProvider);
      },
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
        // ignore: use_build_context_synchronously
        await Slidable.of(context)?.close();
      },
      alertTitle: S.of(context).recordListDeleteDialogTitle,
      alertMessage: S.of(context).recordListDeleteDialogMessage,
      children: [
        FractionallySizedBox(
          widthFactor: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (record.bo == BO.bo3)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: _BO3MatchRow(
                      winLoss: record.firstMatchWinLoss,
                      firstSecond: record.firstMatchFirstSecond,
                      title: '1試合目:',
                    ),
                  ),
                if (record.bo == BO.bo3)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: _BO3MatchRow(
                      winLoss: record.secondMatchWinLoss,
                      firstSecond: record.secondMatchFirstSecond,
                      title: '2試合目:',
                    ),
                  ),
                if (record.bo == BO.bo3)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: _BO3MatchRow(
                      winLoss: record.thirdMatchWinLoss,
                      firstSecond: record.thirdMatchFirstSecond,
                      title: '3試合目:',
                    ),
                  ),
                if (isMemo)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).recordListMemo,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                leadingDistribution: TextLeadingDistribution.even,
                                height: 1,
                                fontSize: 10,
                              ),
                        ),
                        Flexible(
                          child: Text(
                            record.memo ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 100,
                            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                  leadingDistribution: TextLeadingDistribution.even,
                                  height: 1,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (isImage)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...record.imagePaths!.map(
                          (image) => SizedBox(
                            width: 80,
                            height: 80,
                            child: Image.file(
                              File(image),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8)
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

class _FirstSecondIcon extends StatelessWidget {
  const _FirstSecondIcon({
    required this.firstSecond,
    this.width = 24,
    this.height = 24,
    this.fontSize = 12,
    Key? key,
  }) : super(key: key);
  final FirstSecond firstSecond;
  final double width;
  final double height;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: firstSecond == FirstSecond.first ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
      ),
      child: Center(
        child: Text(
          firstSecond == FirstSecond.first ? S.of(context).recordListFirst : S.of(context).recordListSecond,
          style: Theme.of(context).primaryTextTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1,
                fontSize: fontSize,
              ),
        ),
      ),
    );
  }
}

class _WinLossIcon extends StatelessWidget {
  const _WinLossIcon({
    required this.winLoss,
    this.height = 30,
    this.width = 45,
    this.fontSize = 22,
    Key? key,
  }) : super(key: key);

  final WinLoss winLoss;
  final double height;
  final double width;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(6),
        color: winLoss == WinLoss.win
            ? const Color(0xFFA21F16)
            : winLoss == WinLoss.loss
                ? const Color(0xFF3547AC)
                : Colors.grey,
      ),
      child: Center(
        child: Text(
          winLoss == WinLoss.win
              ? 'Win'
              : winLoss == WinLoss.loss
                  ? 'Loss'
                  : 'Draw',
          style: GoogleFonts.bangers(
            fontSize: fontSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _BO3MatchRow extends StatelessWidget {
  const _BO3MatchRow({
    required this.winLoss,
    required this.firstSecond,
    required this.title,
    Key? key,
  }) : super(key: key);

  final WinLoss? winLoss;
  final FirstSecond? firstSecond;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 10),
          ),
          if (winLoss == null)
            const SizedBox(
              height: 16,
              width: 30,
              child: Text('-'),
            ),
          if (firstSecond != null)
            _FirstSecondIcon(
              firstSecond: firstSecond!,
              width: 16,
              height: 16,
              fontSize: 9,
            ),
          if (winLoss != null)
            _WinLossIcon(
              winLoss: winLoss!,
              height: 16,
              width: 30,
              fontSize: 12,
            ),
        ],
      ),
    );
  }
}
