import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/repository/tag_repository.dart';
import 'package:tcg_manager/state/tag_list_state.dart';

class TagListNotifier extends StateNotifier<TagListState> {
  TagListNotifier(this.read) : super(TagListState());

  final Reader read;

  Future fetch() async {
    final tagList = await read(tagRepository).getAll();
    state = state.copyWith(allTagList: tagList);
  }

  Future updateName(String name, int index) async {
    final tag = state.allTagList![index];
    final newTag = tag.copyWith(tag: name);
    await read(tagRepository).update(newTag);
    await fetch();
  }
}

final allTagListNotifierProvider = StateNotifierProvider<TagListNotifier, TagListState>(
  (ref) => TagListNotifier(ref.read),
);
