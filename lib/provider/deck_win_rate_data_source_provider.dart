import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/deck_win_rate_data_provider.dart';
import 'package:tcg_manager/state/deck_win_rate_data_source_state.dart';

class DeckWinRateDataSourceNotifier extends StateNotifier<DeckWinRateDataSourceState> {
  DeckWinRateDataSourceNotifier(this.read) : super(DeckWinRateDataSourceState());

  final Reader read;

  void setWinRateDataSourceList(DeckWinRateDataSource source) {
    state = state.copyWith(deckWinRateDataSource: source);
  }
}

final deckWinRateDataSourceNotifierProvider =
    StateNotifierProvider.family.autoDispose<DeckWinRateDataSourceNotifier, DeckWinRateDataSourceState, String>(
  (ref, deckName) {
    final gameWinRateDataList = ref.watch(deckWinRateDataNotifierProvider(deckName)).winRateDataList;
    final gameWinRateDataSourceNotifier = DeckWinRateDataSourceNotifier(ref.read);
    gameWinRateDataSourceNotifier
        .setWinRateDataSourceList(DeckWinRateDataSource(winRateDataList: gameWinRateDataList!));
    return gameWinRateDataSourceNotifier;
  },
);
