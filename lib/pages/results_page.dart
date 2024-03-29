import 'package:vocapp/models/app.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:confetti/confetti.dart';
import 'package:vocapp/pages/menu_page.dart';
import "dart:math";

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

late ConfettiController confetti;

class _ResultsPageState extends State<ResultsPage> {
  String feedback = '';
  double results = 0.0;
  Color? backgroundColor;
  late IconData icon;

  @override
  void initState() {
    super.initState();
    confetti = ConfettiController(duration: Duration(seconds: 1));
    results = getResults();
    if (results > 2 / 3) {
      feedback = feedbacks[0]![(new Random()).nextInt(feedbacks[0]!.length)];
      backgroundColor = colors['easy'];
      icon = Icons.emoji_events;
      confetti.play();
    } else if (results > 1 / 3) {
      feedback = feedbacks[1]![(new Random()).nextInt(feedbacks[1]!.length)];
      backgroundColor = colors['correct'];
      icon = Icons.sentiment_very_satisfied_outlined;
    } else {
      feedback = feedbacks[2]![(new Random()).nextInt(feedbacks[2]!.length)];
      backgroundColor = colors['review'];
      icon = Icons.sentiment_very_dissatisfied_outlined;
    }
  }

  double getResults() {
    double results = 0;
    voc.forEach((element) {
      if (element.weight > 0) results += 1;
    });
    return results / voc.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: this.backgroundColor,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 40, right: 20),
                child: IconButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MenuPage()),
                    (Route<dynamic> route) => false,
                  ),
                  icon: const Icon(Icons.clear),
                  color: Colors.grey[100],
                  iconSize: 30,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: ConfettiWidget(
                  confettiController: confetti,
                  blastDirection: -45,
                  emissionFrequency: 0.5,
                  numberOfParticles: 1,
                  shouldLoop: false,
                  displayTarget: false,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: ConfettiWidget(
                  confettiController: confetti,
                  blastDirection: -90,
                  emissionFrequency: 0.5,
                  numberOfParticles: 1,
                  shouldLoop: false,
                  displayTarget: false,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    this.feedback,
                    style: TextStyle(color: Colors.grey[100], fontSize: 40),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width * 2 / 3,
                        lineHeight: 20.0,
                        percent: getResults(),
                        animation: true,
                        backgroundColor: Colors.grey[300],
                        progressColor: Colors.grey[100],
                      ),
                    ],
                  ),
                  SizedBox(height: 75),
                  Icon(
                    icon,
                    size: 120,
                    color: Colors.grey[100],
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
