import 'package:flutter/material.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/models/training.dart';
import 'package:mygymbro/models/workout.dart';
import 'package:mygymbro/screens/create_workout_screen.dart';
import 'package:mygymbro/utils/dimensions.dart';
import 'package:mygymbro/widgets/workout_card.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  final List<Workout> _workouts = [];

  void _addWorkout(String name, List<Training> trainings) {
    setState(() {
      _workouts.add(Workout(name, trainings));
    });
  }

  void _editWorkout(int index, String name, List<Training> trainings) {
    setState(() {
      _workouts[index] = Workout(name, trainings);
    });
  }

  void _deleteWorkout(int index) async {
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
            child: const Text(WorkoutsConstants.dialogNo),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _workouts.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text(WorkoutsConstants.dialogYes),
          ),
        ],
      ),
    );
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
                    ? ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: _workouts.length,
                        itemBuilder: (context, index) {
                          return Container(
                            constraints: BoxConstraints(
                              minHeight: Dimensions.cardMinHeight,
                            ),
                            child: WorkoutCard(
                              workout: _workouts[index],
                              editWorkout: (name, training) =>
                                  _editWorkout(index, name, training),
                              deleteWorkout: () => _deleteWorkout(index),
                            ),
                          );
                        },
                      )
                    : SizedBox(
                        width: Dimensions.centeredContentWidth,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              WorkoutsConstants.noWorkoutRoutinesTitle,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
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
            ],
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: FloatingActionButton(
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
