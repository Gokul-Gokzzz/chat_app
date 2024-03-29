import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<UserCredential> signInWithGithub(context) async {
    try {
      GithubAuthProvider githubAuthProvider = GithubAuthProvider();
      return await firebaseAuth.signInWithProvider(githubAuthProvider);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      return await firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }
  }
}
