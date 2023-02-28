import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag.freezed.dart';
part 'tag.g.dart';

@freezed
class Tag with _$Tag {
  factory Tag({
    int? tagId,
    required String tag,
    int? gameId,
    @Default(true) @JsonKey(fromJson: _boolFromJson, toJson: _boolToJson) bool isVisibleToPicker,
    int? sortIndex,
  }) = _Tag;
  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}

bool _boolFromJson(value) {
  return value == 0 ? false : true;
}

int _boolToJson(bool value) {
  return value ? 1 : 0;
}
