import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat/services/database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseAuth get firebaseAuth => _firebaseAuth;

  User? _user;

  User? get user => _user;

  Map<String, dynamic> userDataMap = {'email': '', 'userName': ''};

  DatabaseMethods databaseMethods = DatabaseMethods();

  Future signWithEmailAndPassword(String email, String password) async {
    try {
      final emailSignInUser = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      _user = emailSignInUser.user;

      return _user;
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  Future signUpWithEmailAndPassword(
      String email, String password, String userName) async {
    try {
      final emailSignUpUser = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((UserCredential? result) {
        if (result != null) {
          userDataMap = {"email": email, "userName": userName};
          databaseMethods.addUserInfo(userDataMap);
        }
      });

      _user = emailSignUpUser.user;

      return _user;
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  Future signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth
            .signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        )
            .then((UserCredential? result) {
          if (result != null) {
            userDataMap = {
              "email": result.user!.email,
              "userName": result.user!.displayName
            };
            databaseMethods.addUserInfo(userDataMap);
          }
        });
        // _user = userCredential.user;
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
