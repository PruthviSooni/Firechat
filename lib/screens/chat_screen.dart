import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firechat/widgets/message_bubbles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../configs/constants.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgTextEditingController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firesotre = Firestore.instance;
  String _message;
  FirebaseUser loggedInUser;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            }),
        title: Text('🔥 Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firesotre
                  .collection("messages")
                  .orderBy("time", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data.documents.reversed;
                  List<MsgBubbles> messageBubbles = [];
                  for (var message in messages) {
                    String msg = message.data["messages"];
                    String sender = message.data['sender'];
                    int time = message.data['time'];
                    DateTime timestamp =
                        DateTime.fromMillisecondsSinceEpoch(time);
                    var timeStamp = timeago
                        .format(DateTime.tryParse(timestamp.toString()))
                        .toString();
                    final currentUser = loggedInUser.email;
                    Widget msgBubble = MsgBubbles(
                      text: msg,
                      sender: sender,
                      timestamp: timeStamp,
                      isMe: currentUser == sender,
                    );
                    messageBubbles.add(msgBubble);
                  }
                  return Expanded(
                    child: ListView(reverse: true, children: messageBubbles),
                  );
                }
                return Container();
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: msgTextEditingController,
                      onChanged: (value) {
                        _message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      msgTextEditingController.clear();
                      _firesotre.collection('messages').add(
                        {
                          'messages': _message,
                          'sender': loggedInUser.email,
                          'time': DateTime.now().millisecondsSinceEpoch,
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue),
                      child: Text(
                        'Send',
                        style:
                            kSendButtonTextStyle.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
