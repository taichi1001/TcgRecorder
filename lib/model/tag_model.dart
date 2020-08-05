import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/tag.dart';
import 'package:tcg_recorder/repository/tag_repository.dart';

class TagModel with ChangeNotifier {
  List<Tag> allTagList;
  List<Tag> gameTagList;
  Tag selectedTag;

  final tagRepo = TagRepo();

  TagModel() {
    _fetchAll();
  }

  Future _fetchAll() async {
    allTagList = await tagRepo.getAll();
    if(allTagList.isNotEmpty) {
      selectedTag = allTagList[0];
    } else {
      selectedTag = Tag(tagId: 0, tag:'default', gameId: 0);
    }
    notifyListeners();
  }

  Future getGameTagList(int id) async {
    gameTagList = await tagRepo.getGameTag(id);
    notifyListeners();
  }

  void selectedTagChangeToIndex(int index) {
    selectedTag = gameTagList[index];
    notifyListeners();
  }

  void selectedTagChangeToString(String newValue) {
    if (gameTagList.where((value) => value.tag == newValue).isEmpty) {
      selectedTag = Tag(tag: newValue);
    } else {
      selectedTag = gameTagList.where((value) => value.tag == newValue).toList()[0];
    }
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
