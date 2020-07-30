class Tag {
  int tagId;
  String tag;

  Tag({
    this.tagId,
    this.tag,
  });

  factory Tag.fromDatabaseJson(Map<String, dynamic> data) => Tag(
        tagId: data['tag_id'],
        tag: data['tag'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        'tag_id': tagId,
        'tag': tag,
      };
}
