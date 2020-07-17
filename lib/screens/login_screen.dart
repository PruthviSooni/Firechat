import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/constants.dart';
import 'package:firechat/screens/chat_screen.dart';
import 'package:firechat/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import 'registration_screen.dart';
import 'welcome_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _email;
  String _password;
  _showSnackBar() {
    final snackBar = SnackBar(
      content: Text("Invalid Email or Password please check!"),
    );
    _key.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/fire.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  _email = value;
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email')),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  _password = value;
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password')),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              text: 'Login',
              onPressed: () async {
                try {
                  final existUser = await _auth
                      .signInWithEmailAndPassword(
                          email: _email.trim(), password: _password.trim())
                      .catchError((onError) {
                    _showSnackBar();
                  });
                  print(existUser);
                  if (existUser != null) {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                } catch (e) {
                  print(e);
                }
                //
              },
              colors: Colors.blueAccent,
            ),
            Center(
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationScreen()),
                        ModalRoute.withName(WelcomeScreen.id));
                  },
                  child: Text("Register here?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline))),
            )
          ],
        ),
      ),
    );
  }
}
