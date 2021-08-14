import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/constants/input_decoration.dart';
import 'package:flutter_chat/google_signin.dart';
import 'package:flutter_chat/widgets.dart/rounded_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = '';
  String password = '';
  String confirmPassword = '';

  final _auth = FirebaseAuth.instance;

  bool isShowSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: ModalProgressHUD(
        inAsyncCall: isShowSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: ListView(
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 180.0,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              SizedBox(
                height: 70.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration:
                      inputFieldDecoration.copyWith(hintText: 'Enter email')),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: inputFieldDecoration.copyWith(
                      hintText: 'Enter password')),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                  obscureText: true,
                  onChanged: (value) {
                    confirmPassword = value;
                  },
                  decoration: inputFieldDecoration.copyWith(
                      hintText: 'Confirm password')),
              SizedBox(
                height: 45.0,
              ),
              RoundedButton(
                  text: 'Register',
                  onPressed: () async {
                    setState(() {
                      isShowSpinner = true;
                    });
                    try {
                      final UserCredential? newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, '/home');
                      }

                      setState(() {
                        isShowSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  paddingVertical: 16.0),
              RoundedButton(
                text: 'Sign in with Google',
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.signInWithGoogle();
                },
                paddingVertical: 0.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
