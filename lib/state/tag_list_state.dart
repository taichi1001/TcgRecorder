import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_recorder2/entity/tag.dart';

part 'tag_list_state.freezed.dart';

@freezed
abstract class TagListState with _$TagListState {
  factory TagListState({
    List<Tag>? allTagList,
  }) = _TagListState;
}
