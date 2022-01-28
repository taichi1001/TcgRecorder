import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/entity/deck.dart';
import 'package:tcg_recorder2/entity/win_rate_data.dart';
import 'package:tcg_recorder2/provider/record_list_provider.dart';
import 'package:tcg_recorder2/selector/game_deck_list_selector.dart';
import 'package:tcg_recorder2/selector/game_record_list_selector.dart';
import 'package:tcg_recorder2/state/game_win_rate_data_state.dart';

class GameWinRateDataNotifier extends StateNotifier<GameWinRateDataState> {
  GameWinRateDataNotifier(this.read) : super(GameWinRateDataState());

  final Reader read;

  void setWinRateDataList(List<WinRateData> list) {
    state = state.copyWith(winRateDataList: list);
  }
}

final gameWinRateDataNotifierProvider =
    StateNotifierProvider<GameWinRateDataNotifier, GameWinRateDataState>(
  (ref) {
    final gameDataGridNotifier = GameWinRateDataNotifier(ref.read);
    final gameRecordList = ref.watch(gameRecordListProvider);
    final gameDeckList = ref.watch(gameDeckListProvider);

    final List<Deck> gameUseDeckList = [];
    for (final deck in gameDeckList) {
      for (final record in gameRecordList) {
        if (record.useDeckId == deck.deckId) {
          gameUseDeckList.add(deck);
          break;
        }
      }
    }

    final winRateData = gameUseDeckList.map((useDeck) {
      final deck = useDeck.deck;
      final matchs = ref.read(allRecordListNotifierProvider.notifier).countMatches(useDeck);
      final win = ref.read(allRecordListNotifierProvider.notifier).countWins(useDeck);
      final loss = ref.read(allRecordListNotifierProvider.notifier).countLoss(useDeck);
      final winRate = ref.read(allRecordListNotifierProvider.notifier).calcWinRate(useDeck);
      final winRateOfFirst =
          ref.read(allRecordListNotifierProvider.notifier).calcWinRateOfFirst(useDeck);
      final winRateOfSecond =
          ref.read(allRecordListNotifierProvider.notifier).calcWinRateOfSecond(useDeck);

      return WinRateData(
        deck: deck,
        matches: matchs,
        win: win,
        loss: loss,
        winRate: winRate,
        winRateOfFirst: winRateOfFirst,
        winRateOfSecond: winRateOfSecond,
      );
    }).toList();
    gameDataGridNotifier.setWinRateDataList(winRateData);
    return gameDataGridNotifier;
  },
);
