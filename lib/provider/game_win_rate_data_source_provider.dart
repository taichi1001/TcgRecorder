import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/provider/game_win_rate_data_provider.dart';
import 'package:tcg_recorder2/state/game_win_rate_data_source_state.dart';

class GameWinRateDataSourceNotifier extends StateNotifier<GameWinRateDataSourceState> {
  GameWinRateDataSourceNotifier(this.read) : super(GameWinRateDataSourceState());

  final Reader read;

  void setWinRateDataSourceList(GameWinRateDataSource list) {
    state = state.copyWith(gameWinRateDataSource: list);
  }
}

final gameWinRateDataSourceNotifierProvider =
    StateNotifierProvider<GameWinRateDataSourceNotifier, GameWinRateDataSourceState>(
  (ref) {
    final gameWinRateDataList = ref.watch(gameWinRateDataNotifierProvider).winRateDataList;
    final gameWinRateDataSource = GameWinRateDataSource(winRateDataList: gameWinRateDataList!);
    final gameWinRateDataSourceNotifier = GameWinRateDataSourceNotifier(ref.read);
    gameWinRateDataSourceNotifier.setWinRateDataSourceList(gameWinRateDataSource);
    return gameWinRateDataSourceNotifier;
  },
);
