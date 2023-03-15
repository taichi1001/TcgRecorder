import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/helper/record_calc.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/selector/filter_record_list_selector.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';

final opponentDeckDataByGameFutureProvider = FutureProvider.autoDispose<List<WinRateData>>(
  (ref) async {
    final filterRecordList = await ref.watch(filterRecordListProvider.future);
    final gameDeckList = await ref.watch(gameDeckListProvider.future);
    final calc = RecordCalculator(targetRecordList: filterRecordList);

    final List<Deck> opponentDeckList = [];
    for (final deck in gameDeckList) {
      for (final record in filterRecordList) {
        if (record.opponentDeckId == deck.id) {
          opponentDeckList.add(deck);
          break;
        }
      }
    }

    return opponentDeckList
        .map(
          (useDeck) => WinRateData(
            deck: useDeck.name,
            matches: calc.countOpponentDeckMatches2(useDeck),
            useRate: calc.calcOpponentDeckUseRate(useDeck),
          ),
        )
        .toList();
  },
);

final opponentDeckDataByGameStreamProvider = StreamProvider.autoDispose<List<WinRateData>>(
  (ref) async* {
    final filterRecordList = await ref.watch(filterRecordListProvider.future);
    final gameDeckList = await ref.watch(gameDeckListProvider.future);
    final calc = RecordCalculator(targetRecordList: filterRecordList);

    final List<Deck> opponentDeckList = [];
    for (final deck in gameDeckList) {
      for (final record in filterRecordList) {
        if (record.opponentDeckId == deck.id) {
          opponentDeckList.add(deck);
          break;
        }
      }
    }

    yield opponentDeckList
        .map(
          (useDeck) => WinRateData(
            deck: useDeck.name,
            matches: calc.countOpponentDeckMatches2(useDeck),
            useRate: calc.calcOpponentDeckUseRate(useDeck),
          ),
        )
        .toList();
  },
);

final opponentDeckDataByGameProvider = Provider.autoDispose<AsyncValue<List<WinRateData>>>(
  (ref) {
    final isShare = ref.watch(selectGameNotifierProvider.select((value) => value.selectGame))?.isShare;
    if (isShare!) {
      print('a');
      return ref.watch(opponentDeckDataByGameStreamProvider);
    } else {
      print('b');
      return ref.watch(opponentDeckDataByGameFutureProvider);
    }
  },
);
