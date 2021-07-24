// @dart=2.9

import 'package:flutter/material.dart';
import 'package:vocapp/models/app.dart';
import 'package:vocapp/pages/menu_page.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: colors['primary'],
      ),
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    init().then((v) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MenuPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: colors['primary'],
        alignment: Alignment.center,
        child: Icon(Icons.auto_stories, color: Colors.white, size: 100),
      ),
    );
  }
}
