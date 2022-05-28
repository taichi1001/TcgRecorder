import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/selector/filter_record_list_selector.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';

final useDeckDataByGameProvider = StateProvider.autoDispose<List<WinRateData>>(
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

    return gameUseDeckList
        .map(
          (useDeck) => WinRateData(
            deck: useDeck.deck,
            matches: filterRecordListNotifier.countUseDeckMatches(useDeck),
            win: filterRecordListNotifier.countUseDeckWins(useDeck),
            loss: filterRecordListNotifier.countUseDeckLoss(useDeck),
            useRate: filterRecordListNotifier.calcUseDeckUseRate(useDeck),
            winRate: filterRecordListNotifier.calcUseDeckWinRate(useDeck),
            winRateOfFirst: filterRecordListNotifier.calcUseDeckWinRateOfFirst(useDeck),
            winRateOfSecond: filterRecordListNotifier.calcUseDeckWinRateOfSecond(useDeck),
          ),
        )
        .toList();
  },
);

final totalAddedToUseDeckDataByGameProvider = StateProvider.autoDispose<List<WinRateData>>(
  (ref) {
    final useDeckDataByGame = ref.watch(useDeckDataByGameProvider);
    final copyUseDeckDataByGame = [...useDeckDataByGame];
    final filterRecordListNotifier = ref.read(filterRecordListController);

    copyUseDeckDataByGame.add(
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
    return copyUseDeckDataByGame;
  },
);
