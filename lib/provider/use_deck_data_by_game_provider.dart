import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/helper/record_calc.dart';
import 'package:tcg_manager/selector/filter_record_list_selector.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';

final useDeckDataByGameProvider = FutureProvider.autoDispose<List<WinRateData>>(
  (ref) async {
    final filterRecordList = await ref.watch(filterRecordListProvider.future);
    final gameDeckList = await ref.watch(gameDeckListProvider.future);
    final calc = RecordCalculator(targetRecordList: filterRecordList);

    final List<Deck> gameUseDeckList = [];
    for (final deck in gameDeckList) {
      for (final record in filterRecordList) {
        if (record.useDeckId == deck.deckId) {
          gameUseDeckList.add(deck);
          break;
        }
      }
    }

    return gameUseDeckList
        .map(
          (useDeck) => WinRateData(
            deck: useDeck.deck,
            matches: calc.countUseDeckMatches(useDeck),
            win: calc.countUseDeckWins(useDeck),
            loss: calc.countUseDeckLoss(useDeck),
            useRate: calc.calcUseDeckUseRate(useDeck),
            winRate: calc.calcUseDeckWinRate(useDeck),
            winRateOfFirst: calc.calcUseDeckWinRateOfFirst(useDeck),
            winRateOfSecond: calc.calcUseDeckWinRateOfSecond(useDeck),
          ),
        )
        .toList();
  },
);

final totalAddedToUseDeckDataByGameProvider = FutureProvider.autoDispose<List<WinRateData>>(
  (ref) async {
    final useDeckDataByGame = [...await ref.watch(useDeckDataByGameProvider.future)];
    final filterRecordList = await ref.watch(filterRecordListProvider.future);
    final calc = RecordCalculator(targetRecordList: filterRecordList);

    useDeckDataByGame.add(
      WinRateData(
        deck: '合計',
        matches: calc.countMatches(),
        win: calc.countWins(),
        loss: calc.countLoss(),
        winRate: calc.calcWinRate(),
        winRateOfFirst: calc.calcWinRateOfFirst(),
        winRateOfSecond: calc.calcWinRateOfSecond(),
      ),
    );
    ref.keepAlive();
    return useDeckDataByGame;
  },
);
