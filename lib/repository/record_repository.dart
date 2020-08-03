import 'package:tcg_recorder/dao/record_dao.dart';
import 'package:tcg_recorder/entity/record.dart';

class RecordRepo {
  final recordDao = RecordDao();

  Future getAll() => recordDao.getAll();

  Future getGameRecord(int id) => recordDao.getGameRecord(id);

  Future getTagRecord(int id) => recordDao.getGameRecord(id);

  Future insert(Record record) => recordDao.create(record);

  Future update(Record record) => recordDao.update(record);

  Future deleteById(int id) => recordDao.delete(id);

  //not use this
  Future deleteAll() => recordDao.deleteAll();
}
