import 'package:tcg_recorder/service/database.dart';
import 'package:tcg_recorder/entity/rank_rate.dart';

class RankRateDao {
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.rankRateTableName;

  Future<int> create(RankRate rankRate) async {
    final db = await dbProvider.database;
    final result = db.insert(tableName, rankRate.toDatabaseJson());
    return result;
  }

  Future<List<RankRate>> getAll() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> result = await db.query(tableName);
    final List<RankRate> rankRate = result.isNotEmpty
        ? result.map((item) => RankRate.fromDatabaseJson(item)).toList()
        : [];
    return rankRate;
  }

  Future<List<RankRate>> getRecordId(int id) async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> result =
        await db.query(tableName, where: 'record_id = ?', whereArgs: [id]);
    final List<RankRate> rankRate = result.isNotEmpty
        ? result.map((item) => RankRate.fromDatabaseJson(item)).toList()
        : [];
    return rankRate;
  }

  Future<int> update(RankRate rankRate) async {
    final db = await dbProvider.database;
    final result = await db.update(tableName, rankRate.toDatabaseJson(),
        where: 'rank_rate_id = ?', whereArgs: [rankRate.rankRateId]);
    return result;
  }

  Future<int> delete(int id) async {
    final db = await dbProvider.database;
    final result =
        await db.delete(tableName, where: 'rank_rate_id = ?', whereArgs: [id]);
    return result;
  }

  Future<int> deleteByRecordId(int id) async {
    final db = await dbProvider.database;
    final result =
        await db.delete(tableName, where: 'record_id = ?', whereArgs: [id]);
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
