import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/opponent_deck_data_by_use_deck_provider.dart';
import 'package:tcg_manager/state/deck_win_rate_data_source_state.dart';

final deckWinRateDataSourceNotifierProvider = StateProvider.family.autoDispose<DeckWinRateDataSource, String>(
  (ref, deckName) {
    final gameWinRateDataList = ref.watch(opponentDeckDataByUseDeckProvider(deckName));
    return DeckWinRateDataSource(winRateDataList: gameWinRateDataList);
  },
);
