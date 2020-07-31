class Tag {
  int tagId;
  String tag;
  int gameId;

  Tag({
    this.tagId,
    this.tag,
    this.gameId
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
