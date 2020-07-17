import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firechat/screens/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'configs/themedata.dart';
import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';

main() {
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => themeData(brightness),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: WelcomeScreen.id,
            theme: theme,
            routes: {
              WelcomeScreen.id: (context) => WelcomeScreen(),
              ChatScreen.id: (context) => ChatScreen(),
              RegistrationScreen.id: (context) => RegistrationScreen(),
              LoginScreen.id: (context) => LoginScreen(),
              Settings.id: (context) => Settings(),
            },
          );
        });
  }
}
