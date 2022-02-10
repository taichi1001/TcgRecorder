import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';

class CheckDeckResult {
  CheckDeckResult({required this.isNew, this.deck});
  bool isNew;
  Deck? deck;
}

class EditRecordHelper {
  EditRecordHelper(this.read);
  final Reader read;

  /// 入力されたデッキ名がDBに存在するかをチェックする
  ///
  /// 存在する場合にFalse, しない場合にTrueを返す
  CheckDeckResult checkIfSelectedUseDeckIsNew(String deckName) {
    final gameDeckList = read(gameDeckListProvider);
    final matchList = gameDeckList.where((Deck deck) => deck.deck == deckName);
    if (matchList.isEmpty) {
      return CheckDeckResult(isNew: true);
    }
    return CheckDeckResult(isNew: false, deck: matchList.first);
  }
}

final editRecordHelper = Provider((ref) => EditRecordHelper(ref.read));
