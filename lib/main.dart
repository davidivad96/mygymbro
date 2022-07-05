// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: GeneralConstants.appName,
      theme: ThemeData(
        primaryColor: const Color(0xFF3B60E4),
        highlightColor: const Color(0XFFFBFBFF),
        backgroundColor: Colors.grey[200],
        errorColor: const Color(0xFFEF3054),
        fontFamily: "Poppins",
      ),
      home: const Home(),
    );
  }
}
