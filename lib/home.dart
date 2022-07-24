import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:mygymbro/models/history.dart';
import 'package:mygymbro/models/training.dart';
import 'package:mygymbro/models/training_result.dart';
import 'package:mygymbro/screens/exercises_screen.dart';
import 'package:mygymbro/screens/history_screen.dart';
import 'package:mygymbro/screens/graphs_screen.dart';
import 'package:mygymbro/screens/workouts_screen.dart';
import 'package:mygymbro/utils/functions.dart';
import 'package:mygymbro/widgets/bottom_nav_bar.dart';
import 'package:mygymbro/widgets/custom_app_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("history");
  List<History> _history = [];

  void _initHistory() async {
    final snapshot = await _dbRef.get();
    if (snapshot.exists) {
      final history = snapshot.children;
      setState(() {
        _history = history
            .map(
              (snapshot) => History.fromJson(transformSnapshot(snapshot.value)),
            )
            .toList()
            .reversed
            .toList();
      });
    }
  }

  void _addHistory(
    String workoutName,
    String duration,
    String date,
    List<Training> trainings,
    List<TrainingResult> trainingResults,
  ) async {
    DatabaseReference newHistoryRef = _dbRef.push();
    String id = newHistoryRef.key!;
    // add history to db
    final history = History(
      id,
      workoutName,
      duration,
      date,
      trainings,
      trainingResults,
    );
    _dbRef.child(id).set(history.toJson());
    // add history to state
    setState(() {
      _history.insert(0, history);
    });
  }

  void _updateHistory(
    String id,
    List<TrainingResult> trainingResults,
  ) async {
    // update history in db
    _dbRef.child(id).update({
      "trainingResults": trainingResults
          .map((trainingResult) => trainingResult.toJson())
          .toList()
    });
    // update history in state
    setState(() {
      _history[_history.indexWhere((history) => history.id == id)]
          .trainingResults = trainingResults;
    });
  }

  void _removeHistory(String id) {
    // delete workout from db
    _dbRef.child(id).remove();
    // delete workout from state
    setState(() {
      _history.removeWhere((history) => history.id == id);
    });
  }

  void _changePage(int? index) {
    setState(() {
      _currentIndex = index!;
    });
  }

  @override
  void initState() {
    super.initState();
    _initHistory();
  }

  @override
  void dispose() {
    _dbRef.onDisconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      WorkoutsScreen(addHistory: _addHistory),
      HistoryScreen(
        history: _history,
        updateHistory: _updateHistory,
        removeHistory: _removeHistory,
      ),
      const ExercisesScreen(),
      const GraphsScreen(),
    ];
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
