class Deck {
  int deckId;
  String deck;
  int gameId;
  bool isVisibleToPicker;

  Deck({
    this.deckId = 0,
    this.deck,
    this.gameId = 0,
    this.isVisibleToPicker = true,
  });

  factory Deck.fromDatabaseJson(Map<String, dynamic> data) => Deck(
        deckId: data['deck_id'],
        deck: data['deck'],
        gameId: data['game_id'],
        isVisibleToPicker: data['is_visible_to_picker'] == 1 ? true : false,
      );

  Map<String, dynamic> toDatabaseJson() => {
        'deck_id': deckId,
        'deck': deck,
        'game_id': gameId,
        'is_visible_to_picker': isVisibleToPicker ? 1 : 0,
      };
}
