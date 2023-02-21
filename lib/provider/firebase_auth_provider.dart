import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcg_manager/helper/db_helper.dart';
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

  Future signInPhoneNumber(String verificationId, String smsCode) async {
    try {
      final credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      state = state.copyWith(user: userCredential.user);
    } catch (e) {
      rethrow;
    }
  }

  Future linkPhoneNumber(String verificationId, String smsCode) async {
    try {
      final credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
      final userCredential = await state.user?.linkWithCredential(credential);
      state = state.copyWith(user: userCredential!.user);
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  Future unlinkPhoneNumber() async {
    final newUser = await state.user?.unlink('phone');
    state = state.copyWith(user: newUser);
  }

  void login() {
    state = state.copyWith(user: FirebaseAuth.instance.currentUser);
  }

  Future singOut() async {
    await FirebaseAuth.instance.signOut();
    await ref.read(dbHelper).deleteAll();
    state = state.copyWith(user: null);
  }
}

final firebaseAuthNotifierProvider = StateNotifierProvider<FirebaseAuthNotifier, FirebaseAuthState>(
  (ref) => FirebaseAuthNotifier(ref),
);
