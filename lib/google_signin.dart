import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // GoogleSignInAccount? _user;

  // GoogleSignInAccount? get user => _user;

  Future signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );

        //return userCredential.user;

      }
    }
    // notifyListeners();
  }

  // Future<void> signOut() async {
  //   final googleSignIn = GoogleSignIn();
  //   await googleSignIn.signOut();
  //   await _firebaseAuth.signOut();
  // }
}
