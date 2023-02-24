// ignore_for_file: unused_result

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/enum/sort.dart';
import 'package:tcg_manager/provider/backup_provider.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/repository/record_firestore_repository.dart';
import 'package:tcg_manager/state/select_deck_view_state.dart';

class SelectDeckViewNotifier extends StateNotifier<SelectDeckViewState> {
  SelectDeckViewNotifier(this.ref) : super(SelectDeckViewState());

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

  Future saveDeck(String deckName) async {
    final selectGame = ref.read(selectGameNotifierProvider).selectGame;
    final deck = Deck(
      deck: deckName,
      gameId: selectGame!.gameId,
    );
    ref.read(deckRepository).insert(deck);
    ref.refresh(allDeckListProvider);
    if (ref.read(backupNotifierProvider)) await ref.read(firestoreRepository).setAll();
  }
}

final selectDeckViewNotifierProvider = StateNotifierProvider<SelectDeckViewNotifier, SelectDeckViewState>(
  (ref) => SelectDeckViewNotifier(ref),
);
