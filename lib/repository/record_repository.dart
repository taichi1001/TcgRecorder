import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/dao/record_dao.dart';
import 'package:tcg_recorder2/entity/record.dart';

final recordRepository =
    Provider.autoDispose<RecordRepository>((ref) => RecordRepositoryImpl(ref.read));

abstract class RecordRepository {
  Future<List<Record>> getAll();

  Future<List<Record>> getGameRecord(int id);

  Future<List<Record>> getTagRecord(int id);

  Future<int> insert(Record record);

  Future<int> update(Record record);

  Future<int> deleteById(int id);

  Future deleteAll();
}

class RecordRepositoryImpl implements RecordRepository {
  RecordRepositoryImpl(this.read);

  final Reader read;
  final recordDao = RecordDao();

  @override
  Future<List<Record>> getAll() => recordDao.getAll();

  @override
  Future<List<Record>> getGameRecord(int id) => recordDao.getGameRecord(id);

  @override
  Future<List<Record>> getTagRecord(int id) => recordDao.getTagRecord(id);

  @override
  Future<int> insert(Record record) => recordDao.create(record);

  @override
  Future<int> update(Record record) => recordDao.update(record);

  @override
  Future<int> deleteById(int id) => recordDao.delete(id);

  @override
  Future deleteAll() => recordDao.deleteAll();
}
