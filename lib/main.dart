import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

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
        data: (brightness) => ThemeData(
            brightness: brightness,
            //rest of the themeData
            //you can also use conditioning here based on the current
            //brightness mode (dark or light). For ex:
            primaryColor: brightness == Brightness.dark
                ? Colors.white
                : Colors.grey.shade900,
            scaffoldBackgroundColor: brightness == Brightness.dark
                ? Colors.grey.shade900
                : Colors.white),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            theme: theme,
            initialRoute: WelcomeScreen.id,
            routes: {
              WelcomeScreen.id: (context) => WelcomeScreen(),
              ChatScreen.id: (context) => ChatScreen(),
              RegistrationScreen.id: (context) => RegistrationScreen(),
              LoginScreen.id: (context) => LoginScreen()
            },
          );
        });
  }
}
