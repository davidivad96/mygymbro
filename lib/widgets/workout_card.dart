import 'package:flutter/material.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/models/training.dart';
import 'package:mygymbro/models/workout.dart';
import 'package:mygymbro/screens/create_workout_screen.dart';
import 'package:mygymbro/utils/dimensions.dart';

class WorkoutCard extends StatefulWidget {
  final Workout workout;
  final void Function(String name, List<Training> trainings) editWorkout;
  final void Function() deleteWorkout;

  const WorkoutCard({
    Key? key,
    required this.workout,
    required this.editWorkout,
    required this.deleteWorkout,
  }) : super(key: key);

  @override
  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(Dimensions.cardPadding),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton(
                  onSelected: (value) {
                    if (value == WorkoutsConstants.edit) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateWorkoutScreen(
                            workout: widget.workout,
                            editWorkout: widget.editWorkout,
                          ),
                        ),
                      );
                    } else if (value == WorkoutsConstants.delete) {
                      widget.deleteWorkout();
                    }
                  },
                  child: const Icon(Icons.more_horiz),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: WorkoutsConstants.edit,
                      child: Text(
                        WorkoutsConstants.edit,
                      ),
                    ),
                    const PopupMenuItem(
                      value: WorkoutsConstants.delete,
                      child: Text(
                        WorkoutsConstants.delete,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.workout.name,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  widget.workout.trainings
                      .map((training) => training.exercise.name)
                      .join(", "),
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(50.0, 30.0),
                  ),
                  child: const Text(
                    "Start",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
