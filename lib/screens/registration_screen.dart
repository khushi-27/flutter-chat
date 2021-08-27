import 'package:flutter/material.dart';
import 'package:flutter_chat/constants/input_decoration.dart';
import 'package:flutter_chat/services/authentication.dart';
import 'package:flutter_chat/widgets.dart/rounded_button.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = '';
  String password = '';
  String username = '';

  //final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEF9DB),
      body: Padding(
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
                onChanged: (value) {
                  username = value;
                },
                decoration:
                    inputFieldDecoration.copyWith(hintText: 'Enter username')),
            SizedBox(
              height: 20.0,
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
                decoration:
                    inputFieldDecoration.copyWith(hintText: 'Enter password')),
            SizedBox(
              height: 45.0,
            ),
            RoundedButton(
                text: 'Register',
                onPressed: () async {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);

                  provider
                      .signUpWithEmailAndPassword(email, password, username)
                      .then((value) => Navigator.pop(context));

                  // Navigator.pushNamed(context, '/home');
                },
                paddingVertical: 16.0),
            RoundedButton(
              text: 'Sign in with Google',
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider
                    .signInWithGoogle()
                    .then((value) => Navigator.pop(context));
              },
              paddingVertical: 0.0,
            )
          ],
        ),
      ),
    );
  }
}
