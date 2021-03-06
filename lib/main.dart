import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/search_screen.dart';
import 'package:flutter_chat/services/authentication.dart';
import 'package:flutter_chat/services/snapshot.dart';
import 'package:flutter_chat/screens/chat_screen.dart';
import 'package:flutter_chat/screens/home_screen.dart';
import 'package:flutter_chat/screens/login_screen.dart';
import 'package:flutter_chat/screens/registration_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        title: 'Flutter Chat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.red,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFFEF9DB)),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
          '/chat': (context) => ChatScreen(),
          '/registration': (context) => RegistrationScreen(),
          '/search': (context) => SearchScreen()
        },
      ),
    );
  }
}
