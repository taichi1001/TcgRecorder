import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/enum/sort.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/selector/game_tag_list_selector.dart';
import 'package:tcg_manager/state/record_list_view_state.dart';

class RecordListViewNotifier extends StateNotifier<RecordListViewState> {
  RecordListViewNotifier(
    this.read,
  ) : super(RecordListViewState());
  final Reader read;

  void scrollSort(int index) {
    state = state.copyWith(cacheOrder: Sort.values[index]);
  }

  void setSort() {
    state = state.copyWith(sort: state.cacheOrder);
  }

  void toggleSort() {
    state.sort == Sort.newest ? state = state.copyWith(sort: Sort.oldest) : state = state.copyWith(sort: Sort.newest);
  }

  void setStartDate(DateTime day) {
    state = state.copyWith(startDate: day);
  }

  void setEndDate(DateTime? day) {
    if (day == null) {
      state = state.copyWith(endDate: state.startDate);
    } else {
      state = state.copyWith(endDate: day);
    }
  }

  Future scrollUseDeck(int index) async {
    if (index == 0) {
      state = state.copyWith(cacheUseDeck: null);
    } else {
      final gameDeckList = await read(gameDeckListProvider.future);
      state = state.copyWith(cacheUseDeck: gameDeckList[index - 1]);
    }
  }

  void setUseDeck() {
    state = state.copyWith(useDeck: state.cacheUseDeck);
  }

  void selectUseDeck(Deck deck) {
    state = state.copyWith(useDeck: deck);
  }

  Future scrollOpponentDeck(int index) async {
    if (index == 0) {
      state = state.copyWith(cacheOpponentDeck: null);
    } else {
      final gameDeckList = await read(gameDeckListProvider.future);
      state = state.copyWith(cacheOpponentDeck: gameDeckList[index - 1]);
    }
  }

  void setOpponentDeck() {
    state = state.copyWith(opponentDeck: state.cacheOpponentDeck);
  }

  void selectOpponentDeck(Deck deck) {
    state = state.copyWith(opponentDeck: deck);
  }

  Future scrollTag(int index) async {
    if (index == 0) {
      state = state.copyWith(cacheTag: null);
    } else {
      final gameTagList = await read(gameTagListProvider.future);
      state = state.copyWith(cacheTag: gameTagList[index - 1]);
    }
  }

  void setTag() {
    state = state.copyWith(tag: state.cacheTag);
  }

  void resetFilter() {
    state = state.copyWith(
      startDate: null,
      endDate: null,
      useDeck: null,
      opponentDeck: null,
      tag: null,
      cacheStartDate: null,
      cacheEndDate: null,
      cacheUseDeck: null,
      cacheOpponentDeck: null,
      cacheTag: null,
    );
  }
}

final recordListViewNotifierProvider = StateNotifierProvider.autoDispose<RecordListViewNotifier, RecordListViewState>((ref) {
  return RecordListViewNotifier(ref.read);
});
