import 'package:freezed_annotation/freezed_annotation.dart';

part 'public_game.freezed.dart';
part 'public_game.g.dart';

@freezed
class PublicGame with _$PublicGame {
  factory PublicGame({
    required int id,
    required String name,
  }) = _PublicGame;
  factory PublicGame.fromJson(Map<String, dynamic> json) => _$PublicGameFromJson(json);
}
