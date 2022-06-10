// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:mygymbro/screens/train.dart';
import 'package:mygymbro/screens/graphs.dart';
import 'package:mygymbro/screens/settings.dart';

import 'package:mygymbro/widgets/header.dart';
import 'package:mygymbro/widgets/bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyGymBro',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        highlightColor: Colors.white,
        fontFamily: "OpenSans",
      ),
      home: const MyGymBroApp(),
    );
  }
}

class MyGymBroApp extends StatefulWidget {
  const MyGymBroApp({Key? key}) : super(key: key);

  @override
  State<MyGymBroApp> createState() => _MyGymBroAppState();
}

class _MyGymBroAppState extends State<MyGymBroApp> {
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
