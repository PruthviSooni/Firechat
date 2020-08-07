import 'package:flutter/material.dart';

class MsgBubbles extends StatelessWidget {
  final String text;
  final String sender;
  final bool isMe;
  const MsgBubbles({Key key, this.isMe, this.text, this.sender})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(
            height: 5,
          ),
          Material(
            borderRadius: BorderRadius.circular(14),
            elevation: 5,
            color: isMe ? Colors.blue : Colors.grey,
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                text,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
