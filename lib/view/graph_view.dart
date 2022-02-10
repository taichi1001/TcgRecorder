import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:tcg_manager/generated/l10n.dart';
import 'package:tcg_manager/selector/game_record_list_selector.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/component/custom_scaffold.dart';
import 'package:tcg_manager/view/game_data_grid.dart';

class GraphView extends HookConsumerWidget {
  const GraphView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordList = ref.watch(gameRecordListNotifierProvider.select((value) => value.gameRecordList));
    return DefaultTabController(
      length: 2,
      child: CustomScaffold(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
        appBarBottom: TabBar(
          labelColor: const Color(0xFF18204E),
          unselectedLabelColor: Colors.black38,
          indicator: MaterialIndicator(
            color: const Color(0xFF18204E),
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
              child: recordList!.isEmpty
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(S.of(context).nextFunctionAnnounce1),
                            Text(S.of(context).nextFunctionAnnounce2),
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
