import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimatedTitle extends StatelessWidget {
  final String title;
  const AnimatedTitle({
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TypewriterAnimatedTextKit(
      text: [title],
      speed: Duration(milliseconds: 500),
      totalRepeatCount: 5,
      displayFullTextOnTap: true,
      isRepeatingAnimation: true,
      textStyle: TextStyle(
        fontSize: 50.0,
        // ignore: deprecated_member_use
        color: Theme.of(context).textTheme.headline.color,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
