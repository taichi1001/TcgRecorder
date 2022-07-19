import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/helper/edit_record_helper.dart';
import 'package:tcg_manager/provider/input_view_settings_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/provider/text_editing_controller_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/repository/record_repository.dart';
import 'package:tcg_manager/repository/tag_repository.dart';
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
      state = state.copyWith(useDeck: deck);
    }
  }

  void inputOpponentDeck(String name) {
    if (name == '') {
      state = state.copyWith(opponentDeck: null);
    } else {
      final deck = Deck(deck: name);
      state = state.copyWith(opponentDeck: deck);
    }
  }

  void selectUseDeck(Deck deck) {
    state = state.copyWith(useDeck: deck);
    read(textEditingControllerNotifierProvider.notifier).setUseDeckController(state.useDeck!.deck);
  }

  void selectOpponentDeck(Deck deck) {
    state = state.copyWith(opponentDeck: deck);
    read(textEditingControllerNotifierProvider.notifier).setOpponentDeckController(state.opponentDeck!.deck);
  }

  void inputTag(String name) {
    final tag = Tag(tag: name);
    state = state.copyWith(tag: tag);
  }

  void selectTag(Tag tag) {
    state = state.copyWith(tag: tag);
    read(textEditingControllerNotifierProvider.notifier).setTagController(state.tag!.tag);
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
    final fixUseDeck = read(inputViewSettingsNotifierProvider).fixUseDeck;
    final fixOpponentDeck = read(inputViewSettingsNotifierProvider).fixOpponentDeck;
    final fixTag = read(inputViewSettingsNotifierProvider).fixTag;
    state = InputViewState(
      date: state.date,
      winLoss: state.winLoss,
      firstSecond: state.firstSecond,
      useDeck: fixUseDeck ? state.useDeck : null,
      opponentDeck: fixOpponentDeck ? state.opponentDeck : null,
      tag: fixTag ? state.tag : null,
    );
    read(textEditingControllerNotifierProvider.notifier).resetInputViewController();
  }

  Future<int> save() async {
    if (state.useDeck == null || state.opponentDeck == null) return 0;
    final selectGameId = read(selectGameNotifierProvider).selectGame!.gameId;
    // useDeckが新規だった場合、useDeckにgameIDを設定
    final checkUseDeck = await read(editRecordHelper).checkIfSelectedUseDeckIsNew(state.useDeck!.deck);
    if (checkUseDeck.isNew) {
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
    } else {
      state = state.copyWith(useDeck: checkUseDeck.deck);
    }
    if (state.useDeck!.deck == state.opponentDeck!.deck) {
      state = state.copyWith(opponentDeck: state.useDeck);
    } else {
      // opponentDeckが新規だった場合,opponentDeckにgameIDを設定
      final checkOpponentDeck = await read(editRecordHelper).checkIfSelectedUseDeckIsNew(state.opponentDeck!.deck);
      if (checkOpponentDeck.isNew) {
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
      } else {
        state = state.copyWith(opponentDeck: checkOpponentDeck.deck);
      }
    }
    if (state.tag != null) {
      // Tagが新規だった場合,opponentDeckにgameIDを設定
      final checkTag = await read(editRecordHelper).checkIfSelectedTagIsNew(state.tag!.tag);
      if (checkTag.isNew) {
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
      } else {
        state = state.copyWith(tag: checkTag.tag);
      }
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
    final recordCount = await read(recordRepository).insert(state.record!);
    return recordCount;
  }
}

final inputViewNotifierProvider = StateNotifierProvider<InputViewNotifier, InputViewState>(
  (ref) => InputViewNotifier(ref.read),
);
