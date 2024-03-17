import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/graph_view_settings_provider.dart';
import 'package:tcg_manager/provider/opponent_deck_data_by_game_provider.dart';
import 'package:tcg_manager/provider/use_deck_data_by_game_provider.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/component/custom_scaffold.dart';
import 'package:tcg_manager/view/data_grid.dart';
import 'package:tcg_manager/view/filter_modal_bottom_sheet.dart';

final isAggregatedDataProvider = StateProvider.autoDispose<bool>((ref) => false);

class GraphView extends HookConsumerWidget {
  const GraphView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useDeckDataByGame = ref.watch(useDeckDataByGameProvider);
    final isAggregatedData = ref.watch(isAggregatedDataProvider);
    final useDeckData = ref.watch(useDeckDataByGameProvider);
    final opponentDeckData = ref.watch(opponentDeckDataByGameProvider);
    final currentIndex = useState(0);
    final pageController = usePageController(initialPage: currentIndex.value);
    return CustomScaffold(
      leading: IconButton(
        icon: const Icon(Icons.tune),
        onPressed: () {
          showCupertinoModalBottomSheet(
            expand: false,
            context: context,
            builder: (context) => const _SettingModalBottomSheet(),
          );
        },
      ),
      rightButton: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.public,
              color: isAggregatedData ? Theme.of(context).colorScheme.primary : null,
            ),
            onPressed: () => ref.read(isAggregatedDataProvider.notifier).state = !isAggregatedData,
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              showCupertinoModalBottomSheet(
                expand: false,
                context: context,
                builder: (context) => const FilterModalBottomSheet(
                  showSort: false,
                  showUseDeck: false,
                ),
              );
            },
          ),
        ],
      ),
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      body: useDeckDataByGame.when(
        data: (recordList) {
          return Column(
            children: [
              const SizedBox(height: 12),
              CupertinoSlidingSegmentedControl(
                children: {
                  0: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.table_rows, size: 20),
                      const SizedBox(width: 8),
                      Text('使用デッキ', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  1: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.table_rows, size: 20),
                      const SizedBox(width: 8),
                      Text('対戦デッキ', style: Theme.of(context).textTheme.bodySmall)
                    ],
                  ),
                  2: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.pie_chart, size: 20),
                      const SizedBox(width: 8),
                      Text('デッキ使用率', style: Theme.of(context).textTheme.bodySmall)
                    ],
                  ),
                },
                onValueChanged: (int? index) {
                  if (index == null) return;
                  currentIndex.value = index;
                  pageController.jumpToPage(index);
                },
                groupValue: currentIndex.value,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    currentIndex.value = index;
                  },
                  children: [
                    Center(
                      child: recordList.isEmpty
                          ? Text(S.of(context).noDataMessage)
                          : const Column(
                              children: [
                                Expanded(child: UseDeckGameDataGrid()),
                                AdaptiveBannerAd(),
                              ],
                            ),
                    ),
                    Center(
                      child: recordList.isEmpty
                          ? Text(S.of(context).noDataMessage)
                          : const Column(
                              children: [
                                Expanded(child: OpponentDeckGameDataGrid()),
                                AdaptiveBannerAd(),
                              ],
                            ),
                    ),
                    recordList.isEmpty
                        ? Center(child: Text(S.of(context).noDataMessage))
                        : Column(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    useDeckData.when(
                                      data: (useDeckData) {
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                                          child: _UseRateChart(
                                            data: useDeckData,
                                            title: S.of(context).useDeckDistribution,
                                          ),
                                        );
                                      },
                                      error: (error, stack) => Text('$error'),
                                      loading: () => const Center(child: CircularProgressIndicator()),
                                    ),
                                    const SizedBox(height: 16),
                                    opponentDeckData.when(
                                      data: (opponentDeckData) {
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                                          child: _UseRateChart(
                                            data: opponentDeckData,
                                            title: S.of(context).opponentDeckDistribution,
                                          ),
                                        );
                                      },
                                      error: (error, stack) => Text('$error'),
                                      loading: () => const Center(child: CircularProgressIndicator()),
                                    ),
                                  ],
                                ),
                              ),
                              const AdaptiveBannerAd(),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          );
        },
        error: (error, stack) => Text('$error'),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _UseRateChart extends StatelessWidget {
  const _UseRateChart({
    required this.data,
    required this.title,
    key,
  }) : super(key: key);

  final List<WinRateData> data;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Card(
          margin: EdgeInsets.zero,
          child: SizedBox(
            height: 250.h,
            child: SfCircularChart(
              margin: const EdgeInsets.all(0),
              onLegendItemRender: (args) {
                if (args.text == 'Others') {
                  args.text = 'その他';
                }
              },
              legend: Legend(
                width: '30%',
                isVisible: true,
                itemPadding: 8,
                overflowMode: LegendItemOverflowMode.scroll,
                textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
              ),
              annotations: [
                CircularChartAnnotation(
                  widget: Text(
                    title,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
              onTooltipRender: (args) {
                // args.textの中身は test : 0.333 みたいな形で入ってる
                final reg = RegExp('^.* '); // test : を抽出する正規表現
                var firstString = reg.firstMatch(args.text!)!.group(0)!;
                final secondString = args.text!.replaceAll(firstString, '');
                if (firstString.contains('Others')) firstString = 'その他 : ';
                final doubleArgs = double.parse(secondString);
                args.text = '$firstString${(doubleArgs * 100).toStringAsFixed(1)}%';
              },
              tooltipBehavior: TooltipBehavior(enable: true),
              series: [
                DoughnutSeries<WinRateData, String>(
                  dataSource: data,
                  animationDuration: 0,
                  sortingOrder: SortingOrder.descending,
                  enableTooltip: true,
                  sortFieldValueMapper: (data, index) => data.useRate.toString(),
                  xValueMapper: (data, index) => data.deck,
                  yValueMapper: (data, index) => data.useRate,
                  groupMode: CircularChartGroupMode.point,
                  groupTo: 5,
                  innerRadius: '60%',
                ),
              ],
            ),
          ),
        ),
        // IconButton(
        //   icon: const Icon(Icons.launch),
        //   onPressed: () => Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => _UseRateDetailChart(data: data, title: title),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

// ignore: unused_element
class _UseRateDetailChart extends HookConsumerWidget {
  const _UseRateDetailChart({
    required this.data,
    required this.title,
    key,
  }) : super(key: key);

  final List<WinRateData> data;
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: Center(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(
            labelAlignment: LabelAlignment.center,
            maximumLabels: 2,
            labelsExtent: 80,
            labelStyle: Theme.of(context).primaryTextTheme.bodySmall?.copyWith(fontSize: 10),
          ),
          primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.percentPattern(),
          ),
          series: [
            BarSeries<WinRateData, String>(
              dataSource: data,
              xValueMapper: (data, index) => data.deck,
              yValueMapper: (data, index) => data.useRate,
              width: 0.2,
              spacing: 0.3,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ],
          tooltipBehavior: TooltipBehavior(
            enable: true,
            header: 'デッキ名',
          ),
        ),
      ),
    );
  }
}

class _SettingModalBottomSheet extends HookConsumerWidget {
  const _SettingModalBottomSheet({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final graphViewSettings = ref.watch(graphViewSettingsNotifierProvider);
    final graphViewSettingsController = ref.watch(graphViewSettingsNotifierProvider.notifier);
    return Material(
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                  child: Text(
                    '表示項目オプション',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  title: Text(
                    '試合数',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: graphViewSettings.matches,
                  onChanged: graphViewSettingsController.changeMatches,
                ),
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  title: Text(
                    '先攻試合数',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: graphViewSettings.firstMatches,
                  onChanged: graphViewSettingsController.changeFirstMatches,
                ),
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  title: Text(
                    '後攻試合数',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: graphViewSettings.secondMatches,
                  onChanged: graphViewSettingsController.changeSecondMatches,
                ),
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  title: Text(
                    '勝ち数',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: graphViewSettings.win,
                  onChanged: graphViewSettingsController.changeWin,
                ),
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  title: Text(
                    '負け数',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: graphViewSettings.loss,
                  onChanged: graphViewSettingsController.changeLoss,
                ),
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  title: Text(
                    '引き分け数',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: graphViewSettings.draw,
                  onChanged: graphViewSettingsController.changeDraw,
                ),
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  title: Text(
                    '先攻勝ち数',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: graphViewSettings.firstMatchesWin,
                  onChanged: graphViewSettingsController.changeFirstMatchesWin,
                ),
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  title: Text(
                    '先攻負け数',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: graphViewSettings.firstMatchesLoss,
                  onChanged: graphViewSettingsController.changeFirstMatchesLoss,
                ),
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  title: Text(
                    '先攻引き分け数',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: graphViewSettings.firstMatchesDraw,
                  onChanged: graphViewSettingsController.changeFirstMatchesDraw,
                ),
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  title: Text(
                    '後攻勝ち数',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: graphViewSettings.secondMatchesWin,
                  onChanged: graphViewSettingsController.changeSecondMatchesWin,
                ),
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  title: Text(
                    '後攻負け数',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: graphViewSettings.secondMatchesLoss,
                  onChanged: graphViewSettingsController.changeSecondMatchesLoss,
                ),
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  title: Text(
                    '後攻引き分け数',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: graphViewSettings.secondMatchesDraw,
                  onChanged: graphViewSettingsController.changeSecondMatchesDraw,
                ),
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  title: Text(
                    '勝率',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: graphViewSettings.winRate,
                  onChanged: graphViewSettingsController.changeWinRate,
                ),
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  title: Text(
                    '先攻勝率',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: graphViewSettings.firstWinRate,
                  onChanged: graphViewSettingsController.changeFirstWinRate,
                ),
                SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  title: Text(
                    '後攻勝率',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  value: graphViewSettings.secondWinRate,
                  onChanged: graphViewSettingsController.changeSecondWinRate,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
