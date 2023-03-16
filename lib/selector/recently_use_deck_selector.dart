import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/selector/game_record_list_selector.dart';

final recentlyUseDeckProvider = FutureProvider.autoDispose<List<Deck>>((ref) async {
  final recordList = await ref.watch(gameRecordListProvider.future);
  final recordListCopy = [...recordList];

  // レコードを最新順に並び替え
  recordListCopy.sort((a, b) {
    int result = -a.date!.compareTo(b.date!);
    if (result == 0) {
      result = -a.recordId!.compareTo(b.recordId!);
    }
    return result;
  });
  // 直近使用した、または使用されたデッキ10個のIDを抽出
  List<int> recentlyDeckIdList = [];
  for (final record in recordListCopy) {
    if (recentlyDeckIdList.length == 5) break;
    if (recentlyDeckIdList.length == 6) {
      recentlyDeckIdList.removeLast();
      break;
    }
    recentlyDeckIdList.add(record.useDeckId!);
    recentlyDeckIdList.add(record.opponentDeckId!);
    recentlyDeckIdList = recentlyDeckIdList.toSet().toList();
  }
  // IDが一致するデッキを抽出
  final deckList = await ref.watch(gameDeckListProvider.future);
  final deckListCopy = [...deckList];
  final List<Deck> recentlyDeckList = [];
  for (final id in recentlyDeckIdList) {
    for (final deck in deckListCopy) {
      if (id == deck.id) {
        recentlyDeckList.add(deck);
        break;
      }
    }
  }
  return recentlyDeckList;
});
