import 'package:tcg_recorder/dao/name_dao.dart';
import 'package:tcg_recorder/entity/name.dart';

class NameRepo {
  final nameDao = NameDao();

  Future getAllName() => nameDao.getAll();

  Future insertName(Name name) => nameDao.create(name);

  Future updateName(Name name) => nameDao.update(name);

  Future deleteNameById(int id) => nameDao.delete(id);

  //not use this
  Future deleteAllName() => nameDao.deleteAll();
}
