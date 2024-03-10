import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/repository/firestore_public_user_data_repository.dart';
import 'package:tcg_manager/service/database.dart';

final deckRepository = Provider.autoDispose<DeckRepository>((ref) => DeckRepository(ref));

class DeckRepository {
  DeckRepository(this.ref);

  final Ref ref;
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.deckTableName;

  Future<List<Deck>> getAll() async {
    final db = await dbProvider.database;
    final result = await db.query(tableName);
    return result.isNotEmpty ? result.map((item) => Deck.fromJson(item)).toList() : [];
  }

  Future<List<Deck>> getGameDeck(int id) async {
    final db = await dbProvider.database;
    final result = await db.query(tableName, where: 'game_id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.map((item) => Deck.fromJson(item)).toList() : [];
  }

  Future<int> insert(Deck deck) async {
    final newId = await _insert(deck);
    ref.read(firestorePublicUserDataRepository).addDeck(deck.copyWith(id: newId), ref.read(firebaseAuthNotifierProvider).user!.uid);
    return newId;
  }

  Future<int> _insert(Deck deck) async {
    final db = await dbProvider.database;
    return db.insert(tableName, deck.toJson());
  }

  Future<int> update(Deck deck) async {
    final newId = await _update(deck);
    ref.read(firestorePublicUserDataRepository).updateDeck(deck, ref.read(firebaseAuthNotifierProvider).user!.uid);
    return newId;
  }

  Future<int> _update(Deck deck) async {
    final db = await dbProvider.database;
    try {
      return await db.update(tableName, deck.toJson(), where: 'deck_id = ?', whereArgs: [deck.id]);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Object?>> insertList(List<Deck> decks) async {
    final db = await dbProvider.database;
    final batch = db.batch();
    for (final deck in decks) {
      batch.insert(tableName, deck.toJson());
    }
    return await batch.commit();
  }

  Future<List<Object?>> updateDeckList(List<Deck> deckList) async {
    final db = await dbProvider.database;
    final batch = db.batch();
    for (final deck in deckList) {
      batch.update(tableName, deck.toJson(), where: 'deck_id = ?', whereArgs: [deck.id]);
    }
    return await batch.commit();
  }

  Future<int> delete(Deck deck) async {
    final newId = await _deleteById(deck.id!);
    ref.read(firestorePublicUserDataRepository).removeDeck(deck, ref.read(firebaseAuthNotifierProvider).user!.uid);
    return newId;
  }

  Future<int> _deleteById(int id) async {
    final db = await dbProvider.database;
    return await db.delete(tableName, where: 'deck_id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    final db = await dbProvider.database;
    return await db.delete(tableName);
  }
}
