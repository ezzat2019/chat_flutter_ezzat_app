import 'package:chat_flutter_ezzat_app/widget/chat/custom_message_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection("/messages")
            .orderBy("date", descending: true)
            .snapshots(),
        builder: (_, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView.builder(
                reverse: true,
                itemCount: snap.data.docs.length,
                itemBuilder: (_, index) {
                  if (FirebaseAuth.instance.currentUser.uid ==
                      snap.data.docs[index]["uid"]) {
                    return CustomMessageItem(
                        snap.data.docs[index]["name"],
                        snap.data.docs[index]["message"],
                        true,
                        snap.data.docs[index]["img"]);
                  } else {
                    return CustomMessageItem(
                        snap.data.docs[index]["name"],
                        snap.data.docs[index]["message"],
                        false,
                        snap.data.docs[index]["img"]);
                  }
                });
        });
  }
}
