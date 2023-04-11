import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/main.dart';

class InitialDataController {
  InitialDataController(this.ref);

  Ref ref;
  late final prefs = ref.read(sharedPreferencesProvider);
  static const initialGameNameKey = 'initialGameName';
  static const initialGameIdKey = 'initialGameId';
  static const initialGameIsShareKey = 'initialGameIsShare';
  static const initialUseDeckNameKey = 'initialUseDeckName';
  static const initialOpponentDeckNameKey = 'initialOpponentDeckName';
  static const initialTagsNameKey = 'initialTagsName';

  void saveGame(Game game) {
    prefs.setString(initialGameNameKey, game.name);
    prefs.setInt(initialGameIdKey, game.id!);
    prefs.setBool(initialGameIsShareKey, game.isShare);
  }

  void saveUseDeck(Deck deck) {
    prefs.setString(initialUseDeckNameKey, deck.name);
  }

  void saveOpponentDeck(Deck deck) {
    prefs.setString(initialOpponentDeckNameKey, deck.name);
  }

  void saveTags(List<Tag> tags) {
    final tagNames = tags.map((e) => e.name).toList();
    prefs.setStringList(initialTagsNameKey, tagNames);
  }

  Game? loadGame() {
    final gameName = prefs.getString(initialGameNameKey);
    final gameId = prefs.getInt(initialGameIdKey);
    final isShare = prefs.getBool(initialGameIsShareKey);
    if (gameName == null) return null;
    return Game(id: gameId, name: gameName, isShare: isShare ?? false);
  }

  Deck? loadUseDeck() {
    final deckName = prefs.getString(initialUseDeckNameKey);
    if (deckName == null) return null;
    return Deck(name: deckName);
  }

  Deck? loadOpponentDeck() {
    final deckName = prefs.getString(initialOpponentDeckNameKey);
    if (deckName == null) return null;
    return Deck(name: deckName);
  }

  List<Tag> loadTags() {
    final tagNames = prefs.getStringList(initialTagsNameKey);
    if (tagNames == null) return [];
    return tagNames.map((e) => Tag(name: e)).toList();
  }
}

final initialDataControllerProvider = Provider.autoDispose((ref) => InitialDataController(ref));
