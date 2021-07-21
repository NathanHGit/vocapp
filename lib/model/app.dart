import 'package:vocapp/model/voc.dart';
import 'package:flutter/material.dart';
import 'package:vocapp/repositories/vocapp_database.dart';

class App {
  static late double progression;
  static late List<Voc> voc;

  static final ButtonStyle buttonStyle =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20), padding: const EdgeInsets.all(20.0));

  App() {
    init();
  }

  void init() async {
    App.voc = await VocappDatabase.instance.getVoc();
    App.progression = await VocappDatabase.instance.getProgression();

    final DateTime today = new DateTime.now();
    final DateTime lastUpdate = await VocappDatabase.instance.getLastUpdate();

    if (lastUpdate == today) {
      return;
    }

    VocappDatabase.instance.pushTraining();

    if (lastUpdate != today.subtract(Duration(days: 1))) {
      final int diff = today.subtract(Duration(days: 1)).difference(lastUpdate).inDays;

      VocappDatabase.instance.delayedVocDates(diff);
    }
  }
}
