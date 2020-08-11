import 'package:firechat/screens/root_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';

main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blue,
          accentColor: Colors.blue,
          scaffoldBackgroundColor: Colors.grey.shade900,
          // ignore: deprecated_member_use
          textTheme: TextTheme(headline: TextStyle(color: Colors.white))),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
      },
      home: RootScreen(),
    );
  }
}
