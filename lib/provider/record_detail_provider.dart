import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/enum/first_second.dart';
import 'package:tcg_manager/enum/win_loss.dart';
import 'package:tcg_manager/helper/db_helper.dart';
import 'package:tcg_manager/helper/edit_record_helper.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/repository/record_repository.dart';
import 'package:tcg_manager/repository/tag_repository.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/selector/game_tag_list_selector.dart';
import 'package:tcg_manager/state/record_detail_state.dart';

class RecordDetailNotifier extends StateNotifier<RecordDetailState> {
  RecordDetailNotifier({
    required this.ref,
    required this.record,
    required this.margedRecord,
  }) : super(
          RecordDetailState(
            record: record,
            margedRecord: margedRecord,
            cacheDate: record.date,
            editMargedRecord: margedRecord,
          ),
        );

  final Ref ref;
  final Record record;
  final MargedRecord margedRecord;

  void changeIsEdit() {
    state = state.copyWith(isEdit: !state.isEdit);
  }

  void editUseDeck(String name) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(useDeck: name));
  }

  Future scrollUseDeck(int index) async {
    final gameDeckList = await ref.read(gameDeckListProvider.future);
    state = state.copyWith(cacheUseDeck: gameDeckList[index]);
  }

  void setUseDeck() {
    if (state.cacheUseDeck != null) {
      state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(useDeck: state.cacheUseDeck!.deck));
    }
  }

  void selectUseDeck(Deck deck) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(useDeck: deck.deck));
  }

  void editOpponentDeck(String name) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(opponentDeck: name));
  }

  Future scrollOpponentDeck(int index) async {
    final gameDeckList = await ref.read(gameDeckListProvider.future);
    state = state.copyWith(cacheOpponentDeck: gameDeckList[index]);
  }

  void setOpponentDeck() {
    if (state.cacheOpponentDeck != null) {
      state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(opponentDeck: state.cacheOpponentDeck!.deck));
    }
  }

  void selectOpponentDeck(Deck deck) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(opponentDeck: deck.deck));
  }

  void editTag(String name) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(tag: name));
  }

  Future scrollTag(int index) async {
    final gameTagList = await ref.read(gameTagListProvider.future);
    state = state.copyWith(cacheTag: gameTagList[index]);
  }

  void setTag() {
    if (state.cacheTag != null) {
      state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(tag: state.cacheTag!.tag));
    }
  }

  void selectTag(Tag tag) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(tag: tag.tag));
  }

  void scrollDate(DateTime date) {
    state = state.copyWith(cacheDate: date);
  }

  void setDate() {
    if (state.cacheDate != null) {
      state = state.copyWith(
        editMargedRecord: state.editMargedRecord.copyWith(date: state.cacheDate!),
      );
    }
  }

  void editWinLoss(WinLoss winnLoss) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(winLoss: winnLoss));
  }

  void editFirstSecond(FirstSecond firstSecond) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(firstSecond: firstSecond));
  }

  void editMemo(String memo) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(memo: memo));
  }

  Future saveEdit() async {
    // 編集したrecord(EditMargedRecord)を表示用のrecord(MargedRecord)に設定
    state = state.copyWith(margedRecord: state.editMargedRecord);

    // 各種値の保存、ID取得、recordへのID設定
    // ここの処理は各種値が編集済みが未編集かに関わらず実行される
    // 編集済みのみ実行するようにすればパフォーマンスは上がるかも
    await _saveEditUseDeck();
    await _saveEditOpponentDeck();
    await _saveEditTag();
    state = state.copyWith(
      record: state.record.copyWith(
        date: state.editMargedRecord.date,
        winLoss: state.editMargedRecord.winLoss,
        firstSecond: state.editMargedRecord.firstSecond,
        memo: state.editMargedRecord.memo,
      ),
    );

    // recordを上書き
    await ref.read(recordRepository).update(state.record);

    await ref.read(dbHelper).fetchAll();
  }

  Future _saveEditUseDeck() async {
    // 入力された使用デッキが新規のものかどうかを判定
    final checkUseDeck = await ref.read(editRecordHelper).checkIfSelectedUseDeckIsNew(state.margedRecord.useDeck);

    // 新規だった場合
    if (checkUseDeck.isNew) {
      // 入力された使用デッキをDBに登録しデッキIDを取得
      final newId = await ref.read(deckRepository).insert(
            Deck(
              deck: state.margedRecord.useDeck,
              gameId: state.record.gameId,
            ),
          );

      // recordに新しいデッキIDを登録
      state = state.copyWith(record: state.record.copyWith(useDeckId: newId));
    } else {
      // 既に登録済みのデッキだった場合、そのデッキのIDをrecordに登録
      state = state.copyWith(record: state.record.copyWith(useDeckId: checkUseDeck.deck!.deckId));
    }
  }

  Future _saveEditOpponentDeck() async {
    // 入力された対戦デッキが新規のものかどうかを判定
    final checkOpponentDeck = await ref.read(editRecordHelper).checkIfSelectedUseDeckIsNew(state.margedRecord.opponentDeck);

    // 新規だった場合
    if (checkOpponentDeck.isNew) {
      // 入力された対戦デッキをDBに登録しデッキIDを取得
      final newId = await ref.read(deckRepository).insert(
            Deck(
              deck: state.margedRecord.opponentDeck,
              gameId: state.record.gameId,
            ),
          );

      // recordに新しいデッキIDを登録
      state = state.copyWith(record: state.record.copyWith(opponentDeckId: newId));
    } else {
      // 既に登録済みのデッキだった場合、そのデッキのIDをrecordに登録
      state = state.copyWith(record: state.record.copyWith(opponentDeckId: checkOpponentDeck.deck!.deckId));
    }
  }

  Future _saveEditTag() async {
    if (state.margedRecord.tag == null) return;
    // 入力されたタグが新規のものかどうかを判定
    final checkTag = await ref.read(editRecordHelper).checkIfSelectedTagIsNew(state.margedRecord.tag!);

    // 新規だった場合
    if (checkTag.isNew) {
      // 入力された対戦デッキをDBに登録しデッキIDを取得
      final newId = await ref.read(tagRepository).insert(
            Tag(
              tag: state.margedRecord.tag!,
              gameId: state.record.gameId,
            ),
          );

      // recordに新しいタグIDを登録
      state = state.copyWith(record: state.record.copyWith(tagId: newId));
    } else {
      // 既に登録済みのタグだった場合、そのタグのIDをrecordに登録
      state = state.copyWith(record: state.record.copyWith(tagId: checkTag.tag!.tagId));
    }
  }
}

final recordListProvider = Provider<List<Record>>((ref) {
  final recordList = ref.read(allRecordListProvider);
  final state = recordList.when(
    data: (recordList) => recordList,
    error: (_, __) => [],
    loading: () => [],
  );
  return state.cast();
});

final recordDetailNotifierProvider =
    StateNotifierProvider.family.autoDispose<RecordDetailNotifier, RecordDetailState, MargedRecord>((ref, margedRecord) {
  // 一覧からレコードを選択した瞬間の値のみがほしいため、watchで監視せずにreadで読み取っている
  final recordList = ref.read(recordListProvider);
  final record = recordList.firstWhere((record) => record.recordId == margedRecord.recordId);
  final notifier = RecordDetailNotifier(ref: ref, record: record, margedRecord: margedRecord);
  return notifier;
});
