import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/entity/record.dart';

part 'firestore_share_data.freezed.dart';
part 'firestore_share_data.g.dart';

@freezed
class FirestoreShareData with _$FirestoreShareData {
  @JsonSerializable(explicitToJson: true)
  factory FirestoreShareData({
    required Game game,
    @Default([]) List<Deck> deckList,
    @Default([]) List<Tag> tagList,
    @Default([]) List<Record> recordList,
  }) = _FirestoreShareData;

  factory FirestoreShareData.fromJson(Map<String, dynamic> json) => _$FirestoreShareDataFromJson(json);
}
