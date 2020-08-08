import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function onPressed;
  final Color colors;
  final String text;

  RoundedButton({
    @required this.onPressed,
    @required this.colors,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colors,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            // ignore: deprecated_member_use
            style: TextStyle(color: Theme.of(context).textTheme.headline.color),
          ),
        ),
      ),
    );
  }
}
