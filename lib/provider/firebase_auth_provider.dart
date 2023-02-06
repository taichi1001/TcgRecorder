import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcg_manager/state/firebase_auth_state.dart';

class FirebaseAuthNotifier extends StateNotifier<FirebaseAuthState> {
  FirebaseAuthNotifier(this.ref) : super(FirebaseAuthState());

  final Ref ref;

  Future signInAnonymously() async {
    try {
      final user = await FirebaseAuth.instance.signInAnonymously();
      state = state.copyWith(userCredential: user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  Future singOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

final firebaseAuthNotifierProvider = StateNotifierProvider<FirebaseAuthNotifier, FirebaseAuthState>(
  (ref) => FirebaseAuthNotifier(ref),
);
