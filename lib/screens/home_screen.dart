import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/services/database.dart';
import 'package:flutter_chat/widgets.dart/category_selector.dart';
import 'package:flutter_chat/widgets.dart/drawer.dart';
import 'package:flutter_chat/widgets.dart/favourite_contacts.dart';
import 'package:flutter_chat/widgets.dart/recent_chats.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();

  String? myUserName;
  String? email;
  QuerySnapshot? getUserNameSnapshot;

  bool isLoading = true;

  Future getMyUserName() async {
    setState(() {
      isLoading = true;
    });
    email = FirebaseAuth.instance.currentUser!.email;
    var doc = await databaseMethods.getUserNameByEmail(email!);

    setState(() {
      getUserNameSnapshot = doc;

      //List
      // userNames = ;
      //print(userNames);
      myUserName = getUserNameSnapshot!.docs[0].id;
      print(myUserName);

      isLoading = false;
    });
  }

  @override
  void initState() {
    getMyUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            drawer: MyDrawer(email: email!, myUserName: myUserName!),
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(
                "Chats",
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
              ),
              elevation: 0.0,
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/search');
                  },
                  icon: Icon(Icons.search),
                  iconSize: 30.0,
                  color: Colors.white,
                ),
              ],
            ),
            body: Column(
              children: <Widget>[
                CategorySelector(),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFFEF9DB),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                    child: Column(
                      children: <Widget>[
                        FavouriteContacts(),
                        RecentChats(myUserName: myUserName!)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
