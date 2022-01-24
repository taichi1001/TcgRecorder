import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/entity/deck.dart';
import 'package:tcg_recorder2/entity/record.dart';
import 'package:tcg_recorder2/entity/tag.dart';
import 'package:tcg_recorder2/provider/select_game_provider.dart';
import 'package:tcg_recorder2/repository/deck_repository.dart';
import 'package:tcg_recorder2/repository/record_repository.dart';
import 'package:tcg_recorder2/selector/game_deck_list_selector.dart';
import 'package:tcg_recorder2/selector/game_tag_list_selector.dart';
import 'package:tcg_recorder2/state/input_view_state.dart';

class InputViewNotifier extends StateNotifier<InputViewState> {
  InputViewNotifier(this.read) : super(InputViewState());
  final Reader read;

  void inputUseDeck(String name) {
    final deck = Deck(deck: name);
    state = state.copyWith(useDeck: deck);
  }

  void inputOpponentDeck(String name) {
    final deck = Deck(deck: name);
    state = state.copyWith(opponentDeck: deck);
  }

  void inputTag(String name) {
    final tag = Tag(tag: name);
    state = state.copyWith(tag: tag);
  }

  void selectWinLoss(bool winloss) {
    state = state.copyWith(winLoss: winloss);
  }

  void selectFirstSecond(bool firstSecond) {
    state = state.copyWith(firstSecond: firstSecond);
  }

  Future<bool> save() async {
    // if (state.useDeck == null || state.opponentDeck == null || state.tag == null) return false;
    if (state.useDeck == null || state.opponentDeck == null) return false;
    final selectGameId = read(selectGameNotifierProvider).selectGame!.gameId;
    // useDeckが新規だった場合、useDeckにgameIDを設定
    if (_checkIfSelectedUseDeckNew()) {
      state = state.copyWith(
        useDeck: state.useDeck!.copyWith(
          gameId: selectGameId,
        ),
      );
      final useDeckId = await read(deckRepository).insert(state.useDeck!);
      state = state.copyWith(
        useDeck: state.useDeck!.copyWith(
          deckId: useDeckId,
        ),
      );
    }
    // opponentDeckが新規だった場合,opponentDeckにgameIDを設定
    if (_checkIfSelectedOpponentDeckNew()) {
      state = state.copyWith(
        opponentDeck: state.opponentDeck!.copyWith(
          gameId: selectGameId,
        ),
      );
      final opponentDeckId = await read(deckRepository).insert(state.opponentDeck!);
      state = state.copyWith(
        opponentDeck: state.opponentDeck!.copyWith(
          deckId: opponentDeckId,
        ),
      );
    }

    // // Tagが新規だった場合,opponentDeckにgameIDを設定
    // if (_checkIfSelectedTagNew()) {
    //   state = state.copyWith(
    //     tag: state.tag!.copyWith(
    //       gameId: selectGameId,
    //     ),
    //   );
    //   final tagId = await read(tagRepository).insert(state.tag!);
    //   state = state.copyWith(
    //     tag: state.tag!.copyWith(
    //       tagId: tagId,
    //     ),
    //   );
    // }

    // record登録
    final newRecord = Record(gameId: selectGameId);
    state = state.copyWith(record: newRecord);

    // recordにuseDeckIdを設定
    state = state.copyWith(
      record: state.record!.copyWith(
        useDeckId: state.useDeck!.deckId,
      ),
    );
    // recordにopponentDeckId設定
    state = state.copyWith(
      record: state.record!.copyWith(
        opponentDeckId: state.opponentDeck!.deckId,
      ),
    );
    read(recordRepository).insert(state.record!);

    return true;
  }

  bool _checkIfSelectedUseDeckNew() {
    final gameDeckList = read(gameDeckListProvider);
    final matchList = gameDeckList.where((deck) => deck.deck == state.useDeck!.deck);
    if (matchList.isNotEmpty) {
      state.copyWith(useDeck: matchList.first);
      return false;
    }
    return true;
  }

  bool _checkIfSelectedOpponentDeckNew() {
    final gameDeckList = read(gameDeckListProvider);
    final matchList = gameDeckList.where((deck) => deck.deck == state.opponentDeck!.deck);
    if (matchList.isNotEmpty) {
      state.copyWith(opponentDeck: matchList.first);
      return false;
    }
    return true;
  }

  bool _checkIfSelectedTagNew() {
    final gameTagList = read(gameTagListProvider);
    final matchList = gameTagList.where((tag) => tag.tag == state.tag!.tag);
    if (matchList.isNotEmpty) {
      state.copyWith(tag: matchList.first);
      return false;
    }
    return true;
  }
}

final inputViewNotifierProvider = StateNotifierProvider<InputViewNotifier, InputViewState>(
  (ref) => InputViewNotifier(ref.read),
);
