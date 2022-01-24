import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/dao/deck_dao.dart';
import 'package:tcg_recorder2/entity/deck.dart';

final deckRepository = Provider.autoDispose<DeckRepository>((ref) => DeckRepositoryImpl(ref.read));

abstract class DeckRepository {
  Future<List<Deck>> getAll();

  Future<List<Deck>> getGameDeck(int id);

  Future<int> insert(Deck deck);

  Future<int> update(Deck deck);

  Future<int> deleteById(int id);

  Future deleteAll();
}

class DeckRepositoryImpl implements DeckRepository {
  DeckRepositoryImpl(this.read);

  final Reader read;
  final deckDao = DeckDao();

  @override
  Future<List<Deck>> getAll() => deckDao.getAll();

  @override
  Future<List<Deck>> getGameDeck(int id) => deckDao.getGameDeck(id);

  @override
  Future<int> insert(Deck deck) => deckDao.create(deck);

  @override
  Future<int> update(Deck deck) => deckDao.update(deck);

  @override
  Future<int> deleteById(int id) => deckDao.delete(id);

  @override
  Future deleteAll() => deckDao.deleteAll();
}
