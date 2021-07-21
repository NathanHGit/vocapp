import 'package:flutter/material.dart';
import 'package:vocapp/model/app.dart';
import 'package:vocapp/pages/list_page.dart';
import 'package:vocapp/pages/training_page.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  CircularPercentIndicator(
                    radius: 150,
                    lineWidth: 20.0,
                    backgroundColor: Colors.white,
                    percent: App.progression,
                    progressColor: Theme.of(context).accentColor,
                    //circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    center: Text(
                      (App.progression.round() * 100).toString() + "%",
                      style: TextStyle(color: Colors.blue, fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Global progression", style: TextStyle(fontSize: 22)),
                  SizedBox(height: 10),
                  Text("English", style: TextStyle(fontSize: 20, color: Colors.grey)),
                ],
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ListPage()));
                  },
                  child: Text('List'),
                  style: App.buttonStyle,
                ),
                SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TrainingPage()));
                  },
                  child: Text('Training'),
                  style: App.buttonStyle,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
