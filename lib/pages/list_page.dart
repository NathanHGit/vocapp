import 'package:vocapp/model/app.dart';
import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vocabulary list'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
            itemCount: App.voc.length,
            itemBuilder: (BuildContext ctx, int index) {
              return Card(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(children: [
                        Text(App.voc[index].lemma, style: TextStyle(fontSize: 16, color: Colors.blue)),
                        SizedBox(width: 15.0),
                        Text(App.voc[index].translation, style: TextStyle(fontSize: 16)),
                        SizedBox(width: 15.0),
                        Text(
                          App.voc[index].getPos(),
                          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                        ),
                      ])));
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.school),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
