import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/authentication.dart';

class MyDrawer extends StatelessWidget {
  final String myUserName;
  final String email;

  const MyDrawer({
    Key? key,
    required this.myUserName,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      child: Drawer(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(
            children: [
              DrawerHeader(
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  margin: EdgeInsets.zero,
                  accountName: Text(
                    myUserName,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  accountEmail: Text(
                    email,
                    style: TextStyle(fontSize: 15.0),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color(0xFFFEF9DB),
                    child: Text(
                      myUserName.substring(0, 1),
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              ListTile(
                onTap: () => {},
                leading: Icon(
                  CupertinoIcons.profile_circled,
                  color: Colors.white,
                ),
                title: Text(
                  "Profile",
                  textScaleFactor: 1.4,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                leading: Icon(
                  CupertinoIcons.settings,
                  color: Colors.white,
                ),
                title: Text(
                  "Settings",
                  textScaleFactor: 1.4,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.signOut();
                },
                leading: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: Text(
                  "Log out",
                  textScaleFactor: 1.4,
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
