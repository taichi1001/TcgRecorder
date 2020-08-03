import 'package:tcg_recorder/dao/deck_dao.dart';
import 'package:tcg_recorder/entity/deck.dart';

class DeckRepo {
  final deckDao = DeckDao();

  Future getAll() => deckDao.getAll();

  Future getGameDeck(int id) => deckDao.getGameDeck(id);

  Future insert(Deck deck) => deckDao.create(deck);

  Future update(Deck deck) => deckDao.update(deck);

  Future deleteById(int id) => deckDao.delete(id);

  //not use this
  Future deleteAll() => deckDao.deleteAll();
}
