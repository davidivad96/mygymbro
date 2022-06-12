import 'package:flutter/material.dart';

import 'package:mygymbro/screens/training.dart';
import 'package:mygymbro/screens/graphs.dart';
import 'package:mygymbro/screens/settings.dart';
import 'package:mygymbro/widgets/bottom_nav_bar.dart';
import 'package:mygymbro/widgets/custom_app_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  Widget getScreen() {
    if (_currentIndex == 0) return const Training();
    if (_currentIndex == 1) return const Graphs();
    if (_currentIndex == 2) {
      return const Settings();
    }
    return const Training();
  }

  void _changePage(int? index) {
    setState(() {
      _currentIndex = index!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          child: getScreen(),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        changePage: _changePage,
      ),
    );
  }
}
