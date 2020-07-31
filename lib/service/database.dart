import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tcg_recorder/entity/tag.dart';

class DatabaseService {
  static const _databaseVersion = 1;
  static const _databaseName = 'record.db';

  //tableName
  static const recordTableName = 'record';
  static const gameTableName = 'game';
  static const deckTableName = 'deck';
  static const tagTableName = 'tag';

  static final DatabaseService dbProvider = DatabaseService();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  Future createDatabase() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, _databaseName);

    final database = await openDatabase(path,
        version: _databaseVersion, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //not use this sample
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  Future initDB(Database database, int version) async {
    await database.execute('''
      CREATE TABLE $recordTableName (
        record_id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        game_id INTEGER NOT NULL,
        tag_id INTEGER NOT NULL ,
        my_deck_id INTEGER NOT NULL,
        opponent_deck_id INTEGER NOT NULL,
        first_or_seconde INTEGER NOT NULL,
        win_or_lose INTEGER NOT NULL,
        memo TEXT
      )
    ''');
    await database.execute('''
      CREATE TABLE $gameTableName (
        game_id INTEGER PRIMARY KEY AUTOINCREMENT,
        game TEXT NOT NULL
      )
    ''');
    await database.execute('''
      CREATE TABLE $deckTableName (
        deck_id INTEGER PRIMARY KEY AUTOINCREMENT,
        deck TEXT NOT NULL,
        game_id INTEGER NOT NULL
      )
    ''');
    await database.execute('''
      CREATE TABLE $tagTableName (
        tag_id INTEGER PRIMARY KEY AUTOINCREMENT,
        tag TEXT NOT NULL,
        game_id INTEGER NOT NULL
      )
    ''');
    await database.insert(tagTableName, Tag(tag: 'default').toDatabaseJson());
  }
}
