import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tcg_manager/provider/graph_view_settings_provider.dart';
import 'package:tcg_manager/view/component/adaptive_banner_ad.dart';
import 'package:tcg_manager/view/component/custom_scaffold.dart';
import 'package:tcg_manager/view/data_view/data_grid_page.dart';
import 'package:tcg_manager/view/filter_modal_bottom_sheet.dart';
import 'package:tcg_manager/view/data_view/win_rate_page.dart';

final isAggregatedDataProvider = StateProvider.autoDispose<bool>((ref) => false);

class DataView extends HookConsumerWidget {
  const DataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAggregatedData = ref.watch(isAggregatedDataProvider);
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
      body: Column(
        children: [
          const SizedBox(height: 12),
          _CustomSegmentedControl(currentIndex: currentIndex, pageController: pageController),
          const SizedBox(height: 12),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                currentIndex.value = index;
              },
              children: [
                if (isAggregatedData) const PublicGameDataGrid(),
                if (!isAggregatedData) const UseDeckGameDataGrid(),
                if (!isAggregatedData) const OpponentDeckGameDataGrid(),
                const DeckUseRateChart(),
              ],
            ),
          ),
          const AdaptiveBannerAd()
        ],
      ),
    );
  }
}

class _CustomSegmentedControl extends HookConsumerWidget {
  final ValueNotifier<int> currentIndex;
  final PageController pageController;

  const _CustomSegmentedControl({
    Key? key,
    required this.currentIndex,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAggregatedData = ref.watch(isAggregatedDataProvider);
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (isAggregatedData) {
          switch (currentIndex.value) {
            case 0:
            case 1:
              currentIndex.value = 0;
              pageController.jumpToPage(0);
              break;
            case 2:
              currentIndex.value = 1;
              pageController.jumpToPage(1);
              break;
          }
        } else {
          switch (currentIndex.value) {
            case 0:
              currentIndex.value = 0;
              pageController.jumpToPage(0);
              break;
            case 1:
              currentIndex.value = 2;
              pageController.jumpToPage(2);
              break;
          }
        }
      });
      return null; // useEffectのクリーンアップ関数はここでは不要なのでnullを返す
    }, [isAggregatedData]);

    return CupertinoSlidingSegmentedControl<int>(
      children: {
        if (!isAggregatedData)
          0: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.table_rows, size: 20),
              const SizedBox(width: 8),
              Text('使用デッキ', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        if (!isAggregatedData)
          1: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.table_rows, size: 20),
              const SizedBox(width: 8),
              Text('対戦デッキ', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        if (!isAggregatedData)
          2: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.pie_chart, size: 20),
              const SizedBox(width: 8),
              Text('デッキ使用率', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        if (isAggregatedData)
          0: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.table_rows, size: 20),
              const SizedBox(width: 8),
              Text('集計データ', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        if (isAggregatedData)
          1: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.pie_chart, size: 20),
              const SizedBox(width: 8),
              Text('デッキ使用率', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
      },
      onValueChanged: (int? index) {
        if (index == null) return;
        currentIndex.value = index;
        pageController.jumpToPage(index);
      },
      groupValue: currentIndex.value,
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
