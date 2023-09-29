import 'package:flutter/material.dart';

class MessageHolder extends StatelessWidget {
  final String sender;
  final String message;
  final bool isme;

  const MessageHolder(
      {super.key,
      required this.sender,
      required this.message,
      required this.isme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        crossAxisAlignment:
            isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
          Material(
            color: isme ? Colors.blueAccent : Color(0xff999999),
            elevation: 10,
            borderRadius: isme
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20)),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
