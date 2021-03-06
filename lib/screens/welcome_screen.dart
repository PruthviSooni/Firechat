import 'package:firechat/screens/registration_screen.dart';
import 'package:firechat/widgets/animated_title.dart';
import 'package:firechat/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation =
        ColorTween(begin: Colors.grey.shade700, end: Colors.grey.shade900)
            .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: animation.value,
        elevation: 0,
      ),
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/fire.png'),
                      height: 60.0,
                      margin: EdgeInsets.only(bottom: 0),
                    ),
                  ),
                ),
                AnimatedTitle(
                  title: "Firechat",
                ),
                Spacer(
                  flex: 2,
                )
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            RoundedButton(
              text: 'Login',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              colors: Colors.blueAccent,
            ),
            RoundedButton(
              text: 'Register',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              colors: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
