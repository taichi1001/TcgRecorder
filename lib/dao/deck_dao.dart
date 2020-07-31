import 'package:tcg_recorder/entity/deck.dart';
import 'package:tcg_recorder/service/database.dart';

class DeckDao {
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.deckTableName;

  Future<int> create(Deck deck) async {
    final db = await dbProvider.database;
    final result = db.insert(tableName, deck.toDatabaseJson());
    return result;
  }

  Future<List<Deck>> getAll() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> result = await db.query(tableName);
    final List<Deck> decks = result.isNotEmpty
        ? result.map((item) => Deck.fromDatabaseJson(item)).toList()
        : [];
    return decks;
  }

  Future<int> update(Deck deck) async {
    final db = await dbProvider.database;
    final result = await db.update(tableName, deck.toDatabaseJson(),
        where: 'deck_id = ?', whereArgs: [deck.deckId]);
    return result;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    final result =
        await db.delete(tableName, where: 'deck_id = ?', whereArgs: [id]);
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
