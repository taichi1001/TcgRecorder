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

  void selectUseDeck(Deck deck) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(useDeck: deck.deck));
  }

  void editOpponentDeck(String name) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(opponentDeck: name));
  }

  void selectOpponentDeck(Deck deck) {
    state = state.copyWith(editMargedRecord: state.editMargedRecord.copyWith(opponentDeck: deck.deck));
  }

  void editTag(String name, int index) {
    final newTags = [...state.editMargedRecord.tag];
    if (newTags.length > index) {
      newTags[index] = name;
    } else if (newTags.length - index <= 0) {
      for (var i = newTags.length - index; i < 0; i++) {
        newTags.add('');
      }
      newTags.add(name);
    }
    state = state.copyWith(
      editMargedRecord: state.editMargedRecord.copyWith(
        tag: newTags,
      ),
    );
  }

  void selectTag(Tag tag, int index) {
    final newTags = [...state.editMargedRecord.tag];
    if (newTags.length > index) {
      newTags[index] = tag.tag;
    } else if (newTags.length - index <= 0) {
      for (var i = newTags.length - index; i < 0; i++) {
        newTags.add('');
      }
      newTags.add(tag.tag);
    }
    state = state.copyWith(
      editMargedRecord: state.editMargedRecord.copyWith(
        tag: newTags,
      ),
    );
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
    if (state.margedRecord.tag.isEmpty) return;
    final List<int> newTags = [];
    for (final tag in state.margedRecord.tag) {
      if (tag == '') continue;
      // 入力されたタグが新規のものかどうかを判定
      final checkTag = await ref.read(editRecordHelper).checkIfSelectedTagIsNew(tag);
      // 新規だった場合
      if (checkTag.isNew) {
        // 入力された対戦デッキをDBに登録しデッキIDを取得
        final newId = await ref.read(tagRepository).insert(
              Tag(tag: tag, gameId: state.record.gameId),
            );
        newTags.add(newId);
      } else {
        // 既に登録済みのタグだった場合、そのタグのIDをrecordに登録
        newTags.add(checkTag.tag!.tagId!);
      }
    }
    state = state.copyWith(record: state.record.copyWith(tagId: newTags));
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
  return RecordDetailNotifier(ref: ref, record: record, margedRecord: margedRecord);
});
