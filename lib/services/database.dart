import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addUserInfo(userData) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userData['userName'])
        .set(userData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserName(String userName) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("userName", isEqualTo: userName)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserNameByEmail(String email) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  createChatRoom(chatRoom, chatRoomId) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  addConversationMessages(String chatRoomId, userMap) {
    FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .add(userMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessages(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('time', descending: true)
        .snapshots();
  }

  getAllChat(String userName) async {
    return await FirebaseFirestore.instance
        .collection('chatRoom')
        .where('users', arrayContains: userName)
        .snapshots();
  }
}
