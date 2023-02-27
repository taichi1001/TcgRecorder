// ignore_for_file: unused_result

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/sort.dart';
import 'package:tcg_manager/provider/backup_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/provider/firestore_controller.dart';
import 'package:tcg_manager/repository/tag_repository.dart';
import 'package:tcg_manager/state/select_tag_view_state.dart';

class SelectTagViewNotifier extends StateNotifier<SelectTagViewState> {
  SelectTagViewNotifier(this.ref) : super(SelectTagViewState());

  final StateNotifierProviderRef ref;

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

  Future saveTag(String tagName) async {
    final selectGame = ref.read(selectGameNotifierProvider).selectGame;
    final tag = Tag(
      tag: tagName,
      gameId: selectGame!.gameId,
    );
    ref.read(tagRepository).insert(tag);
    ref.refresh(allTagListProvider);
    if (ref.read(backupNotifierProvider)) await ref.read(firestoreController).addAll();
  }
}

final selectTagViewNotifierProvider = StateNotifierProvider<SelectTagViewNotifier, SelectTagViewState>(
  (ref) => SelectTagViewNotifier(ref),
);
