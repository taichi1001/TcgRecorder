class Deck {
  int deckId;
  String deck;
  int gameId;

  Deck({
    this.deckId,
    this.deck,
    this.gameId
  });

  factory Deck.fromDatabaseJson(Map<String, dynamic> data) => Deck(
        deckId: data['deck_id'],
        deck: data['deck'],
        gameId: data['game_id']
      );

  Map<String, dynamic> toDatabaseJson() => {
        'deck_id': deckId,
        'deck': deck,
        'game_id': gameId
      };
}
