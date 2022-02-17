import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/helper/db_helper.dart';
import 'package:tcg_manager/helper/edit_record_helper.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/repository/record_repository.dart';
import 'package:tcg_manager/state/input_view_state.dart';
import 'package:tcg_manager/state/record_detail_state.dart';

class RecordDetailNotifier extends StateNotifier<RecordDetailState> {
  RecordDetailNotifier(this.ref, this.record, this.margedRecord)
      : super(RecordDetailState(
            record: record, margedRecord: margedRecord, cacheDate: record.date, editMargedRecord: margedRecord));

  final Ref ref;
  final Record record;
  final MargedRecord margedRecord;

  void changeIsEdit() {
    state = state.copyWith(isEdit: !state.isEdit);
  }

  void editUseDeck(String name) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(useDeck: name));
  }

  void editOpponentDeck(String name) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(opponentDeck: name));
  }

  void scrollDate(DateTime date) {
    state = state.copyWith(cacheDate: date);
  }

  void editDate() {
    if (state.cacheDate != null) {
      state = state.copyWith(
        editMargedRecord: state.editMargedRecord.copyWith(
          date: state.cacheDate!,
        ),
      );
    }
  }

  void editWinLoss(WinLoss winnLoss) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(winLoss: winnLoss));
    // if (winnLoss == WinLoss.win) {
    //   state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(winLoss: true));
    // } else if (winnLoss == WinLoss.loss) {
    //   state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(winLoss: false));
    // }
  }

  void editFirstSecond(FirstSecond firstSecond) {
    state = state.copyWith(
        editMargedRecord:
            state.editMargedRecord.copyWith(firstSecond: firstSecond)); // if (firstSecond == FirstSecond.first) {
    //   state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(firstSecond: true));
    // } else if (firstSecond == FirstSecond.second) {
    //   state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(firstSecond: false));
    // }
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
    final checkUseDeck = ref.read(editRecordHelper).checkIfSelectedUseDeckIsNew(state.margedRecord.useDeck);

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
    final checkOpponentDeck = ref.read(editRecordHelper).checkIfSelectedUseDeckIsNew(state.margedRecord.opponentDeck);

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
}

final recordDetailNotifierProvider =
    StateNotifierProvider.family.autoDispose<RecordDetailNotifier, RecordDetailState, MargedRecord>(
  (ref, margedRecord) {
    // 一覧からレコードを選択した瞬間の値のみがほしいため、watchで監視せずにreadで読み取っている
    final recordList = ref.read(allRecordListNotifierProvider).allRecordList;
    final record = recordList!.firstWhere((record) => record.recordId == margedRecord.recordId);
    final notifier = RecordDetailNotifier(ref, record, margedRecord);
    return notifier;
  },
);
