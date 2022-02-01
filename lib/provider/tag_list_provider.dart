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
}

final allTagListNotifierProvider = StateNotifierProvider<TagListNotifier, TagListState>(
  (ref) => TagListNotifier(ref.read),
);
