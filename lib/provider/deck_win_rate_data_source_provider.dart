import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/provider/opponent_deck_data_by_use_deck_provider.dart';
import 'package:tcg_manager/state/deck_win_rate_data_source_state.dart';

final deckWinRateDataSourceNotifierProvider = FutureProvider.family.autoDispose<DeckWinRateDataSource, String>(
  (ref, deckName) async {
    final gameWinRateDataList = await ref.watch(opponentDeckDataByUseDeckProvider(deckName).future);
    return DeckWinRateDataSource(winRateDataList: gameWinRateDataList);
  },
);
