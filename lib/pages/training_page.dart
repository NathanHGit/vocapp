import 'package:vocapp/model/app.dart';
import 'package:flutter/material.dart';

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

  void changeVoc(bool increase) {
    setState(() {
      if (increase) {
        if (index < App.voc.length - 1) {
          index++;
          isVisible = !isVisible;
        } else {
          Navigator.pop(context);
        }
      } else if (!increase && index > 0) {
        index--;
        isVisible = !isVisible;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Training'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  (index + 1).toString() + '/' + App.voc.length.toString(),
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 75),
                Text(
                  App.voc[index].lemma,
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(height: 10),
                Text(
                  App.voc[index].pos,
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
                ),
                SizedBox(height: 40),
                Opacity(
                  opacity: isVisible ? 0 : 1,
                  child: ElevatedButton(
                    onPressed: () {
                      changeVisibility();
                    },
                    child: Text('Show'),
                    style: App.buttonStyle,
                  ),
                ),
                Opacity(
                  opacity: isVisible ? 1 : 0,
                  child: Column(
                    children: [
                      Text(
                        App.voc[index].translation,
                        style: TextStyle(fontSize: 22),
                      ),
                      SizedBox(height: 10),
                      Text(
                        App.voc[index].inflections,
                        style: TextStyle(fontSize: 22),
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red[600],
                              shape: CircleBorder(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(
                                Icons.thumb_down_alt_outlined,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              changeVoc(false);
                            },
                          ),
                          SizedBox(width: 30),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.green[600],
                              shape: CircleBorder(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(
                                Icons.thumb_up_alt_outlined,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              changeVoc(true);
                            },
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
