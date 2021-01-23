import 'package:chat_flutter_ezzat_app/main.dart';
import 'package:chat_flutter_ezzat_app/widget/chat/message.dart';
import 'package:chat_flutter_ezzat_app/widget/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        title: Text("Chat"),
        actions: [
          DropdownButton(
            onChanged: (val) {
              if (val == "logout") {
                FirebaseAuth.instance
                    .signOut()
                    .catchError((err) => Toast.show(err.toString(), context))
                    .then((value) {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (_) {
                    return MyApp();
                  }));
                });
              }
            },
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                child: Text("logout"),
                value: "logout",
              )
            ],
          )
        ],
      ),
      body: Column(
        children: [Expanded(child: Message()), NewMessage()],
      ),
    );
  }
}
