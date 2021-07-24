import 'package:vocapp/models/app.dart';
import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<int, Color?> states = {
      -1: colors['review'],
      0: Colors.blue,
      1: colors['correct'],
      2: colors['easy'],
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Vocabulary list'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: voc.length,
              itemBuilder: (BuildContext ctx, int index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          height: 10,
                          width: 20,
                          decoration: BoxDecoration(
                            color: states[voc[index].weight],
                            borderRadius: BorderRadius.all(
                              Radius.circular(3.0),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Text(voc[index].lemma, style: TextStyle(fontSize: 16, color: colors['primary'])),
                        SizedBox(width: 15.0),
                        Flexible(
                          child: Text(voc[index].translation, style: TextStyle(fontSize: 16)),
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          voc[index].getPos(),
                          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
