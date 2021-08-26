import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/models.dart/user_model.dart';

class ChatScreen extends StatefulWidget {
  final UserModel? user;

  const ChatScreen({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // final _auth = FirebaseAuth.instance;
  // final _firestore = FirebaseFirestore.instance;

  // late User loggedinUser;

  // String messageText = '';

  // final messageTextController = TextEditingController();

  // void getCurrentUser() async {
  //   final user = _auth.currentUser;
  //   try {
  //     if (user != null) {
  //       loggedinUser = user;
  //       print(loggedinUser.email);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getCurrentUser();
  // }

  // Widget _buildMessage(String message, bool isMe) {
  //   final Container msg = Container(
  //     width: MediaQuery.of(context).size.width * 0.75,
  //     decoration: BoxDecoration(
  //         color: isMe ? Theme.of(context).accentColor : Color(0xFFFFEFEE),
  //         borderRadius: isMe
  //             ? BorderRadius.only(
  //                 topLeft: Radius.circular(15.0),
  //                 bottomLeft: Radius.circular(15.0))
  //             : BorderRadius.only(
  //                 topRight: Radius.circular(15.0),
  //                 bottomRight: Radius.circular(15.0))),
  //     padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
  //     margin: isMe
  //         ? const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
  //         : const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text('hello',
  //             //_firestore.collection('messages').doc('time').get().toString(),
  //             style: TextStyle(
  //                 color: Colors.blueGrey,
  //                 fontSize: 14.0,
  //                 fontWeight: FontWeight.w600)),
  //         const SizedBox(height: 8.0),
  //         Text(message,
  //             style: TextStyle(
  //                 color: Colors.blueGrey[700],
  //                 fontSize: 16.0,
  //                 fontWeight: FontWeight.w600)),
  //       ],
  //     ),
  //   );

  //   return msg;
  // }

  // _buildCompose() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //     height: 70.0,
  //     color: Colors.white,
  //     child: Row(
  //       children: [
  //         IconButton(
  //           onPressed: () {},
  //           icon: Icon(
  //             Icons.emoji_emotions,
  //           ),
  //           iconSize: 25.0,
  //           color: Colors.blueGrey,
  //         ),
  //         Expanded(
  //             child: TextField(
  //           controller: messageTextController,
  //           textCapitalization: TextCapitalization.sentences,
  //           onChanged: (value) {
  //             messageText = value;
  //           },
  //           decoration:
  //               InputDecoration.collapsed(hintText: "Type Something Here ..."),
  //         )),
  //         IconButton(
  //           onPressed: () {
  //             // _firestore.collection('messages').add(({
  //             //       'text': messageText,
  //             //       'sender': loggedinUser.email,
  //             //       'time': DateTime.now()
  //             //     }));
  //             // messageTextController.clear();
  //           },
  //           icon: Icon(
  //             Icons.send,
  //           ),
  //           iconSize: 25.0,
  //           color: Colors.blueGrey,
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'hey',
            //widget.user!.name,
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          ),
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_horiz),
              iconSize: 30.0,
              color: Colors.white,
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                    // child: StreamBuilder<QuerySnapshot>(
                    //     stream: _firestore
                    //         .collection('messages')
                    //         .orderBy('time', descending: true)
                    //         .snapshots(),
                    //     builder: (context, snapshot) {
                    //       if (!snapshot.hasData) {
                    //         return Center(
                    //           child: CircularProgressIndicator(),
                    //         );
                    //       }

                    //       return ListView(
                    //           reverse: true,
                    //           children: snapshot.data!.docs.map((document) {
                    //             return _buildMessage(document['text'],
                    //                 document['sender'] == loggedinUser.email);
                    //           }).toList());
                    //     }),
                  ),
                ),
              ),
              // _buildCompose(),
            ],
          ),
        ));
  }
}
