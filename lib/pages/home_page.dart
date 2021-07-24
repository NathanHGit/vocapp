import 'package:flutter/material.dart';
import 'package:vocapp/models/app.dart';
import 'package:vocapp/pages/training_page.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(250),
          child: Column(
            children: [
              CircularPercentIndicator(
                radius: 150,
                lineWidth: 20.0,
                backgroundColor: Colors.white,
                percent: progression,
                progressColor: Theme.of(context).accentColor,
                animation: true,
                center: Text(
                  (progression * 100).round().toString() + "%",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Text("Global progression", style: TextStyle(fontSize: 22, color: Colors.white)),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(75), bottomRight: Radius.circular(75))),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TrainingPage()));
            },
            child: Text('Training'),
            style: buttonStyle(),
          ),
        ),
      ),
    );
  }
}
