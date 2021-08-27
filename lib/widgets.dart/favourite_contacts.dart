import 'package:flutter/material.dart';
import 'package:flutter_chat/models.dart/message_model.dart';

class FavouriteContacts extends StatelessWidget {
  const FavouriteContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                    // onTap: () => Navigator.push(context,
                    //     MaterialPageRoute(builder: (_) => ChatScreen())),
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
