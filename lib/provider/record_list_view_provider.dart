import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/enum/Sort.dart';
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

  // void scrollStartDate(DateTime day) {
  //   state = state.copyWith(cacheStartDate: day);
  // }

  void setStartDate(DateTime day) {
    state = state.copyWith(startDate: day);
  }

  // void scrollEndDate(DateTime day) {
  //   state = state.copyWith(cacheEndDate: day);
  // }

  void setEndDate(DateTime? day) {
    if (day == null) {
      state = state.copyWith(endDate: state.startDate);
    } else {
      state = state.copyWith(endDate: day);
    }
  }

  void scrollUseDeck(int index) {
    if (index == 0) {
      state = state.copyWith(cacheUseDeck: null);
    } else {
      state = state.copyWith(cacheUseDeck: read(gameDeckListProvider)[index - 1]);
    }
  }

  void setUseDeck() {
    state = state.copyWith(useDeck: state.cacheUseDeck);
  }

  void scrollOpponentDeck(int index) {
    if (index == 0) {
      state = state.copyWith(cacheOpponentDeck: null);
    } else {
      state = state.copyWith(cacheOpponentDeck: read(gameDeckListProvider)[index - 1]);
    }
  }

  void setOpponentDeck() {
    state = state.copyWith(opponentDeck: state.cacheOpponentDeck);
  }

  void scrollTag(int index) {
    if (index == 0) {
      state = state.copyWith(cacheTag: null);
    } else {
      state = state.copyWith(cacheTag: read(gameTagListProvider)[index - 1]);
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

final recordListViewNotifierProvider = StateNotifierProvider<RecordListViewNotifier, RecordListViewState>((ref) {
  return RecordListViewNotifier(ref.read);
});
