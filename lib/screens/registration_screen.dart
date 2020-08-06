import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/constants.dart';
import 'package:firechat/screens/chat_screen.dart';
import 'package:firechat/widgets/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'login_screen.dart';
import 'welcome_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  final _auth = FirebaseAuth.instance;
  String _email;
  String _password;
  bool _loading = false;

  _showSnackBar(String error) {
    final snackBar = SnackBar(
      content: Text("$error"),
    );
    _key.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: Padding(
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
                  _email = value.toString();
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  showCursor: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    _password = value.toString();
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your Password')),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  colors: Colors.blueAccent,
                  text: 'Register',
                  onPressed: () async {
                    setState(() {
                      _loading = true;
                    });
                    if (!_email.contains('@')) {
                      _showSnackBar('Invalid Email address');
                    } else if (_password.length < 6) {
                      _showSnackBar('Password should contain 6 letter at lest');
                    } else {
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: _email.trim(),
                                password: _password.trim());
                        print(newUser);
                        if (newUser == null) {
                          CircularProgressIndicator();
                        } else {
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                        setState(() {
                          _loading = false;
                        });
                      } catch (e) {
                        print('Error : $e');
                      }
                    }
                  }),
              Center(
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          ModalRoute.withName(WelcomeScreen.id));
                    },
                    child: Text("Already Registered!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
