import 'package:tcg_recorder/dao/mapping_name_record_dao.dart';
import 'package:tcg_recorder/entity/mapping_name_record.dart';

class MappingNameRecordRepo {
  final mappingNameRecordDao = CorrespondenceNameRecordDao();

  Future getAllMapping() => mappingNameRecordDao.getAll();

  Future insertMapping(MappingNameRecord correspondence) =>
      mappingNameRecordDao.create(correspondence);

  Future updateMapping(MappingNameRecord correspondence) =>
      mappingNameRecordDao.update(correspondence);

  Future deleteMappingById(int id) =>
      mappingNameRecordDao.delete(id);

  Future deleteMappingByRecordId(int id) =>
      mappingNameRecordDao.deleteByRecordId(id);
  //not use this
  Future deleteAllMapping() => mappingNameRecordDao.deleteAll();
}
