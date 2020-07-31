import 'package:tcg_recorder/dao/record_dao.dart';
import 'package:tcg_recorder/entity/record.dart';

class RecordRepo {
  final recordDao = RecordDao();

  Future getAllTag() => recordDao.getAll();

  Future insertTag(Record record) => recordDao.create(record);

  Future updateTag(Record record) => recordDao.update(record);

  Future deleteTagById(int id) => recordDao.delete(id);

  //not use this
  Future deleteAllTag() => recordDao.deleteAll();
}
