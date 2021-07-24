import 'package:vocapp/models/app.dart';
import 'package:flutter/material.dart';
import 'package:vocapp/pages/results_page.dart';
import 'package:vocapp/repositories/vocapp_database.dart';

class TrainingPage extends StatefulWidget {
  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  bool isVisible = false;
  int index = 0;

  void changeVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  void next(int weight) {
    setState(() {
      voc[index].weight = weight;
      VocappDatabase.instance.updateWeight(voc[index]);

      if (index < voc.length - 1) {
        index++;
        isVisible = !isVisible;
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ResultsPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Training'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  (index + 1).toString() + '/' + voc.length.toString(),
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 75),
                Text(
                  voc[index].lemma,
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(height: 5),
                Text(
                  voc[index].pos,
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20, color: Colors.grey[600]),
                ),
                SizedBox(height: 40),
                Visibility(
                  visible: !isVisible,
                  child: ElevatedButton(
                    onPressed: () {
                      changeVisibility();
                    },
                    child: Text('Show'),
                    style: buttonStyle(),
                  ),
                ),
                Visibility(
                  visible: isVisible,
                  child: Column(
                    children: [
                      Text(
                        "fr: " + voc[index].translation,
                        style: TextStyle(fontSize: 22),
                      ),
                      SizedBox(height: 10),
                      Text(
                        voc[index].inflections,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 60),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          new Container(
                            margin: const EdgeInsets.all(10.0),
                            child: ElevatedButton(
                              style: buttonStyle(colors['review']),
                              child: Text("Review", style: TextStyle(color: Colors.white, fontSize: 19)),
                              onPressed: () {
                                next(-1);
                              },
                            ),
                          ),
                          new Container(
                            margin: const EdgeInsets.all(10.0),
                            child: ElevatedButton(
                              style: buttonStyle(colors['correct']),
                              child: Text("Correct", style: TextStyle(color: Colors.white, fontSize: 19)),
                              onPressed: () {
                                next(1);
                              },
                            ),
                          ),
                          new Container(
                            margin: const EdgeInsets.all(10.0),
                            child: ElevatedButton(
                              style: buttonStyle(colors['easy']),
                              child: Text("Easy", style: TextStyle(color: Colors.white, fontSize: 19)),
                              onPressed: () {
                                next(2);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
