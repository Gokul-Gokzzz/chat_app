// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class LoginService {
//   Future<void> signInWithEmailAndPassword(String email, String password) async {
//     await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: email, password: password);
//   }

//   Future<UserCredential> signInWithGithub() async {
//     GithubAuthProvider githubAuthProvider = GithubAuthProvider();
//     return await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
//   }

//   Future<void> signInWithGoogle() async {
//     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

//     final GoogleSignInAuthentication gAuth = await gUser!.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: gAuth.accessToken,
//       idToken: gAuth.idToken,
//     );
//     await FirebaseAuth.instance.signInWithCredential(credential);
//   }
// }
