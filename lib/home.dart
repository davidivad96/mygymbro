import 'package:flutter/material.dart';

import 'package:mygymbro/main.dart';
import 'package:mygymbro/models/language.dart';
import 'package:mygymbro/screens/train.dart';
import 'package:mygymbro/screens/graphs.dart';
import 'package:mygymbro/screens/settings.dart';
import 'package:mygymbro/utils/localization.dart';
import 'package:mygymbro/widgets/header.dart';
import 'package:mygymbro/widgets/bottom_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  Language _language = Language.defaultLanguage;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    getLocale().then((locale) {
      setState(() {
        _language = getLanguage(locale);
      });
    });
  }

  Widget getScreen() {
    if (_currentIndex == 0) return const Train();
    if (_currentIndex == 1) return const Graphs();
    if (_currentIndex == 2) {
      return Settings(
        language: _language,
        changeLanguage: _changeLanguage,
      );
    }
    return const Train();
  }

  void _changePage(int? index) {
    setState(() {
      _currentIndex = index!;
    });
  }

  void _changeLanguage(String locale) async {
    setState(() {
      _language = getLanguage(locale);
    });
    MyApp.setLocale(context, locale);
    await setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          const Header(),
          getScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        changePage: _changePage,
      ),
    );
  }
}
