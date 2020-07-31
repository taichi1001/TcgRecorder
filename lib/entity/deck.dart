class Deck {
  int deckId;
  String deck;

  Deck({
    this.deckId,
    this.deck,
  });

  factory Deck.fromDatabaseJson(Map<String, dynamic> data) => Deck(
        deckId: data['deck_id'],
        deck: data['deck'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        'deck_id': deckId,
        'deck': deck,
      };
}
