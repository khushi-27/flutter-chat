import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets.dart/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('assets/images/logo.png'),
                    height: 70.0,
                  ),
                ),
                Text(
                  'Chat App',
                  style: TextStyle(
                      fontSize: 56.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.red.withOpacity(controller.value)),
                ),
              ],
            ),
            SizedBox(
              height: 120.0,
            ),
            RoundedButton(
                text: 'Log In',
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                paddingVertical: 16.0),
            RoundedButton(
                text: 'Register',
                onPressed: () {
                  Navigator.pushNamed(context, '/registration');
                },
                paddingVertical: 16.0),
          ],
        ),
      ),
    );
  }
}
