import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/screens/welcome_screen.dart';
import 'package:firechat/widgets/message_bubbles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../configs/constants.dart';

final _auth = FirebaseAuth.instance;
final _firesotre = Firestore.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgTextEditingController = TextEditingController();
  String _message;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  void dispose() {
    msgTextEditingController.dispose();
    super.dispose();
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
              Navigator.pushNamedAndRemoveUntil(
                  context, WelcomeScreen.id, (route) => false);
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
                if (!snapshot.hasData) {
                  return Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return getMessages(snapshot);
                }
              },
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: msgTextEditingController,
                      onChanged: (value) {
                        _message = value;
                      },
                      decoration: textFieldDecoration(),
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

  Expanded getMessages(AsyncSnapshot<QuerySnapshot> snapshot) {
    final messages = snapshot.data.documents.reversed;
    List<MsgBubbles> messageBubbles = [];
    for (var message in messages) {
      String msg = message.data["messages"];
      String sender = message.data['sender'];
      int time = message.data['time'];
      DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(time);
      var timeStamp =
          timeago.format(DateTime.tryParse(timestamp.toString())).toString();
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
      child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: ListView(reverse: true, children: messageBubbles)),
    );
  }

  void sendMessage() {
    msgTextEditingController.clear();
    _firesotre.collection('messages').add(
      {
        'messages': _message,
        'sender': loggedInUser.email,
        'time': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  InputDecoration textFieldDecoration() {
    msgTextEditingController.addListener(() {
      setState(() {});
    });
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      hintText: 'Type your message here...',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      suffixIcon: msgTextEditingController.text.length > 0
          ? IconButton(
              icon: Icon(Icons.send),
              iconSize: 30,
              padding: EdgeInsets.only(right: 20),
              tooltip: "Send",
              onPressed: () => sendMessage(),
            )
          : null,
    );
  }

  sendButton() {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.blue,
          )),
      child: Text(
        'Send',
        style: kSendButtonTextStyle.copyWith(color: Colors.white),
      ),
    );
  }
}
