import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tcg_manager/entity/domain_data.dart';

part 'public_game.freezed.dart';
part 'public_game.g.dart';

@freezed
class PublicGame with _$PublicGame implements DomainData {
  factory PublicGame({
    required int id,
    required String name,
    @Default(true) bool isVisibleToPicker,
    int? sortIndex,
  }) = _PublicGame;
  factory PublicGame.fromJson(Map<String, dynamic> json) => _$PublicGameFromJson(json);
}
