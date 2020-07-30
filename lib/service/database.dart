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
  static const recordContentsTableName = 'record_contents';
  static const nameTableName = 'name';
  static const tagTableName = 'tag';
  static const mappingNameRecordTableName = 'mapping_name_record';
  static const rankRateTableName = 'rank_rate';

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
        title TEXT NOT NULL,
        number_people INTEGER NOT NULL ,
        mode TEXT NOT NULL,
        tag_id INTEGER NOT NULL,
        is_edit INTEGER NOT NULL
      )
    ''');
    await database.execute('''
      CREATE TABLE $recordContentsTableName (
        record_contents_id INTEGER PRIMARY KEY AUTOINCREMENT,
        record_id INTEGER NOT NULL,
        name_id INTEGER NOT NULL,
        count INTEGER NOT NULL,
        score INTEGER NOT NULL,
        calc_score INTEGER
      )
    ''');
    await database.execute('''
      CREATE TABLE $nameTableName (
        name_id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        UNIQUE(name)
      )
    ''');
    await database.execute('''
      CREATE TABLE $tagTableName (
        tag_id INTEGER PRIMARY KEY AUTOINCREMENT,
        tag TEXT NOT NULL,
        UNIQUE(tag)
      )
    ''');
    await database.execute('''
      CREATE TABLE $mappingNameRecordTableName (
        mapping_id INTEGER PRIMARY KEY AUTOINCREMENT,
        name_id INTEGER NOT NULL,
        record_id INTEGER NOT NULL,
        UNIQUE(name_id, record_id)
      )
    ''');
    await database.execute('''
      CREATE TABLE $rankRateTableName (
        rank_rate_id INTEGER PRIMARY KEY AUTOINCREMENT,
        record_id INTEGER NOT NULL,
        rank INTEGER NOT NULL,
        rate INTEGER NOT NULL
      )
    ''');
    await database.insert(tagTableName, Tag(tag: 'default').toDatabaseJson());
  }
}
