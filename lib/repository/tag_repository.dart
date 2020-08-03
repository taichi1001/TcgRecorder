import 'package:tcg_recorder/dao/tag_dao.dart';
import 'package:tcg_recorder/entity/tag.dart';

class TagRepo {
  final tagDao = TagDao();

  Future getAll() => tagDao.getAll();

  Future getGameTag(int id) => tagDao.getGameTag(id);

  Future insert(Tag tag) => tagDao.create(tag);

  Future update(Tag tag) => tagDao.update(tag);

  Future deleteById(int id) => tagDao.delete(id);

  //not use this
  Future deleteAllTag() => tagDao.deleteAll();
}
