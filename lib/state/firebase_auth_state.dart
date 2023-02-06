import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'firebase_auth_state.freezed.dart';

@freezed
abstract class FirebaseAuthState with _$FirebaseAuthState {
  factory FirebaseAuthState({
    UserCredential? userCredential,
  }) = _FirebaseAuthState;
}
