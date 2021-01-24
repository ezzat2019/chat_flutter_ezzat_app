import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatelessWidget {
  final messgae_controler = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Card(
        elevation: 3,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: messgae_controler,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "message",
                      hintStyle: TextStyle(color: Colors.black26)),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            IconButton(
                icon: Icon(
                  Icons.send,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  String message = messgae_controler.text.trim();
                  if (!message.isEmpty) {
                    FocusScope.of(context).unfocus();
                    firestore
                        .collection("/users")
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .get()
                        .then((value) {
                      if (value != null) {
                        String name = value["name"];
                        firestore.collection("/messages").add({
                          "message": message,
                          "date": Timestamp.now(),
                          "name": name,
                          "uid": value.id,
                          "img": value["img"]
                        });
                        messgae_controler.clear();
                      }
                    });
                  }
                })
          ],
        ),
      ),
    );
  }
}
