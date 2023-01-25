import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/sort.dart';
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

  void selectUseDeck(Deck deck) {
    state = state.copyWith(useDeck: deck);
  }

  void selectOpponentDeck(Deck deck) {
    state = state.copyWith(opponentDeck: deck);
  }

  // emptyは使用しないが、タグ選択ビューでintを引数に取る必要があるためつけたしている
  void selectTag(Tag tag, int empty) {
    final newTagList = [...state.tagList];
    newTagList.add(tag);
    state = state.copyWith(tagList: newTagList);
  }

  void deselectionTag(Tag tag) {
    final newTagList = [...state.tagList];
    newTagList.removeWhere((element) => element.tagId == tag.tagId);
    state = state.copyWith(tagList: newTagList);
  }

  void resetFilter() {
    state = RecordListViewState();
  }
}

final recordListViewNotifierProvider = StateNotifierProvider.autoDispose<RecordListViewNotifier, RecordListViewState>((ref) {
  return RecordListViewNotifier(ref);
});
