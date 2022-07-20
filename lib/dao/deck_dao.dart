import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/service/database.dart';

class DeckDao {
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.deckTableName;

  Future<int> create(Deck deck) async {
    final db = await dbProvider.database;
    final result = db.insert(tableName, deck.toJson());
    return result;
  }

  Future<List<Deck>> getAll() async {
    final db = await dbProvider.database;
    final result = await db.query(tableName);
    final List<Deck> decks = result.isNotEmpty ? result.map((item) => Deck.fromJson(item)).toList() : [];
    return decks;
  }

  Future<List<Deck>> getGameDeck(int id) async {
    final db = await dbProvider.database;
    final result = await db.query(tableName, where: 'game_id = ?', whereArgs: [id]);
    final List<Deck> decks = result.isNotEmpty ? result.map((item) => Deck.fromJson(item)).toList() : [];
    return decks;
  }

  Future<int> update(Deck deck) async {
    final db = await dbProvider.database;
    try {
      final result = await db.update(tableName, deck.toJson(), where: 'deck_id = ?', whereArgs: [deck.deckId]);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Object?>> updateDeckList(List<Deck> deckList) async {
    final db = await dbProvider.database;
    final batch = db.batch();
    for (final deck in deckList) {
      batch.update(tableName, deck.toJson(), where: 'deck_id = ?', whereArgs: [deck.deckId]);
    }
    final result = await batch.commit();
    return result;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    final result = await db.delete(tableName, where: 'deck_id = ?', whereArgs: [id]);
    return result;
  }

  //not use this sample
  Future deleteAll() async {
    final db = await dbProvider.database;
    final result = await db.delete(
      tableName,
    );

    return result;
  }
}
