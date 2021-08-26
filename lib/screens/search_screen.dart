import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/services/database.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  String searchText = '';

  QuerySnapshot? searchSnapshot;

  QuerySnapshot? getUserNameSnapshot;

  String myUserName = '';

  getMyUserName() {
    String? email = FirebaseAuth.instance.currentUser!.email;
    databaseMethods.getUserEmail(email!).then((val) {
      setState(() {
        getUserNameSnapshot = val;
      });
    });
    myUserName = getUserNameSnapshot!.docs[0].id;
  }

  initiateSearch() {
    databaseMethods.getUserName(searchText).then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  createChatRoom(String userName) {
    List<String?> users = [userName, myUserName];

    String chatRoomId = getChatRoomId(userName, myUserName);

    Map<String, dynamic> chatRoom = {'users': users, 'chatRoomId': chatRoomId};

    databaseMethods.createChatRoom(chatRoom, chatRoomId);
    print(users);
    print(chatRoomId);
    Navigator.popAndPushNamed(context, '/chat');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextBox(
            onchanged: (value) {
              searchText = value;
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                initiateSearch();
              },
            ),
          ],
        ),
        body: searchList());
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot!.docs.length,
            itemBuilder: (context, index) {
              return myUserName == searchSnapshot!.docs[index].get('userName')
                  ? searchTile(searchSnapshot!.docs[index].get('userName'),
                      searchSnapshot!.docs[index].get('email'))
                  : Container(child: Text('You cannot text yourself 😁'));
            })
        : Container();
  }

  Widget searchTile(String userName, String userEmail) {
    return Container(
      color: Color(0xFFFEF9DB),
      height: 90.0,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                userEmail,
                style: TextStyle(fontSize: 18.0),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 40.0,
              width: 110.0,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(26)),
              child: GestureDetector(
                onTap: () {
                  createChatRoom(userName);
                },
                child: Text(
                  'Message',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  final void Function(String)? onchanged;

  const TextBox({
    Key? key,
    required this.onchanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.red,
      child: TextField(
        style: TextStyle(color: Colors.white),
        onChanged: onchanged,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white, fontSize: 20.0)),
      ),
    );
  }
}

// class SearchTile extends StatelessWidget {
//   final String userName;
//   final String userEmail;

//   const SearchTile({Key? key, required this.userName, required this.userEmail})
//       : super(key: key);

//}
