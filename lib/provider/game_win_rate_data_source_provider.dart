import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/game_win_rate_data_provider.dart';
import 'package:tcg_manager/state/game_win_rate_data_source_state.dart';

class GameWinRateDataSourceNotifier extends StateNotifier<GameWinRateDataSourceState> {
  GameWinRateDataSourceNotifier(this.read) : super(GameWinRateDataSourceState());

  final Reader read;

  void setWinRateDataSourceList(GameWinRateDataSource list) {
    state = state.copyWith(gameWinRateDataSource: list);
  }
}

final gameWinRateDataSourceNotifierProvider =
    StateNotifierProvider.family.autoDispose<GameWinRateDataSourceNotifier, GameWinRateDataSourceState, BuildContext>(
  (ref, context) {
    final gameWinRateDataList = ref.watch(gameWinRateDataNotifierProvider).winRateDataList;
    final gameWinRateDataSource = GameWinRateDataSource(winRateDataList: gameWinRateDataList!, context: context);
    final gameWinRateDataSourceNotifier = GameWinRateDataSourceNotifier(ref.read);
    gameWinRateDataSourceNotifier.setWinRateDataSourceList(gameWinRateDataSource);
    return gameWinRateDataSourceNotifier;
  },
);
