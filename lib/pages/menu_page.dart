import 'package:flutter/material.dart';
import 'package:vocapp/pages/home_page.dart';
import 'package:vocapp/pages/summary_page.dart';
import 'package:vocapp/models/app.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int currentIndex = 1;

  final screens = [
    HomePage(),
    HomePage(),
    SummaryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Calendar',
            backgroundColor: colors['primary'],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
            backgroundColor: colors['primary'],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Summary',
            backgroundColor: colors['primary'],
          ),
        ],
      ),
    );
  }
}
