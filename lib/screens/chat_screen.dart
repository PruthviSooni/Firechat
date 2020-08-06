import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'settings_screen.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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

  void handleClick(String value) {
    switch (value) {
      case 'Close':
        _auth.signOut();
        Navigator.pop(context);
        break;
      case 'Settings':
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Settings()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              // ignore: sdk_version_set_literal
              return {
                'Settings',
                'Close',
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        title: Text('🔥 Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firesotre.collection("messages").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data.documents;
                  List<Text> messageWidgets = [];
                  for (var message in messages) {
                    String msg = message.data["messages"];
                    String sender = message.data['sender'];
                    Widget msgwidgets = Text("$msg from $sender");
                    messageWidgets.add(msgwidgets);
                  }
                  return Column(children: messageWidgets);
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
                      onChanged: (value) {
                        _message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _firesotre.collection('messages').add({
                        'messages': _message,
                        'sender': loggedInUser.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
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
