import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/state/google_auth_state.dart';

class GoogleAuthModel extends StateNotifier<GoogleAuthState> {
  GoogleAuthModel(this.read) : super(GoogleAuthState());

  final Reader read;

  Future loginWithGoogle() async {
    GoogleSignInAccount? signinAccount;

    try {
      signinAccount = await GoogleSignIn(scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ]).signIn();
      if (signinAccount == null) return null;
      final auth = await signinAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: auth.idToken,
        accessToken: auth.accessToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      state = state.copyWith(user: userCredential.user);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> loginWithEmail(String email, String password) async {
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user!;
      if (user.emailVerified) {
        state = state.copyWith(user: user);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future signUpWithEmail(String email, String password) async {
    try {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user!;
      user.sendEmailVerification();
    } catch (e) {
      rethrow;
    }
  }

  Future reSendEmailVerification(String email, String password) async {
    final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    result.user!.sendEmailVerification();
  }

  Future sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  Future logout() async {
    FirebaseAuth.instance.signOut();
    await GoogleSignIn(scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ]).signOut();
    state = state.copyWith(user: null);
  }

  void isLogin() {
    final isLogin = FirebaseAuth.instance.currentUser == null ? false : true;
    if (isLogin) state = state.copyWith(user: FirebaseAuth.instance.currentUser);
  }
}

final googleAuthNotifierProvider = StateNotifierProvider<GoogleAuthModel, GoogleAuthState>(
  (ref) => GoogleAuthModel(ref.read),
);
