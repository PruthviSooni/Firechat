import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class MsgBubbles extends StatelessWidget {
  final Color _color =
      RandomColor().randomColor(colorBrightness: ColorBrightness.dark);
  final String text;
  final String sender;
  final bool isMe;
  final String timestamp;

  MsgBubbles({Key key, this.timestamp, this.isMe, this.text, this.sender})
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
            color: isMe ? Colors.lightBlueAccent : _color,
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 18,
                    color: isMe ? Colors.grey.shade900 : Colors.white),
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
