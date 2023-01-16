import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/sort.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/selector/game_tag_list_selector.dart';
import 'package:tcg_manager/state/record_list_view_state.dart';

class RecordListViewNotifier extends StateNotifier<RecordListViewState> {
  RecordListViewNotifier(
    this.ref,
  ) : super(RecordListViewState());
  final Ref ref;

  void scrollSort(int index) {
    state = state.copyWith(cacheOrder: Sort.values[index]);
  }

  void setSort() {
    state = state.copyWith(sort: state.cacheOrder);
  }

  void toggleSort() {
    state.sort == Sort.newest ? state = state.copyWith(sort: Sort.oldest) : state = state.copyWith(sort: Sort.newest);
  }

  void setStartDate(DateTime? day) {
    state = state.copyWith(startDate: day);
  }

  void setEndDate(DateTime? day) {
    if (day == null) {
      state = state.copyWith(endDate: state.startDate);
    } else {
      state = state.copyWith(endDate: day);
    }
  }

  void setStartTime(DateTime? time) {
    state = state.copyWith(startTime: time);
  }

  void setEndTime(DateTime? time) {
    state = state.copyWith(endTime: time);
  }

  Future scrollUseDeck(int index) async {
    if (index == 0) {
      state = state.copyWith(cacheUseDeck: null);
    } else {
      final gameDeckList = await ref.read(gameDeckListProvider.future);
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
      final gameDeckList = await ref.read(gameDeckListProvider.future);
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
      final gameTagList = await ref.read(gameTagListProvider.future);
      state = state.copyWith(cacheTag: gameTagList[index - 1]);
    }
  }

  void setTag() {
    state = state.copyWith(tag: state.cacheTag);
  }

  void selectTag(Tag tag, int tagCount) {
    state = state.copyWith(tag: tag);
  }

  void resetFilter() {
    state = RecordListViewState();
  }
}

final recordListViewNotifierProvider = StateNotifierProvider.autoDispose<RecordListViewNotifier, RecordListViewState>((ref) {
  return RecordListViewNotifier(ref);
});
