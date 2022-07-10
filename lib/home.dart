import 'package:flutter/material.dart';

import 'package:mygymbro/screens/exercises_screen.dart';
import 'package:mygymbro/screens/graphs_screen.dart';
import 'package:mygymbro/screens/workouts_screen.dart';
import 'package:mygymbro/widgets/bottom_nav_bar.dart';
import 'package:mygymbro/widgets/custom_app_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final pages = [
    const WorkoutsScreen(),
    const ExercisesScreen(),
    const GraphsScreen(),
  ];

  void _changePage(int? index) {
    setState(() {
      _currentIndex = index!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: IndexedStack(
          index: _currentIndex,
          children: pages,
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        changePage: _changePage,
      ),
    );
  }
}
