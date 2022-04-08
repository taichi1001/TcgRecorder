import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/provider/game_win_rate_data_provider.dart';
import 'package:tcg_manager/selector/game_record_list_selector.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/component/custom_scaffold.dart';
import 'package:tcg_manager/view/filter_modal_bottom_sheet.dart';
import 'package:tcg_manager/view/game_data_grid.dart';

class GraphView extends HookConsumerWidget {
  const GraphView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordList = ref.watch(gameRecordListProvider);
    final data = ref.watch(gameWinRateDataNotifierProvider).winRateDataList;
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
        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
        appBarBottom: TabBar(
          indicator: MaterialIndicator(
            horizontalPadding: 16,
            height: 3,
          ),
          tabs: const [
            Tab(
              icon: Icon(
                Icons.table_rows,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.pie_chart_outline,
              ),
            )
          ],
        ),
        body: TabBarView(
          children: [
            Center(
              child: recordList.isEmpty
                  ? Center(child: Text(S.of(context).noDataMessage))
                  : Column(
                      children: const [
                        Expanded(child: GameDataGrid()),
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
                          children: [
                            SfCircularChart(
                              legend: Legend(
                                isVisible: true,
                              ),
                              series: [
                                PieSeries<WinRateData, String>(
                                  dataSource: data,
                                  xValueMapper: (data, index) => data.deck,
                                  yValueMapper: (data, index) => data.useRate,
                                ),
                              ],
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
