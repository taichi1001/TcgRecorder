import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/tag.dart';

part 'firestore_public_user_data.freezed.dart';
part 'firestore_public_user_data.g.dart';

@freezed
class FirestorePublicUserData with _$FirestorePublicUserData {
  @JsonSerializable(explicitToJson: true)
  factory FirestorePublicUserData({
    required String uid,
    @Default([]) List<Game> gameList,
    @Default([]) List<Deck> deckList,
    @Default([]) List<Tag> tagList,
    @Default([]) List<Record> recordList,
  }) = _FirestorePublicUserData;
  factory FirestorePublicUserData.fromJson(Map<String, dynamic> json) => _$FirestorePublicUserDataFromJson(json);
}
