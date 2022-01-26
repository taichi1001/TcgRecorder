import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/entity/deck.dart';
import 'package:tcg_recorder2/entity/record.dart';
import 'package:tcg_recorder2/entity/tag.dart';
import 'package:tcg_recorder2/provider/select_game_provider.dart';
import 'package:tcg_recorder2/provider/text_editing_controller_provider.dart';
import 'package:tcg_recorder2/repository/deck_repository.dart';
import 'package:tcg_recorder2/repository/record_repository.dart';
import 'package:tcg_recorder2/selector/game_deck_list_selector.dart';
import 'package:tcg_recorder2/selector/game_tag_list_selector.dart';
import 'package:tcg_recorder2/state/input_view_state.dart';

class InputViewNotifier extends StateNotifier<InputViewState> {
  InputViewNotifier(this.read) : super(InputViewState(date: DateTime.now()));
  final Reader read;

  void scrollDateTime(DateTime date) {
    state = state.copyWith(cacheDate: date);
  }

  void setDateTime() {
    if (state.cacheDate != null) {
      state = state.copyWith(date: state.cacheDate!);
    }
  }

  void inputUseDeck(String name) {
    final deck = Deck(deck: name);
    state = state.copyWith(useDeck: deck, cacheUseDeck: deck);
  }

  void inputOpponentDeck(String name) {
    final deck = Deck(deck: name);
    state = state.copyWith(opponentDeck: deck, cacheOpponentDeck: deck);
  }

  void scrollUseDeck(int index) {
    final newDeck = read(gameDeckListProvider)[index];
    state = state.copyWith(cacheUseDeck: newDeck);
  }

  void scrollOpponentDeck(int index) {
    final newDeck = read(gameDeckListProvider)[index];
    state = state.copyWith(cacheOpponentDeck: newDeck);
  }

  void setUseDeck() {
    state = state.copyWith(useDeck: state.cacheUseDeck);
    if (state.cacheUseDeck != null) {
      read(textEditingControllerNotifierProvider.notifier)
          .setUseDeckController(state.cacheUseDeck!.deck);
    }
  }

  void setOpponentDeck() {
    state = state.copyWith(opponentDeck: state.cacheOpponentDeck);
    if (state.cacheOpponentDeck != null) {
      read(textEditingControllerNotifierProvider.notifier)
          .setOpponentDeckController(state.cacheOpponentDeck!.deck);
    }
  }

  void inputTag(String name) {
    final tag = Tag(tag: name);
    state = state.copyWith(tag: tag);
  }

  void selectWinLoss(WinLoss? winloss) {
    if (winloss != null) {
      state = state.copyWith(winLoss: winloss);
    }
  }

  void selectFirstSecond(FirstSecond? firstSecond) {
    if (firstSecond != null) {
      state = state.copyWith(firstSecond: firstSecond);
    }
  }

  void _saveDate() {
    final newRecord = state.record!.copyWith(date: state.date);
    state = state.copyWith(record: newRecord);
  }

  void _saveFirstSecond() {
    if (state.firstSecond == FirstSecond.first) {
      state = state.copyWith(record: state.record!.copyWith(firstSecond: true));
    } else if (state.firstSecond == FirstSecond.second) {
      state = state.copyWith(record: state.record!.copyWith(firstSecond: false));
    }
  }

  void _saveWinLoss() {
    if (state.winLoss == WinLoss.win) {
      state = state.copyWith(record: state.record!.copyWith(winLoss: true));
    } else if (state.winLoss == WinLoss.loss) {
      state = state.copyWith(record: state.record!.copyWith(winLoss: false));
    }
  }

  void resetView() {
    state = InputViewState(
      date: state.date,
      winLoss: state.winLoss,
      firstSecond: state.firstSecond,
    );
    read(textEditingControllerNotifierProvider.notifier).resetInputViewController();
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

    _saveDate();
    _saveFirstSecond();
    _saveWinLoss();
    await read(recordRepository).insert(state.record!);
    return true;
  }

  bool _checkIfSelectedUseDeckNew() {
    final gameDeckList = read(gameDeckListProvider);
    final matchList = gameDeckList.where((deck) => deck.deck == state.useDeck!.deck);
    if (matchList.isNotEmpty) {
      state = state.copyWith(useDeck: matchList.first);
      return false;
    }
    return true;
  }

  bool _checkIfSelectedOpponentDeckNew() {
    final gameDeckList = read(gameDeckListProvider);
    final matchList = gameDeckList.where((deck) => deck.deck == state.opponentDeck!.deck);
    if (matchList.isNotEmpty) {
      state = state.copyWith(opponentDeck: matchList.first);
      return false;
    }
    return true;
  }

  bool _checkIfSelectedTagNew() {
    final gameTagList = read(gameTagListProvider);
    final matchList = gameTagList.where((tag) => tag.tag == state.tag!.tag);
    if (matchList.isNotEmpty) {
      state = state.copyWith(tag: matchList.first);
      return false;
    }
    return true;
  }
}

final inputViewNotifierProvider = StateNotifierProvider<InputViewNotifier, InputViewState>(
  (ref) => InputViewNotifier(ref.read),
);
