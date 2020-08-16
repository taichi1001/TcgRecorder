class Tag {
  int tagId;
  String tag;
  int gameId;

  Tag({
    this.tagId = 0,
    this.tag,
    this.gameId = 0,
  });

  factory Tag.fromDatabaseJson(Map<String, dynamic> data) => Tag(
        tagId: data['tag_id'],
        tag: data['tag'],
        gameId: data['game_id'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        'tag_id': tagId,
        'tag': tag,
        'game_id': gameId,
      };
}
