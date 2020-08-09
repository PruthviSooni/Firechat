import 'package:flutter/material.dart';

class MsgBubbles extends StatelessWidget {
  final String text;
  final String sender;
  final bool isMe;
  final String timestamp;
  const MsgBubbles({Key key, this.timestamp, this.isMe, this.text, this.sender})
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
            borderRadius: BorderRadius.only(
                topLeft:
                    isMe == false ? Radius.circular(0) : Radius.circular(14),
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
                topRight: isMe ? Radius.circular(0) : Radius.circular(8)),
            elevation: 5,
            color: isMe ? Colors.lightBlueAccent : Colors.blue.shade100,
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                text,
                style: TextStyle(fontSize: 18, color: Colors.grey.shade800),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            timestamp,
            style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
