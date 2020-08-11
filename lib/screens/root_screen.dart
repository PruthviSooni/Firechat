import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/screens/chat_screen.dart';
import 'package:firechat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  static final String id = "root_screen";
  @override
  _RootScreenState createState() => _RootScreenState();
}

enum AuthState { isSignedIn, notSignedIn }

class _RootScreenState extends State<RootScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthState _authState = AuthState.notSignedIn;
  @override
  void initState() {
    _auth.currentUser().then((userId) {
      setState(() {
        _authState =
            userId == null ? AuthState.notSignedIn : AuthState.isSignedIn;
      });
    });
    super.initState();
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    switch (_authState) {
      case AuthState.notSignedIn:
        return WelcomeScreen();
        break;
      case AuthState.isSignedIn:
        return ChatScreen();
    }
  }
}
