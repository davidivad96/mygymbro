import 'package:flutter/material.dart';

import 'package:mygymbro/data/exercises.dart';
import 'package:mygymbro/models/exercise.dart';
import 'package:mygymbro/widgets/bottom_nav_bar.dart';
import 'package:mygymbro/widgets/custom_app_bar.dart';
import 'package:mygymbro/screens/exercises.dart';
import 'package:mygymbro/screens/graphs.dart';
import 'package:mygymbro/screens/settings.dart';
import 'package:mygymbro/screens/workout.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  // Exercises screen state
  late List<Exercise> _exerciseList = [];
  late List<Exercise> _filteredExerciseList = [];
  late List<Exercise> _finalExerciseList = [];
  late String _targetArea = "Any target";

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _exerciseList = exercises;
    _exerciseList.sort((a, b) => a.name.compareTo(b.name));
    _finalExerciseList = _filteredExerciseList = _exerciseList;
  }

  _setTargetArea(String area) {
    setState(() {
      _targetArea = area;
      _filteredExerciseList = _exerciseList
          .where(
            (Exercise exercise) =>
                exercise.targetArea == _targetArea ||
                _targetArea == "Any target",
          )
          .toList();
      _finalExerciseList = _filteredExerciseList;
    });
  }

  _onSearchChanged(String query) {
    setState(() {
      _finalExerciseList = _filteredExerciseList
          .where(
            (Exercise exercise) =>
                exercise.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  Widget getScreen() {
    switch (_currentIndex) {
      case 0:
        return const Workout();
      case 1:
        return Exercises(
          finalExerciseList: _finalExerciseList,
          targetArea: _targetArea,
          setTargetArea: _setTargetArea,
          onSearchChanged: _onSearchChanged,
        );
      case 2:
        return const Graphs();
      case 3:
        return const Settings();
      default:
        return const Workout();
    }
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
        child: getScreen(),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        changePage: _changePage,
      ),
    );
  }
}
