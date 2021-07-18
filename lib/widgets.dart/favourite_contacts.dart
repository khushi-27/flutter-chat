import 'package:flutter/material.dart';
import 'package:flutter_chat/models.dart/message_model.dart';
import 'package:flutter_chat/screens/chat_screen.dart';

class FavouriteContacts extends StatelessWidget {
  const FavouriteContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Favourite Contacts",
                style: TextStyle(
                  color: Colors.blueGrey[700],
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                  onPressed: () {
                    print("search");
                  },
                  icon: Icon(Icons.more_horiz),
                  iconSize: 30.0,
                  color: Colors.blueGrey[700])
            ],
          ),
        ),
        Container(
            height: 110,
            child: ListView.builder(
                padding: EdgeInsets.only(left: 10.0),
                scrollDirection: Axis.horizontal,
                itemCount: favorites.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                ChatScreen(user: favorites[index]))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage:
                              AssetImage(favorites[index].imageUrl),
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          favorites[index].name,
                          style: TextStyle(
                              color: Colors.blueGrey[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0),
                        )
                      ]),
                    ),
                  );
                }))
      ]),
    );
  }
}
