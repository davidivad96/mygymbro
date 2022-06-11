import 'package:flutter/material.dart';

import 'package:mygymbro/screens/train.dart';
import 'package:mygymbro/screens/graphs.dart';
import 'package:mygymbro/screens/settings.dart';

import 'package:mygymbro/widgets/header.dart';
import 'package:mygymbro/widgets/bottom_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _currentIndex = 0;

  static const List<Widget> screens = <Widget>[
    Train(),
    Graphs(),
    Settings(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  void _changePage(int? index) {
    setState(() {
      _currentIndex = index!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          const Header(),
          screens.elementAt(_currentIndex),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        changePage: _changePage,
      ),
    );
  }
}
