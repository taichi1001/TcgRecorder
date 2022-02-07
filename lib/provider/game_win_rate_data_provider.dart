import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/selector/game_record_list_selector.dart';
import 'package:tcg_manager/state/game_win_rate_data_state.dart';

class GameWinRateDataNotifier extends StateNotifier<GameWinRateDataState> {
  GameWinRateDataNotifier(this.read) : super(GameWinRateDataState());

  final Reader read;

  void setWinRateDataList(List<WinRateData> list) {
    state = state.copyWith(winRateDataList: list);
  }
}

final gameWinRateDataNotifierProvider = StateNotifierProvider<GameWinRateDataNotifier, GameWinRateDataState>(
  (ref) {
    final gameRecordListNotifier = ref.read(gameRecordListNotifierProvider.notifier);
    final gameRecordList = ref.watch(gameRecordListNotifierProvider).gameRecordList;
    final gameDeckList = ref.watch(gameDeckListProvider);
    final List<Deck> gameUseDeckList = [];
    for (final deck in gameDeckList) {
      for (final record in gameRecordList!) {
        if (record.useDeckId == deck.deckId) {
          gameUseDeckList.add(deck);
          break;
        }
      }
    }

    final allRecordListNotifier = ref.read(allRecordListNotifierProvider.notifier);
    final winRateData = gameUseDeckList.map((useDeck) {
      final deck = useDeck.deck;
      final matchs = allRecordListNotifier.countUseDeckMatches(useDeck);
      final win = allRecordListNotifier.countUseDeckWins(useDeck);
      final loss = allRecordListNotifier.countUseDeckLoss(useDeck);
      final winRate = allRecordListNotifier.calcUseDeckWinRate(useDeck);
      final winRateOfFirst = allRecordListNotifier.calcUseDeckWinRateOfFirst(useDeck);
      final winRateOfSecond = allRecordListNotifier.calcUseDeckWinRateOfSecond(useDeck);

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
        matches: gameRecordListNotifier.countGameMatches(),
        win: gameRecordListNotifier.countGameWins(),
        loss: gameRecordListNotifier.countGameLoss(),
        winRate: gameRecordListNotifier.calcGameWinRate(),
        winRateOfFirst: gameRecordListNotifier.calcGameWinRateOfFirst(),
        winRateOfSecond: gameRecordListNotifier.calcGameWinRateOfSecond(),
      ),
    );
    gameDataGridNotifier.setWinRateDataList(winRateData);
    return gameDataGridNotifier;
  },
);
