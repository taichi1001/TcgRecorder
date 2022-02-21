import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/selector/filter_record_list_selector.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/state/game_win_rate_data_state.dart';

class GameWinRateDataNotifier extends StateNotifier<GameWinRateDataState> {
  GameWinRateDataNotifier(this.read) : super(GameWinRateDataState());

  final Reader read;

  void setWinRateDataList(List<WinRateData> list) {
    state = state.copyWith(winRateDataList: list);
  }
}

final gameWinRateDataNotifierProvider = StateNotifierProvider.autoDispose<GameWinRateDataNotifier, GameWinRateDataState>(
  (ref) {
    final filterRecordListNotifier = ref.read(filterRecordListController);
    final filterRecordList = ref.watch(filterRecordListProvider);
    final gameDeckList = ref.watch(gameDeckListProvider);
    final List<Deck> gameUseDeckList = [];
    for (final deck in gameDeckList) {
      for (final record in filterRecordList) {
        if (record.useDeckId == deck.deckId) {
          gameUseDeckList.add(deck);
          break;
        }
      }
    }

    final winRateData = gameUseDeckList.map((useDeck) {
      final deck = useDeck.deck;
      final matchs = filterRecordListNotifier.countUseDeckMatches(useDeck);
      final win = filterRecordListNotifier.countUseDeckWins(useDeck);
      final loss = filterRecordListNotifier.countUseDeckLoss(useDeck);
      final winRate = filterRecordListNotifier.calcUseDeckWinRate(useDeck);
      final winRateOfFirst = filterRecordListNotifier.calcUseDeckWinRateOfFirst(useDeck);
      final winRateOfSecond = filterRecordListNotifier.calcUseDeckWinRateOfSecond(useDeck);

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

    final gameDataGridNotifier = GameWinRateDataNotifier(ref.read);
    winRateData.add(
      WinRateData(
        deck: '合計',
        matches: filterRecordListNotifier.countMatches(),
        win: filterRecordListNotifier.countWins(),
        loss: filterRecordListNotifier.countLoss(),
        winRate: filterRecordListNotifier.calcWinRate(),
        winRateOfFirst: filterRecordListNotifier.calcWinRateOfFirst(),
        winRateOfSecond: filterRecordListNotifier.calcWinRateOfSecond(),
      ),
    );
    gameDataGridNotifier.setWinRateDataList(winRateData);
    return gameDataGridNotifier;
  },
);
