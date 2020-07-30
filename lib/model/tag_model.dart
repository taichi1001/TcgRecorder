import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/tag.dart';
import 'package:tcg_recorder/repository/tag_repository.dart';

class TagModel with ChangeNotifier {
  List<Tag> allTagList;
  List<Tag> recordScreenTagList = [Tag(tag: 'default')];
  bool isUpdate;

  final tagRepo = TagRepo();

  TagModel() {
    _fetchAll();
  }

  /// 新しいタグを登録する
  /// 
  /// 入力が空の場合、入力された名前のタグが既に登録されている場合は何もせずreturnする
  Future setNewTag(TextEditingController newTag) async {
    if (newTag.text.isEmpty) {
      isUpdate = false;
      return;
    }
    if (allTagList.map((tag) => tag.tag).toList().contains(newTag.text)) {
      isUpdate = false;
      return;
    }
    isUpdate = true;
    await add(Tag(tag: newTag.text));
  }

  /// タグのリストの中から入力idとtagIdが一致するTagを取得する
  Tag getTagNameInId(int id){
    return allTagList.where((tag) => tag.tagId == id).toList()[0];
  }

  /// タグのリストの中から入力タグ名とtag.tagが一致するTagを取得する
  Tag getIdInTagName(String tagName){
    return allTagList.where((tag) => tag.tag == tagName).toList()[0];
  }

  void notify(){
    notifyListeners();
  }

  Future _fetchAll() async {
    allTagList = await tagRepo.getAllTag();
    recordScreenTagList = [...allTagList];
    recordScreenTagList.insert(0, Tag(tagId: 0, tag: 'all'));
    notifyListeners();
  }

  Future add(Tag tag) async {
    tagRepo.insertTag(tag);
    _fetchAll();
  }

  Future update(Tag tag) async {
    await tagRepo.updateTag(tag);
    _fetchAll();
  }

  Future remove(Tag tag) async {
    await tagRepo.deleteTagById(tag.tagId);
    _fetchAll();
  }
}
