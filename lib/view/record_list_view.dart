import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/helper/db_helper.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/selector/marged_record_list_selector.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
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
            // rightButton: IconButton(
            //   icon: const Icon(Icons.filter_list),
            //   color: Colors.black,
            //   onPressed: () {},
            // ),
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
                            overrides: [currentRecord.overrideWithValue(recordList[index])],
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
      firstSecond: true,
      winLoss: true,
      date: DateTime.now(),
    ));

class _BrandListTile extends HookConsumerWidget {
  const _BrandListTile({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final record = ref.watch(currentRecord);
    final recordListNotifier = ref.watch(allRecordListNotifierProvider.notifier);
    final outputFormat = DateFormat('yyyy年 MM月 dd日');

    return ListTile(
      trailing: Text(
        record.winLoss ? 'Win' : 'Loss',
        style: GoogleFonts.bangers(
          fontSize: 34,
          color: record.winLoss ? const Color(0xFFA21F16) : const Color(0xFF3547AC),
        ),
      ),
      subtitle: Text(
        outputFormat.format(record.date),
        style: const TextStyle(fontSize: 14, color: Colors.black54),
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
            builder: (context) => RecordDetailView(
              margedRecord: record,
            ),
          ),
        );
        recordListNotifier.changeIsLoaded();
        await ref.read(dbHelper).fetchAll();
        recordListNotifier.changeIsLoaded();
      },
    );
  }
}
