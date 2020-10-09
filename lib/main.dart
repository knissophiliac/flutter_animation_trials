import 'package:animtrials/ui/pages/circles_fullscreen.dart';
import 'package:animtrials/ui/pages/circles_pageview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: false,
      debugShowCheckedModeBanner: false,
      title: "Anim Trials",
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anim Trials"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Circles PageView"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CirclesPageView()),
              );
            },
          ),
          ListTile(
            title: Text("Circles Fullscreen"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CirclesFullscreenPage()),
              );
            },
          )
        ],
      ),
    );
  }
}
