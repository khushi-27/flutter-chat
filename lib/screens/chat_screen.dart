// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/services/database.dart';

class ChatScreen extends StatefulWidget {
  final String? chatRoomId;
  final String? myUserName;
  final String? userName;

  const ChatScreen({Key? key, this.chatRoomId, this.myUserName, this.userName})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();

  TextEditingController messageTextController = TextEditingController();

  Stream<QuerySnapshot>? chatMessagesSnapshot;

  uploadMessages() async {
    if (messageTextController.text.isNotEmpty) {
      Map<String, dynamic> userMap = {
        'message': messageTextController.text,
        'sendBy': widget.myUserName,
        'time': DateTime.now()
      };
      await databaseMethods.addConversationMessages(
          widget.chatRoomId!, userMap);
    }
  }

  Future getSnapshots() async {
    var doc = await databaseMethods.getConversationMessages(widget.chatRoomId!);
    setState(() {
      chatMessagesSnapshot = doc;
    });
  }

  @override
  void initState() {
    getSnapshots();
    super.initState();
  }

  Widget _buildMessage(String message, bool isMe, DateTime time) {
    final Container msg = Container(
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
          color: isMe ? Color(0xFFFEF9DB) : Color(0xFFFFEFEE),
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0))
              : BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0))),
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      margin: isMe
          ? const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
          : const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${time.hour.toString()} : ${time.minute.toString()}',
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 8.0),
          Text(message,
              style: TextStyle(
                  color: Colors.blueGrey[700],
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );

    return msg;
  }

  _buildCompose() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.emoji_emotions,
            ),
            iconSize: 25.0,
            color: Colors.blueGrey,
          ),
          Expanded(
              child: TextField(
            controller: messageTextController,
            textCapitalization: TextCapitalization.sentences,
            decoration:
                InputDecoration.collapsed(hintText: "Type Something Here ..."),
          )),
          IconButton(
            onPressed: () {
              uploadMessages();

              messageTextController.clear();
            },
            icon: Icon(
              Icons.send,
            ),
            iconSize: 25.0,
            color: Colors.blueGrey,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFEF9DB),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            widget.userName!,
            style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
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
                    child: StreamBuilder<QuerySnapshot>(
                        stream: chatMessagesSnapshot,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return ListView.builder(
                              reverse: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var data = snapshot.data!.docs[index];
                                // print(data.get('message'));
                                return _buildMessage(
                                    data.get('message'),
                                    data.get('sendBy') == widget.myUserName,
                                    (data.get('time') as Timestamp).toDate());
                              });
                        }),
                  ),
                ),
              ),
              _buildCompose(),
            ],
          ),
        ));
  }
}
