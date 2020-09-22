import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/entity/tag.dart';
import 'package:tcg_recorder/repository/tag_repository.dart';

class TagModel with ChangeNotifier {
  List<Tag> allTagList = [];
  List<Tag> gameTagList = [];
  Tag selectedTag;
  final TagRepo tagRepo;

  TagModel(this.tagRepo) {
    _fetchAll();
  }

  Future _fetchAll() async {
    allTagList = await tagRepo.getAll();
    selectedTag = null;
    notifyListeners();
  }

  Future getGameTagList(int id) async {
    gameTagList = await tagRepo.getGameTag(id);
    gameTagList.insert(0, Tag(tag: ''));
    notifyListeners();
  }

  void changeSelectedTagUsingIndex(int index) {
    selectedTag = gameTagList[index];
    notifyListeners();
  }

  void changeSelectedTagUsingString(String newValue) {
    if (newValue == '') {
      selectedTag = null;
    } else {
      selectedTag = Tag(tag: newValue);
    }
    notifyListeners();
  }

  void _changeItIfSelectedTagInDB() {
    if (gameTagList.where((value) => value.tag == selectedTag.tag).isNotEmpty) {
      selectedTag = gameTagList
          .where((value) => value.tag == selectedTag.tag)
          .toList()[0];
    }
  }

  Future addSelectedTag(Game game) async {
    _changeItIfSelectedTagInDB();
    if (selectedTag.tagId != 0) return;
    selectedTag.tagId = null;
    selectedTag.gameId = game.gameId;
    final selectedTagId = await tagRepo.insert(selectedTag);
    selectedTag.tagId = selectedTagId;
    allTagList = await tagRepo.getAll();
    notifyListeners();
  }

  void findTagUsingRecord(Record record) {
    record.tag = allTagList
        .where((value) => value.tagId == record.tagId)
        .toList()[0]
        .tag;
  }

  Future add(Tag tag) async {
    await tagRepo.insert(tag);
    await _fetchAll();
  }

  Future update(Tag tag) async {
    await tagRepo.update(tag);
    await _fetchAll();
  }

  Future remove(Tag tag) async {
    await tagRepo.deleteById(tag.tagId);
    await _fetchAll();
  }
}
