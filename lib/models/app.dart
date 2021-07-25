import 'package:vocapp/models/voc.dart';
import 'package:flutter/material.dart';
import 'package:vocapp/repositories/vocapp_database.dart';

List<Voc> voc = [];
double progression = 0.25;

Map<String, Color?> colors = {
  'primary': Colors.blue,
  'review': Colors.red[600],
  'correct': Colors.green[600],
  'easy': Colors.amber[600],
};

Map<int, List> feedbacks = {
  0: ['Congratulations !', 'Awesome !'],
  1: ['Well done', 'Great job'],
  2: ['Keep going', 'Do it again', 'What a pity'],
};

ButtonStyle buttonStyle([Color? color]) => ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20),
    padding: const EdgeInsets.all(15.0),
    primary: (color != null) ? color : colors['primary']);

//INIT DATABASE
Future init() async {
  final DateTime now = new DateTime.now();
  final DateTime today = new DateTime(now.year, now.month, now.day);

  DateTime lastUpdate = await VocappDatabase.instance.getLastUpdate();

  bool isNewDay = lastUpdate.compareTo(today) != 0;

  if (lastUpdate.compareTo(today.subtract(Duration(days: 1))) == -1) {
    final int diff = today.difference(lastUpdate).inDays;

    VocappDatabase.instance.postponeDates(diff);
  }

  if (isNewDay) {
    VocappDatabase.instance.pushTraining(lastUpdate);
    VocappDatabase.instance.setLastUpdate();
  }

  voc = await VocappDatabase.instance.getVoc(today != lastUpdate);
  progression = await VocappDatabase.instance.getProgression();

  if (isNewDay) {
    voc.forEach((element) => VocappDatabase.instance.updateWeight(element));
  }

  return await Future.delayed(Duration(seconds: 1), () => {});
}
