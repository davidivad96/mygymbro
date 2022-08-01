import 'package:flutter/material.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/models/training.dart';
import 'package:mygymbro/models/training_result.dart';
import 'package:mygymbro/models/workout.dart';
import 'package:mygymbro/screens/create_workout_screen.dart';
import 'package:mygymbro/screens/start_workout_screen.dart';
import 'package:mygymbro/utils/dimensions.dart';
import 'package:mygymbro/widgets/main_button.dart';

class WorkoutCard extends StatefulWidget {
  final Workout workout;
  final void Function(String name, List<Training> trainings)
      onSelectEditWorkout;
  final void Function() onSelectDeleteWorkout;
  final void Function(
    Workout workout,
    String duration,
    String date,
    List<Training> trainings,
    List<TrainingResult> trainingResults,
  ) finishWorkout;

  const WorkoutCard({
    Key? key,
    required this.workout,
    required this.onSelectEditWorkout,
    required this.onSelectDeleteWorkout,
    required this.finishWorkout,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    widget.workout.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    if (value == GeneralConstants.edit) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateWorkoutScreen(
                            workout: widget.workout,
                            editWorkout: widget.onSelectEditWorkout,
                          ),
                        ),
                      );
                    } else if (value == GeneralConstants.delete) {
                      widget.onSelectDeleteWorkout();
                    }
                  },
                  child: const Icon(Icons.more_horiz),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: GeneralConstants.edit,
                      child: Text(
                        GeneralConstants.edit,
                      ),
                    ),
                    PopupMenuItem(
                      value: GeneralConstants.delete,
                      child: Text(
                        GeneralConstants.delete,
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
            const SizedBox(height: 15.0),
            MainButton(
              text: WorkoutsConstants.start,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StartWorkoutScreen(
                    workout: widget.workout,
                    trainings: widget.workout.trainings,
                    finishWorkout: widget.finishWorkout,
                  ),
                  fullscreenDialog: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
