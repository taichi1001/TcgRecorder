import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/deck.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/repository/deck_repository.dart';

class DeckModel with ChangeNotifier {
  List<Deck> allDeckList = [];
  List<Deck> gameDeckList = [];
  List<Deck> showDeckList = [];
  Deck selectedUseDeck;
  Deck selectedOpponentDeck;

  final DeckRepo deckRepo;

  DeckModel(this.deckRepo) {
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

  Future makeShowDeckList(int id) async {
    showDeckList = await deckRepo.getGameDeck(id);
    notifyListeners();
  }

  void findMyDeckFromRecord(Record record) {
    record.myDeck =
        allDeckList.where((value) => value.deckId == record.myDeckId).toList().first.deck;
  }

  void findOpponentDeckFromRecord(Record record) {
    record.opponentDeck =
        allDeckList.where((value) => value.deckId == record.opponentDeckId).toList().first.deck;
  }

  void changeSelectedUseDeckUsingIndex(int index) {
    selectedUseDeck = gameDeckList[index];
    if (selectedUseDeck.deck == '') selectedUseDeck = null;
    notifyListeners();
  }

  void changeSelectedOpponentDeckUsingIndex(int index) {
    selectedOpponentDeck = gameDeckList[index];
    if (selectedOpponentDeck.deck == '') selectedOpponentDeck = null;
    notifyListeners();
  }

  void changeSelectedUseDeckUsingString(String newValue) {
    if (newValue == '') {
      selectedUseDeck = Deck(deck: '');
    } else {
      selectedUseDeck = Deck(deck: newValue);
      _changeItIfSelectedUseDeckInDb();
    }
    notifyListeners();
  }

  void changeSelectedOpponentDeckUsingString(String newValue) {
    if (newValue == '') {
      selectedOpponentDeck = Deck(deck: '');
    } else {
      selectedOpponentDeck = Deck(deck: newValue);
      _changeItIfSelectedOpponentDeckInDb();
    }
    notifyListeners();
  }

  void _changeItIfSelectedUseDeckInDb() {
    final list = gameDeckList.where((value) => value.deck == selectedUseDeck.deck).toList();
    if (list.isNotEmpty) selectedUseDeck = list.first;
  }

  void _changeItIfSelectedOpponentDeckInDb() {
    final list = gameDeckList.where((value) => value.deck == selectedOpponentDeck.deck).toList();
    if (list.isNotEmpty) selectedOpponentDeck = list.first;
  }

  Future addSelectedUseDeck(Game game) async {
    _changeItIfSelectedUseDeckInDb();
    if (selectedUseDeck.deckId == 0) {
      selectedUseDeck.deckId = null;
      selectedUseDeck.gameId = game.gameId;
      final deckId = await deckRepo.insert(selectedUseDeck);
      selectedUseDeck.deckId = deckId;
      allDeckList = await deckRepo.getAll();
      notifyListeners();
    }
  }

  Future addSelectedOpponentDeck(Game game) async {
    _changeItIfSelectedOpponentDeckInDb();
    if (selectedOpponentDeck.deckId == 0) {
      selectedOpponentDeck.deckId = null;
      selectedOpponentDeck.gameId = game.gameId;
      final deckId = await deckRepo.insert(selectedOpponentDeck);
      selectedOpponentDeck.deckId = deckId;
      allDeckList = await deckRepo.getAll();
      notifyListeners();
    }
  }

  Future add(Deck deck) async {
    await deckRepo.insert(deck);
    await _fetchAll();
  }

  Future update(Deck deck) async {
    await deckRepo.update(deck);
    await _fetchAll();
  }

  Future remove(Deck deck) async {
    await deckRepo.deleteById(deck.deckId);
    await _fetchAll();
  }
}
