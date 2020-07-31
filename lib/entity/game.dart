class Game {
  int gameId;
  String game;

  Game({
    this.gameId,
    this.game,
  });

  factory Game.fromDatabaseJson(Map<String, dynamic> data) => Game(
        gameId: data['game_id'],
        game: data['game'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        'game_id': gameId,
        'game': game,
      };
}
