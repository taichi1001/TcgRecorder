import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/entity/domain_data.dart';

part 'tag.freezed.dart';
part 'tag.g.dart';

@freezed
class Tag with _$Tag implements DomainData {
  factory Tag({
    @JsonKey(name: 'tag_id') int? id,
    @JsonKey(name: 'tag') required String name,
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
