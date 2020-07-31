import 'package:tcg_recorder/dao/deck_dao.dart';
import 'package:tcg_recorder/entity/deck.dart';

class DeckRepo {
  final deckDao = DeckDao();

  Future getAllTag() => deckDao.getAll();

  Future insertTag(Deck deck) => deckDao.create(deck);

  Future updateTag(Deck deck) => deckDao.update(deck);

  Future deleteTagById(int id) => deckDao.delete(id);

  //not use this
  Future deleteAllTag() => deckDao.deleteAll();
}
