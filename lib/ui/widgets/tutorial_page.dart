import 'package:flutter/material.dart';

class TutorialPage extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color titleColor;

  const TutorialPage({Key key, this.title, this.icon, this.titleColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 10, color: Colors.black26),
            borderRadius: BorderRadius.circular(48),
            color: Colors.black12,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              size: 180,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 32),
        Text(
          title,
          style: TextStyle(
              color: titleColor, fontSize: 36, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
