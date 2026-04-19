import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // 🔵 GOOGLE SIGN-IN
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // 🔥 sabihin sa UI: kailangan email login muna
        throw FirebaseAuthException(code: 'need-email-login', message: e.email);
      }
      rethrow;
    }
  }

  // 🟢 EMAIL LOGIN
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // 🔗 LINK GOOGLE (ETO ANG CORE NG GOAL MO 🔥)
  Future<void> linkGoogleAccount() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await user.linkWithCredential(credential);
  }

  // 🔴 SIGN OUT
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
