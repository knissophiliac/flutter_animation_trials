import 'package:animtrials/ui/pages/circles_pageview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Anim Trials",
      home: CirclesPageView(),
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
          )
        ],
      ),
    );
  }
}
