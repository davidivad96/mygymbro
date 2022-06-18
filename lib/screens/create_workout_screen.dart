import 'package:flutter/material.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/data/trainings.dart';
import 'package:mygymbro/utils/dimensions.dart';
import 'package:mygymbro/widgets/exercises_search.dart';
import 'package:mygymbro/widgets/training_card.dart';

class CreateWorkoutScreen extends StatefulWidget {
  const CreateWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  final TextEditingController _controller = TextEditingController(
    text: WorkoutConstants.workoutInitialName,
  );

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(WorkoutConstants.dialogTitle),
            content: const Text(
              WorkoutConstants.dialogContent,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(WorkoutConstants.dialogNo),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(WorkoutConstants.dialogYes),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            WorkoutConstants.createWorkout,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 2.0,
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              Dimensions.screenPaddingHorizontal,
              Dimensions.screenPaddingVertical,
              Dimensions.screenPaddingHorizontal,
              Dimensions.screenPaddingVertical,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: WorkoutConstants.workoutNameHintText,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 20.0,
                      bottom: 20.0,
                    ),
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          constraints: BoxConstraints(
                            minHeight: Dimensions.cardMinHeight,
                          ),
                          child: TrainingCard(training: trainings[index]),
                        );
                      },
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          color: Theme.of(context).backgroundColor,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              Dimensions.modalPaddingHorizontal,
                              Dimensions.modalPaddingVertical,
                              Dimensions.modalPaddingHorizontal,
                              Dimensions.modalPaddingVertical,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 30.0),
                                  child: IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ),
                                const ExercisesSearch(),
                              ],
                            ),
                          ),
                        );
                      },
                      isScrollControlled: true,
                    );
                  },
                  child: const Text(
                    WorkoutConstants.addExercise,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    WorkoutConstants.save,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
