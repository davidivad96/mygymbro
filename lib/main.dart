// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

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
      ),
      home: const MyGymBroApp(),
    );
  }
}

class MyGymBroApp extends StatelessWidget {
  const MyGymBroApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: const <Widget>[
          Header(),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
