import 'package:flutter/material.dart';

class CustomMessageItem extends StatelessWidget {
  final name;
  final message;
  final is_me;

  CustomMessageItem(this.name, this.message, this.is_me);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constarion) {
      return Row(
        mainAxisAlignment:
            !is_me ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
                color: is_me ? Colors.white : Theme.of(context).accentColor,
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
            ),
          ),
        ],
      );
    });
  }
}
