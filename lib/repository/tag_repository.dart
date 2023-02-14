import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/dao/tag_dao.dart';
import 'package:tcg_manager/entity/tag.dart';

final tagRepository = Provider.autoDispose<TagRepository>((ref) => TagRepositoryImpl(ref));

abstract class TagRepository {
  Future<List<Tag>> getAll();

  Future<List<Tag>> getGameTag(int id);

  Future<int> insert(Tag tag);

  Future<int> update(Tag tag);

  Future insertList(List<Tag> games);

  Future<List<Object?>> updateTagList(List<Tag> tagList);

  Future<int> deleteById(int id);

  Future deleteAll();
}

class TagRepositoryImpl implements TagRepository {
  TagRepositoryImpl(this.ref);

  final Ref ref;
  final tagDao = TagDao();

  @override
  Future<List<Tag>> getAll() => tagDao.getAll();

  @override
  Future<List<Tag>> getGameTag(int id) => tagDao.getGameTag(id);

  @override
  Future<int> insert(Tag tag) => tagDao.create(tag);

  @override
  Future<int> update(Tag tag) => tagDao.update(tag);

  @override
  Future insertList(List<Tag> tags) => tagDao.insertTagList(tags);

  @override
  Future<List<Object?>> updateTagList(List<Tag> tagList) => tagDao.updateTagList(tagList);

  @override
  Future<int> deleteById(int id) => tagDao.delete(id);

  @override
  Future deleteAll() => tagDao.deleteAll();
}
