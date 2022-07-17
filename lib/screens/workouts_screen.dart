import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/models/training.dart';
import 'package:mygymbro/models/workout.dart';
import 'package:mygymbro/screens/create_workout_screen.dart';
import 'package:mygymbro/utils/dimensions.dart';
import 'package:mygymbro/widgets/big_text.dart';
import 'package:mygymbro/widgets/workout_card.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  List<Workout> _workouts = [];

  void _addWorkout(String name, List<Training> trainings) async {
    String id = const Uuid().v4();
    Workout workout = Workout(
      id,
      name,
      trainings,
    );
    // add workout to database
    _dbRef.child('workouts/$id').set(workout.toJson());
    // add workout to state
    setState(() {
      _workouts.add(workout);
    });
  }

  void _editWorkout(String id, String name, List<Training> trainings) {
    Workout workout = Workout(
      id,
      name,
      trainings,
    );
    // update workout in database
    _dbRef.child('workouts/$id').set(workout.toJson());
    // update workout in state
    setState(() {
      int index = _workouts.indexWhere((workout) => workout.id == id);
      _workouts[index] = workout;
    });
  }

  void _deleteWorkout(String id) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(WorkoutsConstants.dialogDeleteWorkoutTitle),
        content: const Text(
          WorkoutsConstants.dialogDeleteWorkoutContent,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              WorkoutsConstants.dialogNo,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // delete workout from database
              _dbRef.child('workouts/$id').remove();
              // delete workout from state
              setState(() {
                _workouts.removeWhere((workout) => workout.id == id);
              });
              Navigator.pop(context);
            },
            child: Text(
              WorkoutsConstants.dialogYes,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _initWorkouts() async {
    final snapshot = await _dbRef.child('workouts').get();
    if (snapshot.exists) {
      final workouts =
          jsonDecode(jsonEncode(snapshot.value)) as Map<String, dynamic>;
      setState(() {
        _workouts = workouts.values
            .map((workout) => Workout.fromJson(workout))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initWorkouts();
  }

  @override
  void dispose() {
    _dbRef.onDisconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Dimensions.screenPaddingHorizontal,
        Dimensions.screenPaddingVertical,
        Dimensions.screenPaddingHorizontal,
        Dimensions.screenPaddingVertical,
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin:
                    EdgeInsets.only(bottom: Dimensions.screenTitleMarginBottom),
                child: const Text(
                  WorkoutsConstants.title,
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: _workouts.isNotEmpty
                    ? ReorderableListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: _workouts.length,
                        itemBuilder: (context, index) {
                          Workout workout = _workouts[index];
                          return Container(
                            key: Key(workout.id),
                            constraints: BoxConstraints(
                              minHeight: Dimensions.cardMinHeight,
                            ),
                            child: WorkoutCard(
                              workout: workout,
                              editWorkout: (name, training) => _editWorkout(
                                workout.id,
                                name,
                                training,
                              ),
                              deleteWorkout: () => _deleteWorkout(workout.id),
                            ),
                          );
                        },
                        onReorder: (int oldIndex, int newIndex) {
                          setState(() {
                            if (newIndex > oldIndex) {
                              newIndex -= 1;
                            }
                            final Workout item = _workouts.removeAt(oldIndex);
                            _workouts.insert(newIndex, item);
                          });
                        },
                      )
                    : Center(
                        child: SizedBox(
                          width: Dimensions.centeredContentWidth,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.fitness_center,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              const BigText(
                                text: WorkoutsConstants.noWorkoutRoutinesTitle,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                WorkoutsConstants.noWorkoutRoutinesText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateWorkoutScreen(
                      addWorkout: _addWorkout,
                    ),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
