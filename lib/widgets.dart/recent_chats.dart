import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_chat/models.dart/message_model.dart';
import 'package:flutter_chat/screens/chat_screen.dart';
import 'package:flutter_chat/services/database.dart';

class RecentChats extends StatefulWidget {
  final String myUserName;
  const RecentChats({
    Key? key,
    required this.myUserName,
  }) : super(key: key);

  @override
  State<RecentChats> createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  DatabaseMethods databaseMethods = DatabaseMethods();

  Stream<QuerySnapshot>? chatRoomSnapshot;

  Future getChatRoomSnapshots() async {
    var doc = await databaseMethods.getAllChat(widget.myUserName);
    setState(() {
      chatRoomSnapshot = doc;
    });
  }

  @override
  void initState() {
    super.initState();
    getChatRoomSnapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0))),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          child: StreamBuilder<QuerySnapshot>(
              stream: chatRoomSnapshot,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Message chat = chats[index];

                      var data = snapshot.data!.docs[index];

                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                    myUserName: widget.myUserName,
                                    chatRoomId: data.get('chatRoomId'),
                                    userName: (data
                                        .get('chatRoomId')
                                        .toString()
                                        .replaceAll('_', "")
                                        .replaceAll(
                                            '${widget.myUserName}', ''))))),
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 5.0, bottom: 5.0, right: 20.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          decoration: BoxDecoration(
                              color: chat.unread
                                  ? Color(0xFFFFEFEE)
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: Text(
                                      (data.get('chatRoomId'))
                                          .toString()
                                          .replaceAll('_', "")
                                          .replaceAll(
                                              '${widget.myUserName}', '')
                                          .substring(0, 1),
                                      style: TextStyle(
                                          color: Color(0xFFFEF9DB),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    radius: 30.0,
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            (data.get('chatRoomId'))
                                                .toString()
                                                .replaceAll('_', "")
                                                .replaceAll(
                                                    '${widget.myUserName}', ''),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          child: Text(
                                            chat.text,
                                            style: TextStyle(
                                                color: Colors.blueGrey[700],
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ])
                                ],
                              ),
                              Column(
                                children: [
                                  Text(chat.time),
                                  const SizedBox(height: 5.0),
                                  chat.unread
                                      ? Container(
                                          height: 20.0,
                                          width: 40.0,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(30.0)),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "New",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold),
                                          ))
                                      : Text('')
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
              }),
        ),
      ),
    );
  }
}
