import 'package:flutter/material.dart';
import 'package:mygymbro/models/training_result.dart';
import 'package:uuid/uuid.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:mygymbro/models/history.dart';
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
            .toList();
      });
    }
  }

  void _addHistory(
    String workoutName,
    int duration,
    String date,
    List<TrainingResult> trainingResults,
  ) async {
    String id = const Uuid().v4();
    // add history to db
    final history = History(
      id,
      workoutName,
      duration,
      date,
      trainingResults,
    );
    _dbRef.get().then((snapshot) {
      _dbRef.child(snapshot.children.length.toString()).set(history.toJson());
    });
    // add history to state
    setState(() {
      _history.add(history);
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
      HistoryScreen(history: _history),
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
