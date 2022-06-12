// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:mygymbro/home.dart';
import 'package:mygymbro/localization/app_localization.dart';
import 'package:mygymbro/models/language.dart';
import 'package:mygymbro/utils/localization.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, String locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(String locale) {
    setState(() {
      _locale = Locale(locale);
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setLocale(locale);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_locale == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return MaterialApp(
      title: 'MyGymBro',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        highlightColor: Colors.white,
        backgroundColor: Colors.grey[200],
        fontFamily: "Poppins",
      ),
      home: const Home(),
      locale: _locale,
      supportedLocales:
          Language.languageList.map((element) => Locale(element.code)).toList(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalization.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (deviceLocale != null &&
              locale.languageCode == deviceLocale.languageCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
