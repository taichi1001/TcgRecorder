import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/deck.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/repository/deck_repository.dart';

class DeckModel with ChangeNotifier {
  List<Deck> allDeckList = [];
  List<Deck> gameDeckList = [];
  Deck selectedUseDeck;
  Deck selectedOpponentDeck;

  final deckRepo = DeckRepo();

  DeckModel() {
    _fetchAll();
  }

  Future _fetchAll() async {
    allDeckList = await deckRepo.getAll();
    selectedUseDeck = null;
    selectedOpponentDeck = null;
    notifyListeners();
  }

  Future getGameDeckList(int id) async {
    gameDeckList = await deckRepo.getGameDeck(id);
    gameDeckList.insert(0, Deck(deck: ''));
    notifyListeners();
  }

  void changeSelectedUseDeckUsingIndex(int index) {
    selectedUseDeck = gameDeckList[index];
    notifyListeners();
  }

  void changeSelectedOpponentDeckUsingIndex(int index) {
    selectedOpponentDeck = gameDeckList[index];
    notifyListeners();
  }

  void changeSelectedUseDeckUsingString(String newValue) {
    if (newValue == '') {
      selectedUseDeck = null;
    } else if (gameDeckList.where((value) => value.deck == newValue).isEmpty) {
      selectedUseDeck = Deck(deck: newValue);
    } else {
      selectedUseDeck = gameDeckList.where((value) => value.deck == newValue).toList()[0];
    }
    notifyListeners();
  }

  void changeSelectedOpponentDeckUsingString(String newValue) {
    if (newValue == '') {
      selectedOpponentDeck = null;
    } else if (gameDeckList.where((value) => value.deck == newValue).isEmpty) {
      selectedOpponentDeck = Deck(deck: newValue);
    } else {
      selectedOpponentDeck = gameDeckList.where((value) => value.deck == newValue).toList()[0];
    }
    notifyListeners();
  }

  void findMyDeckFromRecord(Record record) {
    record.myDeck = allDeckList.where((value) => value.deckId == record.myDeckId).toList()[0].deck;
  }

  Future addSelectedUseDeck(Game game) async {
    if (selectedUseDeck.deckId != 0) return;
    selectedUseDeck.deckId = null;
    selectedUseDeck.gameId = game.gameId;
    final deckId = await deckRepo.insert(selectedUseDeck);
    selectedUseDeck.deckId = deckId;
    allDeckList = await deckRepo.getAll();
    notifyListeners();
  }

  Future addSelectedOpponentDeck(Game game) async {
    if (selectedOpponentDeck.deckId != 0) return;
    selectedOpponentDeck.deckId = null;
    selectedOpponentDeck.gameId = game.gameId;
    final deckId = await deckRepo.insert(selectedOpponentDeck);
    selectedOpponentDeck.deckId = deckId;
    allDeckList = await deckRepo.getAll();
    notifyListeners();
  }

  void findOpponentDeckFromRecord(Record record) {
    record.opponentDeck =
        allDeckList.where((value) => value.deckId == record.opponentDeckId).toList()[0].deck;
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
