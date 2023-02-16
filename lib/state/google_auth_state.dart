import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'google_auth_state.freezed.dart';

@freezed
class GoogleAuthState with _$GoogleAuthState {
  factory GoogleAuthState({
    User? user,
  }) = _GoogleAuthState;
}
