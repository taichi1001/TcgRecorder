import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/record_old.dart';

class DatabaseService {
  static const _databaseVersion = 4;
  static const _databaseName = 'record.db';

  //tableName
  static const recordTableName = 'record';
  static const gameTableName = 'game';
  static const deckTableName = 'deck';
  static const tagTableName = 'tag';

  static final DatabaseService dbProvider = DatabaseService();

  Future<Database> get database async {
    return await createDatabase();
  }

  Future createDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);

    final database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: initDB,
      onUpgrade: onUpgrade,
    );
    return database;
  }

  Future onUpgrade(Database database, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {
      if (oldVersion < 2) {
        database.execute('ALTER TABLE $deckTableName ADD sort_index INTEGER');
        database.execute('ALTER TABLE $tagTableName ADD sort_index INTEGER');
      }
      if (oldVersion < 3) {
        database.execute('ALTER TABLE $recordTableName ADD first_match_first_second INTEGER');
        database.execute('ALTER TABLE $recordTableName ADD second_match_first_second INTEGER');
        database.execute('ALTER TABLE $recordTableName ADD third_match_first_second INTEGER');
        database.execute('ALTER TABLE $recordTableName ADD first_match_win_loss INTEGER');
        database.execute('ALTER TABLE $recordTableName ADD second_match_win_loss INTEGER');
        database.execute('ALTER TABLE $recordTableName ADD third_match_win_loss INTEGER');
        database.execute('ALTER TABLE $recordTableName ADD bo INTEGER');
        database.execute('ALTER TABLE $recordTableName ADD image_path TEXT');
      }

      if (oldVersion < 4) {
        await database.execute(
            '''
          CREATE TABLE ${recordTableName}_new (
          record_id INTEGER PRIMARY KEY AUTOINCREMENT,
          date TEXT NOT NULL,
          game_id INTEGER NOT NULL,
          tag_id TEXT,
          use_deck_id INTEGER NOT NULL,
          opponent_deck_id INTEGER NOT NULL,
          first_second INTEGER NOT NULL,
          first_match_first_second INTEGER,
          second_match_first_second INTEGER,
          third_match_first_second INTEGER,
          win_loss INTEGER NOT NULL,
          first_match_win_loss INTEGER,
          second_match_win_loss INTEGER,
          third_match_win_loss INTEGER,
          bo INTEGER,
          memo TEXT,
          image_path TEXT
          )
        ''');
        final oldData = await database.query(recordTableName);
        final List<RecordOld> recordOldList = oldData.isNotEmpty ? oldData.map((item) => RecordOld.fromJson(item)).toList() : [];
        final newRecordList = recordOldList
            .map((recordOld) => Record(
                  recordId: recordOld.recordId,
                  gameId: recordOld.gameId,
                  tagId: recordOld.tagId != null ? [recordOld.tagId!] : [],
                  useDeckId: recordOld.useDeckId,
                  opponentDeckId: recordOld.opponentDeckId,
                  date: recordOld.date,
                  bo: recordOld.bo,
                  firstSecond: recordOld.firstSecond,
                  firstMatchFirstSecond: recordOld.firstMatchFirstSecond,
                  secondMatchFirstSecond: recordOld.secondMatchFirstSecond,
                  thiredMatchFirstSecond: recordOld.thiredMatchFirstSecond,
                  winLoss: recordOld.winLoss,
                  firstMatchWinLoss: recordOld.firstMatchWinLoss,
                  secondMatchWinLoss: recordOld.secondMatchWinLoss,
                  thirdMatchWinLoss: recordOld.thirdMatchWinLoss,
                  memo: recordOld.memo,
                  imagePath: recordOld.imagePath,
                ))
            .toList();
        final batch = database.batch();
        for (final record in newRecordList) {
          batch.insert('${recordTableName}_new', record.toJson());
        }
        await batch.commit();
        await database.execute('DROP TABLE $recordTableName');
        await database.execute('ALTER TABLE ${recordTableName}_new RENAME TO $recordTableName;');
      }
    }
  }

  Future initDB(Database database, int version) async {
    await database.execute(
        '''
      CREATE TABLE $recordTableName (
        record_id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        game_id INTEGER NOT NULL,
        tag_id TEXT,
        use_deck_id INTEGER NOT NULL,
        opponent_deck_id INTEGER NOT NULL,
        first_second INTEGER NOT NULL,
        first_match_first_second INTEGER,
        second_match_first_second INTEGER,
        third_match_first_second INTEGER,
        win_loss INTEGER NOT NULL,
        first_match_win_loss INTEGER,
        second_match_win_loss INTEGER,
        third_match_win_loss INTEGER,
        bo INTEGER,
        memo TEXT,
        image_path TEXT
      )
    ''');
    await database.execute(
        '''
      CREATE TABLE $gameTableName (
        game_id INTEGER PRIMARY KEY AUTOINCREMENT,
        game TEXT NOT NULL,
        is_visible_to_picker INTEGER NOT NULL,
        unique(game)
      )
    ''');
    await database.execute(
        '''
      CREATE TABLE $deckTableName (
        deck_id INTEGER PRIMARY KEY AUTOINCREMENT,
        deck TEXT NOT NULL,
        game_id INTEGER NOT NULL,
        is_visible_to_picker INTEGER NOT NULL,
        sort_index INTEGER,
        unique(deck, game_id)
      )
    ''');
    await database.execute(
        '''
      CREATE TABLE $tagTableName (
        tag_id INTEGER PRIMARY KEY AUTOINCREMENT,
        tag TEXT NOT NULL,
        game_id INTEGER NOT NULL,
        is_visible_to_picker INTEGER NOT NULL,
        sort_index INTEGER,
        unique(tag, game_id)
      )
    ''');
  }
}
