import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/selector/filter_record_list_selector.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';

final opponentDeckDataByGameProvider = StateProvider.autoDispose<List<WinRateData>>(
  (ref) {
    final filterRecordListNotifier = ref.read(filterRecordListController);
    final filterRecordList = ref.watch(filterRecordListProvider);
    final gameDeckList = ref.watch(gameDeckListProvider);
    final List<Deck> opponentDeckList = [];
    for (final deck in gameDeckList) {
      for (final record in filterRecordList) {
        if (record.opponentDeckId == deck.deckId) {
          opponentDeckList.add(deck);
          break;
        }
      }
    }

    return opponentDeckList
        .map(
          (useDeck) => WinRateData(
            deck: useDeck.deck,
            matches: filterRecordListNotifier.countOpponentDeckMatches2(useDeck),
            useRate: filterRecordListNotifier.calcOpponentDeckUseRate(useDeck),
          ),
        )
        .toList();
  },
);
