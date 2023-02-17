import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcg_manager/state/firebase_auth_state.dart';

class FirebaseAuthNotifier extends StateNotifier<FirebaseAuthState> {
  FirebaseAuthNotifier(this.ref) : super(FirebaseAuthState());

  final Ref ref;

  Future signInAnonymously() async {
    if (state.user != null) return;
    try {
      final user = await FirebaseAuth.instance.signInAnonymously();
      state = state.copyWith(user: user.user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          break;
        default:
          break;
      }
    }
  }

  void login() {
    state = state.copyWith(user: FirebaseAuth.instance.currentUser);
  }

  Future singOut() async {
    await FirebaseAuth.instance.signOut();
    state = state.copyWith(user: null);
  }
}

final firebaseAuthNotifierProvider = StateNotifierProvider<FirebaseAuthNotifier, FirebaseAuthState>(
  (ref) => FirebaseAuthNotifier(ref),
);
