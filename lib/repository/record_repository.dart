import 'package:tcg_recorder/dao/record_dao.dart';
import 'package:tcg_recorder/entity/record.dart';

class RecordRepo {
  final recordDao = RecordDao();

  Future getAllRecords() => recordDao.getAll();

  Future insertRecord(Record todo) => recordDao.create(todo);

  Future updateRecord(Record todo) => recordDao.update(todo);

  Future deleteRecordById(int id) => recordDao.delete(id);

  //not use this sample
  Future deleteAllRecords() => recordDao.deleteAll();
}
