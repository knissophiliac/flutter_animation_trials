import 'package:flutter/material.dart';

class TutorialPage extends StatelessWidget {
  final String title;
  final String assetName;
  final Color titleColor;

  const TutorialPage({Key key, this.title, this.assetName, this.titleColor})
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
            color: titleColor.withOpacity(0.3),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.asset(
              assetName,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 500),
            style: TextStyle(
                color: titleColor, fontSize: 24, fontWeight: FontWeight.bold),
            child: Text(
              title,
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
