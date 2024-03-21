import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/opponent_deck_data_by_game_provider.dart';
import 'package:tcg_manager/provider/public_data_by_game_provider.dart';
import 'package:tcg_manager/provider/use_deck_data_by_game_provider.dart';
import 'package:tcg_manager/view/data_view/data_view.dart';

class DeckUseRateChart extends HookConsumerWidget {
  const DeckUseRateChart({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAggregate = ref.watch(isAggregatedDataProvider);
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (!isAggregate) const _UseDeckUseRateChart(),
              if (!isAggregate) const _OpponentDeckUseRateChart(),
              if (isAggregate) const _PublicDataUseRateChart(),
            ],
          ),
        ),
      ],
    );
  }
}

class _UseDeckUseRateChart extends HookConsumerWidget {
  const _UseDeckUseRateChart({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winRateData = ref.watch(useDeckDataByGameProvider);
    return winRateData.when(
      data: (data) => data.isEmpty
          ? Center(child: Text(S.of(context).noDataMessage))
          : _UseRateChart(data: data, title: S.of(context).useDeckDistribution),
      error: (error, stack) => Text(error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _OpponentDeckUseRateChart extends HookConsumerWidget {
  const _OpponentDeckUseRateChart({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winRateData = ref.watch(opponentDeckDataByGameProvider);
    return winRateData.when(
      data: (data) => data.isEmpty
          ? Center(child: Text(S.of(context).noDataMessage))
          : _UseRateChart(data: data, title: S.of(context).opponentDeckDistribution),
      error: (error, stack) => Text(error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _PublicDataUseRateChart extends HookConsumerWidget {
  const _PublicDataUseRateChart({
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winRateData = ref.watch(publicUseRateProvider);
    return winRateData.when(
      data: (data) {
        if (data.isEmpty) return Center(child: Text(S.of(context).noDataMessage));
        return _UseRateChart(data: data, title: S.of(context).useDeckDistribution);
      },
      error: (error, stack) => Text(error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
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
