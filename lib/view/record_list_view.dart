import 'dart:io';
import 'dart:ui' as ui;

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/enum/access_roll.dart';
import 'package:tcg_manager/enum/bo.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/helper/convert_sort_string.dart';
import 'package:tcg_manager/helper/db_helper.dart';
import 'package:tcg_manager/main.dart';
import 'package:tcg_manager/provider/backup_provider.dart';
import 'package:tcg_manager/provider/firestore_backup_controller_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/record_list_view_provider.dart';
import 'package:tcg_manager/provider/select_game_access_roll.dart';
import 'package:tcg_manager/repository/firestore_share_data_repository.dart';
import 'package:tcg_manager/repository/record_repository.dart';
import 'package:tcg_manager/selector/game_record_list_selector.dart';
import 'package:tcg_manager/selector/game_share_data_selector.dart';
import 'package:tcg_manager/selector/marged_record_list_selector.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/component/custom_scaffold.dart';
import 'package:tcg_manager/view/component/slidable_tile.dart';
import 'package:tcg_manager/view/edit_view/record_edit_view.dart';
import 'package:tcg_manager/view/filter_modal_bottom_sheet.dart';

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

  List<Widget> _makeScreenshotWidget(BuildContext context, Map<String, List<MargedRecord>> map) {
    final List<Widget> result = [];
    map.forEach((key, value) {
      result.add(
        Container(
          height: 30,
          color: Theme.of(context).colorScheme.surface,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          child: Text(key),
        ),
      );
      map[key]?.forEach(
        (element) {
          result.add(
            ProviderScope(
              overrides: [
                currentMargedRecord.overrideWithValue(element),
              ],
              child: const _BrandListTile(),
            ),
          );
        },
      );
    });

    return result;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordList = ref.watch(margedRecordListProvider);
    final recordListViewNotifier = ref.read(recordListViewNotifierProvider.notifier);
    final sort = ref.watch(recordListViewNotifierProvider.select((value) => value.sort));
    final isScreenshot = useState(false);
    final globalKey = GlobalKey();

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    onPressed: () {
                      recordListViewNotifier.toggleSort();
                    },
                    child: Text(
                      ConvertSortString.convert(context, sort),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      isScreenshot.value = true;
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        RenderRepaintBoundary? boundary;
                        boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
                        boundary ??=
                            globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?; // なぜか1回目でエラーが出るためリトライしている。理由は不明
                        if (boundary == null) return;
                        final captureImage = await boundary.toImage(pixelRatio: 3);
                        final byteData = await captureImage.toByteData(format: ui.ImageByteFormat.png);
                        final pngBytes = byteData!.buffer.asUint8List();

                        Directory tempDir = await getTemporaryDirectory();
                        String filePath = '${tempDir.path}/captured_image.png';

                        // ファイルにPNGデータを書き込み
                        File file = File(filePath);
                        await file.writeAsBytes(pngBytes);
                        await Share.shareXFiles([XFile(filePath)], text: '共有する画像');

                        isScreenshot.value = true;
                      });
                    },
                    icon: const Icon(Icons.camera_alt),
                  ),
                ],
              ),
            ),
            body: recordList.when(
              data: (recordList) {
                final recordMap = _makeMap(recordList, context);
                return recordList.isEmpty
                    ? Center(child: Text(S.of(context).noDataMessage))
                    : !isScreenshot.value
                        ? SlidableAutoCloseBehavior(
                            child: CustomScrollView(
                              slivers: _makeSliverList(context, recordMap),
                            ),
                          )
                        : SingleChildScrollView(
                            child: RepaintBoundary(
                              key: globalKey,
                              child: Container(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                child: Column(
                                  children: _makeScreenshotWidget(context, recordMap),
                                ),
                              ),
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
      record: Record(),
      game: '',
      useDeck: '',
      opponentDeck: '',
      tag: [],
      bo: BO.bo1,
      firstSecond: FirstSecond.first,
      winLoss: WinLoss.win,
      date: DateTime.now(),
    ));

class _BrandListTile extends HookConsumerWidget {
  const _BrandListTile({
    key,
  }) : super(key: key);

  double _makeWidth(bool isImage, bool isMemo) {
    if (isImage && isMemo) return 154;
    if (isImage || isMemo) return 130;
    return 106;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final record = ref.watch(currentMargedRecord);
    final imagePath = ref.watch(imagePathProvider);
    final isMemo = record.memo != null && record.memo != '';
    final isImage = record.imagePaths != null && record.imagePaths != [];
    final isShare = ref.watch(isShareGame);

    return SlidableExpansionTileCard(
      key: UniqueKey(),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).listUseDeck,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        leadingDistribution: TextLeadingDistribution.even,
                        height: 1,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _TagIcons(margedRecord: record),
        ],
      ),
      trailing: SizedBox(
        width: _makeWidth(isImage, isMemo),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (isImage) const Icon(Icons.image),
            if (isMemo) const Icon(Icons.description),
            Container(
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: record.bo == BO.bo1 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.tertiary,
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
        if (ref.read(isShareGame)) {
          final accessRoll = await ref.read(selectGameAccessRoll.future);
          if (context.mounted && accessRoll == AccessRoll.reader) {
            await showOkAlertDialog(
              context: context,
              title: '権限がありません。',
              message: 'この操作をする権限がありません。ゲームの管理者にお問い合わせください。',
            );
          } else {
            final gameRecordList = await ref.watch(gameRecordListProvider.future);
            final targetRecord = gameRecordList.firstWhere((gameRecord) => gameRecord.id == record.record.id);
            final share = await ref.read(gameFirestoreShareStreamProvider.future);
            ref.read(firestoreShareDataRepository).removeRecord(targetRecord, share!.docName);
          }
        } else {
          final targetRecord = await ref.read(recordRepository).getRecordId(record.record.id!);
          ref.read(dbHelper).removeRecordImage(targetRecord!);
          await ref.read(recordRepository).delete(targetRecord);
          ref.invalidate(allRecordListProvider);
          if (ref.read(backupNotifierProvider)) await ref.read(firestoreBackupControllerProvider).deleteRecord(targetRecord);
        }
      },
      editFunc: () async {
        final accessRoll = await ref.read(selectGameAccessRoll.future);
        if (context.mounted && accessRoll == AccessRoll.reader) {
          await showOkAlertDialog(
            context: context,
            title: '権限がありません。',
            message: 'この操作をする権限がありません。ゲームの管理者にお問い合わせください。',
          );
        } else if (context.mounted) {
          // recordによってtagの個数が違うため、画面遷移前のここで設定する
          ref.read(originalTagLength.notifier).state = record.tag.isEmpty ? 1 : record.tag.length;
          ref.read(originalTag.notifier).state = record.tag;
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
          if (context.mounted) await Slidable.of(context)?.close();
        }
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
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                        ...record.imagePaths!.asMap().entries.map(
                              (image) => GestureDetector(
                                onTap: () {
                                  final customImageProvider = CustomImageProvider(
                                    imageUrls: isShare
                                        ? [...record.imagePaths!].toList()
                                        : [
                                            ...record.imagePaths!.map((image) => '$imagePath/$image'),
                                          ].toList(),
                                    ref: ref,
                                    initialIndex: image.key,
                                  );
                                  showImageViewerPager(
                                    context,
                                    customImageProvider,
                                    swipeDismissible: true,
                                    useSafeArea: true,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: isShare
                                        ? CachedNetworkImage(imageUrl: image.value)
                                        : Image.file(
                                            File('$imagePath/${image.value}'),
                                            fit: BoxFit.contain,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
                const _EditDeleteButtonRow()
              ],
            ),
          ),
        ),
        const SizedBox(height: 8)
      ],
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
        color: firstSecond == FirstSecond.first ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.tertiary,
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

class _TagIcons extends StatelessWidget {
  const _TagIcons({
    required this.margedRecord,
  });

  final MargedRecord margedRecord;

  @override
  Widget build(BuildContext context) {
    if (margedRecord.tag.isEmpty) {
      return Text(
        S.of(context).noTag,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              leadingDistribution: TextLeadingDistribution.even,
              height: 1,
              fontSize: 11,
            ),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: margedRecord.tag.map((tag) {
          return Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Text(
                tag,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).primaryTextTheme.bodyMedium?.copyWith(
                      leadingDistribution: TextLeadingDistribution.even,
                      height: 1,
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
            ),
          );
        }).toList(),
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
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
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

class CustomImageProvider extends EasyImageProvider {
  @override
  final int initialIndex;
  final List<String> imageUrls;
  final WidgetRef ref;

  CustomImageProvider({required this.imageUrls, required this.ref, this.initialIndex = 0}) : super();

  @override
  ImageProvider<Object> imageBuilder(BuildContext context, int index) {
    if (ref.read(isShareGame)) {
      return CachedNetworkImageProvider(imageUrls[index]);
    } else {
      return Image.file(File(imageUrls[index])).image;
    }
  }

  @override
  int get imageCount => imageUrls.length;
}

class _EditDeleteButtonRow extends HookConsumerWidget {
  const _EditDeleteButtonRow();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final record = ref.watch(currentMargedRecord);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size.fromHeight(32)),
              ),
              onPressed: () async {
                final accessRoll = await ref.read(selectGameAccessRoll.future);
                if (context.mounted && accessRoll == AccessRoll.reader) {
                  await showOkAlertDialog(
                    context: context,
                    title: '権限がありません。',
                    message: 'この操作をする権限がありません。ゲームの管理者にお問い合わせください。',
                  );
                } else if (context.mounted) {
                  // recordによってtagの個数が違うため、画面遷移前のここで設定する
                  ref.read(originalTagLength.notifier).state = record.tag.isEmpty ? 1 : record.tag.length;
                  ref.read(originalTag.notifier).state = record.tag;
                  Navigator.push(
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
                }
              },
              child: const Text('編集'),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size.fromHeight(32)),
                backgroundColor: MaterialStateColor.resolveWith((states) => Theme.of(context).colorScheme.error),
              ),
              onPressed: () async {
                final accessRoll = await ref.read(selectGameAccessRoll.future);
                if (context.mounted && accessRoll == AccessRoll.reader) {
                  await showOkAlertDialog(
                    context: context,
                    title: '権限がありません。',
                    message: 'この操作をする権限がありません。ゲームの管理者にお問い合わせください。',
                  );
                } else if (context.mounted) {
                  if (ref.read(isShareGame)) {
                    final gameRecordList = await ref.watch(gameRecordListProvider.future);
                    final targetRecord = gameRecordList.firstWhere((gameRecord) => gameRecord.id == record.record.id);
                    final share = await ref.read(gameFirestoreShareStreamProvider.future);
                    ref.read(firestoreShareDataRepository).removeRecord(targetRecord, share!.docName);
                  } else {
                    final targetRecord = await ref.read(recordRepository).getRecordId(record.record.id!);
                    ref.read(dbHelper).removeRecordImage(targetRecord!);
                    await ref.read(recordRepository).delete(targetRecord);
                    ref.invalidate(allRecordListProvider);
                    if (ref.read(backupNotifierProvider)) await ref.read(firestoreBackupControllerProvider).deleteRecord(targetRecord);
                  }
                }
              },
              child: const Text('削除'),
            ),
          ),
        ),
      ],
    );
  }
}
