import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/state/deck_list_state.dart';

class DeckListNotifier extends StateNotifier<DeckListState> {
  DeckListNotifier(this.read) : super(DeckListState());

  final Reader read;

  Future fetch() async {
    final deckList = await read(deckRepository).getAll();
    state = state.copyWith(allDeckList: deckList);
  }

  Future updateName(String name, int index) async {
    final deck = state.allDeckList![index];
    final newDeck = deck.copyWith(deck: name);
    await read(deckRepository).update(newDeck);
    await fetch();
  }
}

final allDeckListNotifierProvider = StateNotifierProvider<DeckListNotifier, DeckListState>(
  (ref) => DeckListNotifier(ref.read),
);
