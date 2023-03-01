import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/entity/record.dart';

part 'firestore_backup.freezed.dart';
part 'firestore_backup.g.dart';

@freezed
class FirestoreBackup with _$FirestoreBackup {
  @JsonSerializable(explicitToJson: true)
  factory FirestoreBackup({
    @Default([]) List<Game> gameList,
    @Default([]) List<Deck> deckList,
    @Default([]) List<Tag> tagList,
    @Default([]) List<Record> recordList,
  }) = _FirestoreBackup;
  factory FirestoreBackup.fromJson(Map<String, dynamic> json) => _$FirestoreBackupFromJson(json);
}
