import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/opponent_deck_data_by_game_provider.dart';
import 'package:tcg_manager/provider/use_deck_data_by_game_provider.dart';
import 'package:tcg_manager/selector/filter_record_list_selector.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/component/custom_scaffold.dart';
import 'package:tcg_manager/view/filter_modal_bottom_sheet.dart';
import 'package:tcg_manager/view/game_data_grid.dart';

class GraphView extends HookConsumerWidget {
  const GraphView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordList = ref.watch(filterRecordListProvider);
    final useDeckData = ref.watch(useDeckDataByGameProvider);
    final opponentDeckData = ref.watch(opponentDeckDataByGameProvider);
    return DefaultTabController(
      length: 2,
      child: CustomScaffold(
        rightButton: IconButton(
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
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        appBarBottom: TabBar(
          indicator: MaterialIndicator(
            horizontalPadding: 16,
            height: 3,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          tabs: const [
            Tab(icon: Icon(Icons.table_rows)),
            Tab(icon: Icon(Icons.pie_chart_outline)),
          ],
        ),
        body: TabBarView(
          children: [
            Center(
              child: recordList.isEmpty
                  ? Text(S.of(context).noDataMessage)
                  : Column(
                      children: const [
                        Expanded(child: GameDataGrid()),
                        AdaptiveBannerAd(),
                      ],
                    ),
            ),
            recordList.isEmpty
                ? Text(S.of(context).noDataMessage)
                : Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                              child: _UseRateChart(
                                data: useDeckData,
                                title: S.of(context).useDeckDistribution,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                              child: _UseRateChart(
                                data: opponentDeckData,
                                title: S.of(context).opponentDeckDistribution,
                              ),
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => _UseRateDetailChart(data: data, title: title),
          ),
        );
      },
      child: Card(
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
              textStyle: Theme.of(context).textTheme.caption?.copyWith(fontSize: 10),
            ),
            annotations: [
              CircularChartAnnotation(
                widget: Text(
                  title,
                  style: Theme.of(context).textTheme.overline?.copyWith(
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
    );
  }
}

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
      appBar: AppBar(),
      body: Center(
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          series: [
            BarSeries<WinRateData, String>(
              dataSource: data,
              xValueMapper: (data, index) => data.deck,
              yValueMapper: (data, index) => data.useRate,
              width: 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
