class MappingNameRecord {
  int mappingId;
  int nameId;
  int recordId;

  MappingNameRecord({this.mappingId, this.nameId, this.recordId});

  factory MappingNameRecord.fromDatabaseJson(Map<String, dynamic> data) =>
      MappingNameRecord(
          mappingId: data['mapping_id'],
          nameId: data['name_id'],
          recordId: data['record_id']);

  Map<String, dynamic> toDatabaseJson() => {
        'mapping_id': mappingId,
        'name_id': nameId,
        'record_id': recordId,
      };
}
