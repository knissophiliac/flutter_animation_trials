import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  final Function onPressed;
  final Color color;

  const SkipButton({Key key, this.onPressed, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: onPressed,
        child: Text(
          "Skip",
          style: TextStyle(color: color),
        ));
  }
}
