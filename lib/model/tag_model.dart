import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/entity/tag.dart';
import 'package:tcg_recorder/repository/tag_repository.dart';

class TagModel with ChangeNotifier {
  Game game;
  List<Tag> gameTagList;

  final tagRepo = TagRepo();

  TagModel(this.game) {
    _fetchAll();
  }

  Future _fetchAll() async {
    gameTagList = await tagRepo.getGameTag(game.gameId);
    notifyListeners();
  }

  Future add(Tag tag) async {
    tagRepo.insert(tag);
    _fetchAll();
  }

  Future update(Tag tag) async {
    await tagRepo.update(tag);
    _fetchAll();
  }

  Future remove(Tag tag) async {
    await tagRepo.deleteById(tag.tagId);
    _fetchAll();
  }
}
