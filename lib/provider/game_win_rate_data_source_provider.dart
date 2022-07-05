import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/use_deck_data_by_game_provider.dart';
import 'package:tcg_manager/state/game_win_rate_data_source_state.dart';

final gameWinRateDataSourceProvider = FutureProvider.family.autoDispose<GameWinRateDataSource, BuildContext>(
  (ref, context) async {
    final gameWinRateDataList = await ref.watch(totalAddedToUseDeckDataByGameProvider.future);
    return GameWinRateDataSource(winRateDataList: gameWinRateDataList, context: context);
  },
);
