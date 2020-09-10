import 'package:tcg_recorder/dao/deck_dao.dart';
import 'package:tcg_recorder/entity/deck.dart';
import 'package:tcg_recorder/repository/deck_repository.dart';

final List<Deck> _allDeckList = [
  Deck(deckId: 1, deck: 'ボルバル', gameId: 1),
  Deck(deckId: 2, deck: 'イニシエート', gameId: 1),
  Deck(deckId: 3, deck: 'ガーディアン', gameId: 1),
  Deck(deckId: 4, deck: 'ウェーブストライカー', gameId: 1),
  Deck(deckId: 5, deck: 'ドルゲーザ', gameId: 1),
  Deck(deckId: 6, deck: '赤単', gameId: 2),
  Deck(deckId: 7, deck: 'アゾリウスコントロール', gameId: 2),
  Deck(deckId: 8, deck: 'バントミットレンジ', gameId: 2),
  Deck(deckId: 9, deck: 'オーコ', gameId: 2),
  Deck(deckId: 10, deck: '青単', gameId: 2),
];

class DeckRepoMock implements DeckRepo {
  @override
  final deckDao = DeckDao();

  @override
  Future getAll() => all();

  @override
  Future getGameDeck(int id) => getid(id);

  @override
  Future insert(Deck deck) async {}

  @override
  Future update(Deck deck) async {}

  @override
  Future deleteById(int id) async {}

  //not use this
  @override
  Future deleteAll() async {}

  Future<List<Deck>> all() async {
    return _allDeckList;
  }

  Future<List<Deck>> getid(int id) async {
    return _allDeckList.where((element) => element.gameId == id).toList();
  }
}
