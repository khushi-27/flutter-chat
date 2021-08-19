import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/authentication.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image =
        "https://i.pinimg.com/originals/26/86/b5/2686b53f79adc176a15320dbc57c58a3.jpg";
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
                  accountName: Text("Khushi Kalathiya"),
                  accountEmail: Text("khushikalathiya1234@gmail.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(image),
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
