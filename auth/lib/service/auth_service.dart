// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   Future<void> signInWithEmailAndPassword(String email, String password) async {
//     await _firebaseAuth.signInWithEmailAndPassword(
//         email: email, password: password);
//   }

//   Future<void> signInWithGoogle() async {
//     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
//     final GoogleSignInAuthentication gAuth = await gUser!.authentication;
//     final credential = GoogleAuthProvider.credential(
//       accessToken: gAuth.accessToken,
//       idToken: gAuth.idToken,
//     );
//     await _firebaseAuth.signInWithCredential(credential);
//   }

//   Future<void> signInWithGithub() async {
//     GithubAuthProvider githubAuthProvider = GithubAuthProvider();
//     await _firebaseAuth.signInWithProvider(githubAuthProvider);
//   }
// }
