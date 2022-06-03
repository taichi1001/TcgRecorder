import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/enum/Sort.dart';
import 'package:tcg_manager/state/select_deck_view_state.dart';

class SelectDeckViewNotifier extends StateNotifier<SelectDeckViewState> {
  SelectDeckViewNotifier(this.read) : super(SelectDeckViewState());

  final Reader read;

  void changeSort() {
    const sortTypes = Sort.values;
    final oldIndex = state.sortType.index;
    if (oldIndex + 1 == sortTypes.length) {
      state = state.copyWith(sortType: sortTypes[0]);
    } else {
      state = state.copyWith(sortType: sortTypes[oldIndex + 1]);
    }
  }
}

final selectDeckViewNotifierProvider = StateNotifierProvider<SelectDeckViewNotifier, SelectDeckViewState>(
  (ref) => SelectDeckViewNotifier(ref.read),
);
