import 'package:flutter/material.dart';
import 'package:flutter_chat/constants/input_decoration.dart';
import 'package:flutter_chat/widgets.dart/rounded_button.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  //Do something with the user input.
                },
                decoration:
                    inputFieldDecoration.copyWith(hintText: 'Enter email')),
            SizedBox(
              height: 20.0,
            ),
            TextField(
                obscureText: true,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration:
                    inputFieldDecoration.copyWith(hintText: 'Enter password')),
            SizedBox(
              height: 20.0,
            ),
            TextField(
                obscureText: true,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: inputFieldDecoration.copyWith(
                    hintText: 'Confirm password')),
            SizedBox(
              height: 45.0,
            ),
            RoundedButton(
                text: 'Register',
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                paddingVertical: 16.0),
            RoundedButton(
              text: 'Sign in with Google',
              onPressed: () {},
              paddingVertical: 0.0,
            )
          ],
        ),
      ),
    );
  }
}
