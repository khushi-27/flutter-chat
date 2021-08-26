import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets.dart/category_selector.dart';
import 'package:flutter_chat/widgets.dart/drawer.dart';
import 'package:flutter_chat/widgets.dart/favourite_contacts.dart';
import 'package:flutter_chat/widgets.dart/recent_chats.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      drawer: MyDrawer(),
      appBar: AppBar(
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
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
              child: Column(
                children: <Widget>[FavouriteContacts(), RecentChats()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
