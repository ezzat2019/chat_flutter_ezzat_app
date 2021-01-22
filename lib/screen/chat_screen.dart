import 'package:chat_flutter_ezzat_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';


class ChatScreen extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        FlatButton(onPressed: (){FirebaseAuth.instance.signOut().then((value){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_){
            return MyApp();
          }));

        }).catchError((err){
          Toast.show(err.toString(),context,duration: Toast.LENGTH_LONG);
        });}, child: Text("Sign out"))
      ],),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection("/messages").snapshots(),
          builder: (_, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else
              return ListView.builder(
                  itemCount: snap.data.docs.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(snap.data.docs[index]["message"]),
                    );
                  });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          firestore.collection("/messages").add({"message": "ezzat"});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
