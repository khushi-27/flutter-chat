import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/constants/input_decoration.dart';
import 'package:flutter_chat/services/authentication.dart';
import 'package:flutter_chat/widgets.dart/rounded_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  String userName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Padding(
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
                onChanged: (value) {
                  userName = value;
                },
                decoration:
                    inputFieldDecoration.copyWith(hintText: 'Enter User Name')),
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
              height: 120.0,
            ),
            RoundedButton(
                text: 'Log In',
                onPressed: () async {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);

                  var snapshot = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(userName)
                      .get();

                  email = snapshot.get('email');

                  provider
                      .signWithEmailAndPassword(email, password)
                      .then((value) => Navigator.pop(context));
                },
                paddingVertical: 0.0)
          ],
        ),
      ),
    );
  }
}
