import 'dart:math';
import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:mygymbro/models/graph.dart';
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
  final DatabaseReference _historyDbRef =
      FirebaseDatabase.instance.ref("history");
  final DatabaseReference _graphsDbRef =
      FirebaseDatabase.instance.ref("graphs");
  List<History> _history = [];
  List<Graph> _graphs = [];

  void _initHistory() async {
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

  void _initGraphs() async {
    final snapshot = await _graphsDbRef.get();
    if (snapshot.exists) {
      final graphs = snapshot.children
          .map(
            (snapshot) => Graph.fromJson(transformSnapshot(snapshot.value)),
          )
          .toList();
      setState(() {
        _graphs = graphs;
      });
    }
  }

  void _finishWorkout(
    String workoutName,
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
      workoutName,
      duration,
      date,
      trainings,
      trainingResults,
    );
    _historyDbRef.child(id).set(history.toJson());
    // add history to state
    setState(() {
      _history.insert(0, history);
    });
    // update/create graphs
    for (TrainingResult trainingResult in trainingResults) {
      final validSets = trainingResult.sets.where((set) => set.done == true);
      if (validSets.isNotEmpty) {
        final exercise = trainingResult.exercise;
        final x = DateTime.now().toString();
        final y = validSets.map((set) => set.kgs!).reduce(max<double>);
        final snapshot = await _graphsDbRef.child(exercise.id.toString()).get();
        if (snapshot.exists) {
          // update graph in db
          final graph = Graph.fromJson(transformSnapshot(snapshot.value));
          graph.data.add(Data(DateTime.parse(x), y));
          _graphsDbRef.child(exercise.id.toString()).set(graph.toJson());
          // update graph in state
          setState(() {
            _graphs[_graphs.indexWhere(
              (graph) => graph.exercise.id == exercise.id,
            )] = graph;
          });
        } else {
          // create graph in db
          final graph = Graph(
            exercise,
            [Data(DateTime.parse(x), y)],
          );
          _graphsDbRef.child(exercise.id.toString()).set(graph.toJson());
          // create graph in state
          setState(() {
            _graphs.add(graph);
          });
        }
      }
    }
  }

  void _updateHistory(
    String id,
    List<TrainingResult> trainingResults,
  ) async {
    // update history in db
    _historyDbRef.child(id).update({
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
    _historyDbRef.child(id).remove();
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
    _initGraphs();
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
