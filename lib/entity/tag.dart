class Tag {
  int tagId;
  String tag;
  int gameId;
  bool isVisibleToPicker;

  Tag({
    this.tagId = 0,
    this.tag,
    this.gameId = 0,
    this.isVisibleToPicker = true,
  });

  factory Tag.fromDatabaseJson(Map<String, dynamic> data) => Tag(
        tagId: data['tag_id'],
        tag: data['tag'],
        gameId: data['game_id'],
        isVisibleToPicker: data['is_visible_to_picker'] == 1 ? true : false,
      );

  Map<String, dynamic> toDatabaseJson() => {
        'tag_id': tagId,
        'tag': tag,
        'game_id': gameId,
        'is_visible_to_picker': isVisibleToPicker ? 1 : 0,
      };
}
