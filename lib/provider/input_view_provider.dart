import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/provider/text_editing_controller_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/repository/record_repository.dart';
import 'package:tcg_manager/repository/tag_repository.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/selector/game_tag_list_selector.dart';
import 'package:tcg_manager/state/input_view_state.dart';

class InputViewNotifier extends StateNotifier<InputViewState> {
  InputViewNotifier(this.read)
      : super(
          InputViewState(
            date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
          ),
        );

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
    if (name == '') {
      state = state.copyWith(useDeck: null);
    } else {
      final deck = Deck(deck: name);
      state = state.copyWith(useDeck: deck, cacheUseDeck: deck);
    }
  }

  void inputOpponentDeck(String name) {
    if (name == '') {
      state = state.copyWith(opponentDeck: null);
    } else {
      final deck = Deck(deck: name);
      state = state.copyWith(opponentDeck: deck, cacheOpponentDeck: deck);
    }
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
      read(textEditingControllerNotifierProvider.notifier).setUseDeckController(state.cacheUseDeck!.deck);
    }
  }

  void setOpponentDeck() {
    state = state.copyWith(opponentDeck: state.cacheOpponentDeck);
    if (state.cacheOpponentDeck != null) {
      read(textEditingControllerNotifierProvider.notifier).setOpponentDeckController(state.cacheOpponentDeck!.deck);
    }
  }

  void inputTag(String name) {
    final tag = Tag(tag: name);
    state = state.copyWith(tag: tag);
  }

  void scrollTag(int index) {
    final newTag = read(gameTagListProvider)[index];
    state = state.copyWith(cacheTag: newTag);
  }

  void setTag() {
    state = state.copyWith(tag: state.cacheTag);
    if (state.cacheTag != null) {
      read(textEditingControllerNotifierProvider.notifier).setTagController(state.cacheTag!.tag);
    }
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

  void inputMemo(String memo) {
    state = state.copyWith(memo: memo);
  }

  void _saveDate() {
    final newRecord = state.record!.copyWith(date: state.date);
    state = state.copyWith(record: newRecord);
  }

  void _saveFirstSecond() {
    state = state.copyWith(record: state.record!.copyWith(firstSecond: state.firstSecond));
  }

  void _saveWinLoss() {
    state = state.copyWith(record: state.record!.copyWith(winLoss: state.winLoss));
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
    if (state.useDeck == null || state.opponentDeck == null || state.tag == null) return false;
    // if (state.useDeck == null || state.opponentDeck == null) return false;
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
    if (state.useDeck!.deck == state.opponentDeck!.deck) {
      state = state.copyWith(opponentDeck: state.useDeck);
    } else {
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
    }
    // Tagが新規だった場合,opponentDeckにgameIDを設定
    if (_checkIfSelectedTagNew()) {
      state = state.copyWith(
        tag: state.tag!.copyWith(
          gameId: selectGameId,
        ),
      );
      final tagId = await read(tagRepository).insert(state.tag!);
      state = state.copyWith(
        tag: state.tag!.copyWith(
          tagId: tagId,
        ),
      );
    }

    // record登録
    final newRecord = Record(gameId: selectGameId);
    state = state.copyWith(record: newRecord);

    // recordに各種データを設定
    state = state.copyWith(
      record: state.record!.copyWith(
        useDeckId: state.useDeck!.deckId,
        opponentDeckId: state.opponentDeck!.deckId,
        tagId: state.tag?.tagId,
        memo: state.memo,
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
