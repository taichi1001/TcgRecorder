import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/enum/sort.dart';
import 'package:tcg_manager/state/select_tag_view_state.dart';

class SelectTagViewNotifier extends StateNotifier<SelectTagViewState> {
  SelectTagViewNotifier(this.read) : super(SelectTagViewState());

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

  void setSearchText(String searchText) {
    state = state.copyWith(searchText: searchText);
  }
}

final selectTagViewNotifierProvider = StateNotifierProvider<SelectTagViewNotifier, SelectTagViewState>(
  (ref) => SelectTagViewNotifier(ref.read),
);
