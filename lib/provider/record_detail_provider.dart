import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/helper/edit_record_helper.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/repository/record_repository.dart';
import 'package:tcg_manager/state/record_detail_state.dart';

class RecordDetailNotifier extends StateNotifier<RecordDetailState> {
  RecordDetailNotifier(this.ref, this.record, this.margedRecord)
      : super(RecordDetailState(record: record, margedRecord: margedRecord));

  final Ref ref;
  final Record record;
  final MargedRecord margedRecord;

  void changeIsEdit() {
    state = state.copyWith(isEdit: !state.isEdit);
  }

  void editUseDeck(String name) {
    state = state.copyWith(editMargedRecord: state.margedRecord.copyWith(useDeck: name));
  }

  void editOpponentDeck(String name) {
    state = state.copyWith(editMargedRecord: state.margedRecord.copyWith(opponentDeck: name));
  }

  Future saveEdit() async {
    // 変更が無かった場合に何もしない
    if (state.editMargedRecord == null) return;
    // 編集したrecord(EditMargedRecord)を表示用のrecord(MargedRecord)に設定
    state = state.copyWith(margedRecord: state.editMargedRecord!);

    // 各種値の保存、ID取得、recordへのID設定
    // ここの処理は各種値が編集済みが未編集かに関わらず実行される
    // 編集済みのみ実行するようにすればパフォーマンスは上がるかも
    await _saveEditUseDeck();
    await _saveEditOpponentDeck();

    // recordを上書き
    await ref.read(recordRepository).update(state.record);
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
    final recordList = ref.watch(allRecordListNotifierProvider).allRecordList;
    final record = recordList!.firstWhere((record) => record.recordId == margedRecord.recordId);
    final notifier = RecordDetailNotifier(ref, record, margedRecord);
    return notifier;
  },
);
