import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/constants/input_decoration.dart';
import 'package:flutter_chat/widgets.dart/rounded_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
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
                  height: 200.0,
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
                height: 120.0,
              ),
              RoundedButton(
                  text: 'Log In',
                  onPressed: () async {
                    setState(() {
                      isShowSpinner = true;
                    });

                    try {
                      final UserCredential? existUser =
                          await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                      if (existUser != null)
                        Navigator.pushNamed(context, '/home');
                      setState(() {
                        isShowSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                      Navigator.pushNamed(context, '/registration');
                    }
                  },
                  paddingVertical: 0.0)
            ],
          ),
        ),
      ),
    );
  }
}
