import 'package:flutter/material.dart';

class CustomMessageItem extends StatelessWidget {
  final name;
  final message;
  final is_me;
  final img;

  CustomMessageItem(this.name, this.message, this.is_me, this.img);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constarion) {
      return Row(
        mainAxisAlignment:
            !is_me ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
                color: is_me ? Colors.white : Theme.of(context).primaryColor,
                borderRadius: is_me
                    ? BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12))
                    : BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12))),
            margin: EdgeInsets.all(8),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment:
                    is_me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (!is_me)
                        CircleAvatar(
                          maxRadius: 20,
                          backgroundColor: Colors.black12,
                          backgroundImage: NetworkImage(img),
                        ),
                      Column(
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                color: is_me ? Colors.black : Colors.white,
                                fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              message,
                              style: TextStyle(
                                  color: is_me ? Colors.black : Colors.white,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      if (is_me)
                        CircleAvatar(
                          maxRadius: 20,
                          backgroundColor: Colors.black12,
                          backgroundImage: NetworkImage(img),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
