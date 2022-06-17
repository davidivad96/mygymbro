// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:mygymbro/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyGymBro',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        highlightColor: Colors.white,
        backgroundColor: Colors.grey[200],
        fontFamily: "Poppins",
      ),
      home: const Home(),
    );
  }
}
