import 'package:flutter/material.dart';
import 'package:vocapp/model/app.dart';
import 'package:vocapp/pages/home_page.dart';

void main() async {
  runApp(MyApp());
  new App();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(
        duration: 3,
        goToPage: HomePage(),
      ),
    );
  }
}

class SplashPage extends StatelessWidget {
  late final int duration;
  late final Widget goToPage;

  SplashPage({required this.goToPage, required this.duration});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: this.duration), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => this.goToPage));
    });

    return Scaffold(
      body: Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: Icon(Icons.auto_stories, color: Colors.white, size: 100),
      ),
    );
  }
}
