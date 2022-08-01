import 'dart:math';
import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:mygymbro/models/graph.dart';
import 'package:mygymbro/models/history.dart';
import 'package:mygymbro/models/training.dart';
import 'package:mygymbro/models/training_result.dart';
import 'package:mygymbro/models/workout.dart';
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
  final DatabaseReference _historyDbRef =
      FirebaseDatabase.instance.ref("history");
  List<History> _history = [];
  List<Graph> _graphs = [];

  Future<void> _initHistory() async {
    final snapshot = await _historyDbRef.get();
    if (snapshot.exists) {
      final history = snapshot.children
          .map(
            (snapshot) => History.fromJson(transformSnapshot(snapshot.value)),
          )
          .toList()
          .reversed
          .toList();
      setState(() {
        _history = history;
      });
    }
  }

  Future<void> _initGraphs() async {
    List<Graph> graphs = [];
    for (History history in _history) {
      for (TrainingResult trainingResult in history.trainingResults) {
        final validSets = trainingResult.sets.where((set) => set.done == true);
        if (validSets.isNotEmpty) {
          final x = DateTime.parse(history.date);
          final y = validSets.map((set) => set.kgs!).reduce(max<double>);
          Data data = Data(x, y, history.id);
          int index = graphs.indexWhere(
            (graph) => graph.exercise.id == trainingResult.exercise.id,
          );
          if (index == -1) {
            graphs.add(
              Graph(
                trainingResult.exercise,
                [data],
              ),
            );
          } else if (graphs[index].data.last.historyId == history.id) {
            graphs[index].data.last.y = max(graphs[index].data.last.y!, y);
          } else {
            graphs[index].data.add(data);
          }
        }
      }
    }
    setState(() {
      _graphs = graphs;
    });
  }

  void _init() async {
    await _initHistory();
    await _initGraphs();
  }

  void _finishWorkout(
    Workout workout,
    String duration,
    String date,
    List<Training> trainings,
    List<TrainingResult> trainingResults,
  ) async {
    DatabaseReference newHistoryRef = _historyDbRef.push();
    String id = newHistoryRef.key!;
    // add history to db
    final history = History(
      id,
      workout.name,
      duration,
      date,
      trainings,
      trainingResults.map((trainingResult) {
        trainingResult.historyId = id;
        return trainingResult;
      }).toList(),
      workout.id,
    );
    _historyDbRef.child(id).set(history.toJson());
    // add history to state
    setState(() {
      _history.insert(0, history);
    });
    await _initGraphs();
  }

  void _updateHistory(
    String id,
    List<TrainingResult> trainingResults,
  ) async {
    // update history in db
    _historyDbRef.child(id).update({
      "trainingResults": trainingResults
          .map((trainingResult) => trainingResult.toJson())
          .toList(),
    });
    // update history in state
    setState(() {
      _history[_history.indexWhere((history) => history.id == id)]
          .trainingResults = trainingResults;
    });
    await _initGraphs();
  }

  void _removeHistory(String id) async {
    // delete workout from db
    _historyDbRef.child(id).remove();
    // delete workout from state
    setState(() {
      _history.removeWhere((history) => history.id == id);
    });
    await _initGraphs();
  }

  void _changePage(int? index) {
    setState(() {
      _currentIndex = index!;
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _historyDbRef.onDisconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      WorkoutsScreen(finishWorkout: _finishWorkout),
      HistoryScreen(
        history: _history,
        updateHistory: _updateHistory,
        removeHistory: _removeHistory,
      ),
      const ExercisesScreen(),
      GraphsScreen(graphs: _graphs),
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
