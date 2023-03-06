import 'package:freezed_annotation/freezed_annotation.dart';

part 'firestore_config.freezed.dart';
part 'firestore_config.g.dart';

@freezed
class FirestoreConfig with _$FirestoreConfig {
  factory FirestoreConfig({
    required String android,
    required String ios,
  }) = _FirestoreConfig;
  factory FirestoreConfig.fromJson(Map<String, dynamic> json) => _$FirestoreConfigFromJson(json);
}
