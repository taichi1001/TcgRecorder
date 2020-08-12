import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/deck.dart';
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
    if (allDeckList.isNotEmpty) {
      selectedUseDeck = allDeckList[0];
      selectedOpponentDeck = allDeckList[0];
    } else {
      selectedUseDeck = null;
      selectedOpponentDeck = null;
    }
    notifyListeners();
  }

  Future getGameDeckList(int id) async {
    gameDeckList = await deckRepo.getGameDeck(id);
    notifyListeners();
  }

  void selectedUseDeckChangeToIndex(int index) {
    selectedUseDeck = gameDeckList[index];
    notifyListeners();
  }

  void selectedOpponentDeckChangeToIndex(int index) {
    selectedOpponentDeck = gameDeckList[index];
    notifyListeners();
  }

  void selectedUseDeckChangeToString(String newValue) {
    if (newValue == '') {
      selectedUseDeck = null;
    } else if (gameDeckList.where((value) => value.deck == newValue).isEmpty) {
      selectedUseDeck = Deck(deck: newValue);
    } else {
      selectedUseDeck =
          gameDeckList.where((value) => value.deck == newValue).toList()[0];
    }
    notifyListeners();
  }

  void selectedOpponentDeckChangeToString(String newValue) {
    if (newValue == '') {
      selectedOpponentDeck = null;
    } else if (gameDeckList.where((value) => value.deck == newValue).isEmpty) {
      selectedOpponentDeck = Deck(deck: newValue);
    } else {
      selectedOpponentDeck =
          gameDeckList.where((value) => value.deck == newValue).toList()[0];
    }
    notifyListeners();
  }

  void findMyDeckFromRecord(Record record) {
    record.myDeck = allDeckList
        .where((value) => value.deckId == record.myDeckId)
        .toList()[0]
        .deck;
  }

  void findOpponentDeckFromRecord(Record record) {
    record.opponentDeck = allDeckList
        .where((value) => value.deckId == record.opponentDeckId)
        .toList()[0]
        .deck;
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
