import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/home_screen.dart';
import 'package:flutter_chat/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'authentication.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);

    return Scaffold(
      body: StreamBuilder(
          stream: provider.firebaseAuth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return HomeScreen();
            } else if (snapshot.hasError) {
              return Center(child: Text('Something Went wrong'));
            } else {
              return WelcomeScreen();
            }
          }),
    );
  }
}
