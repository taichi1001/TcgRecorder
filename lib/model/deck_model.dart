import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/deck.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/repository/deck_repository.dart';

class DeckModel with ChangeNotifier {
  Game game;
  List<Deck> gameDeckList;

  final deckRepo = DeckRepo();

  DeckModel(this.game) {
    _fetchAll();
  }

  Future _fetchAll() async {
    gameDeckList = await deckRepo.getGameDeck(game.gameId);
    notifyListeners();
  }

  Future add(Deck deck) async {
    deckRepo.insert(deck);
    _fetchAll();
  }

  Future update(Deck deck) async {
    await deckRepo.update(deck);
    _fetchAll();
  }

  Future remove(Deck deck) async {
    await deckRepo.deleteById(deck.deckId);
    _fetchAll();
  }
}
