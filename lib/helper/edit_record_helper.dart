import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/selector/game_tag_list_selector.dart';

class CheckDeckResult {
  CheckDeckResult({required this.isNew, this.deck});
  bool isNew;
  Deck? deck;
}

class CheckTagResult {
  CheckTagResult({required this.isNew, this.tag});
  bool isNew;
  Tag? tag;
}

class EditRecordHelper {
  EditRecordHelper(this.read);
  final Reader read;

  /// 入力されたデッキ名がDBに存在するかをチェックする
  ///
  /// 存在する場合にFalse, しない場合にTrueを返す
  Future<CheckDeckResult> checkIfSelectedUseDeckIsNew(String deckName) async {
    final gameDeckList = await read(gameDeckListProvider.future);
    final matchList = gameDeckList.where((Deck deck) => deck.deck == deckName);
    if (matchList.isEmpty) {
      return CheckDeckResult(isNew: true);
    }
    return CheckDeckResult(isNew: false, deck: matchList.first);
  }

  /// 入力されたタグ名がDBに存在するかをチェックする
  ///
  /// 存在する場合にFalse, しない場合にTrueを返す
  CheckTagResult checkIfSelectedTagIsNew(String tagName) {
    final gameTagList = read(gameTagListProvider);
    final matchList = gameTagList.where((Tag tag) => tag.tag == tagName);
    if (matchList.isEmpty) {
      return CheckTagResult(isNew: true);
    }
    return CheckTagResult(isNew: false, tag: matchList.first);
  }
}

final editRecordHelper = Provider((ref) => EditRecordHelper(ref.read));
