import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseAuth get firebaseAuth => _firebaseAuth;

  User? _user;

  User? get user => _user;

  Future signWithEmailAndPassword(String email, String password) async {
    try {
      final emailSignInUser = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      _user = emailSignInUser.user;

      return _user;
    } catch (e) {
      print(e);
      _user = null;
      return _user;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      final emailSignUpUser = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      _user = emailSignUpUser.user;
      return _user;
    } catch (e) {
      print(e);
    }
  }

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
        // print(userCredential.user!.displayName);
        _user = userCredential.user;
      }
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
    _user = null;
    notifyListeners();
  }
}
