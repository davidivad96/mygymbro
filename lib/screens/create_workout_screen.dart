import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/models/exercise.dart';
import 'package:mygymbro/models/training.dart';
import 'package:mygymbro/utils/dimensions.dart';
import 'package:mygymbro/widgets/exercises_search.dart';
import 'package:mygymbro/widgets/training_card.dart';

class CreateWorkoutScreen extends StatefulWidget {
  final void Function(String name, List<Training> trainings) addWorkout;

  const CreateWorkoutScreen({Key? key, required this.addWorkout})
      : super(key: key);

  @override
  State<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  final TextEditingController _controller = TextEditingController(
    text: WorkoutConstants.workoutInitialName,
  );
  final List<Training> _trainings = [];

  Future<bool> _onWillPop() async {
    if (_trainings.isEmpty) {
      return true;
    }
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

  _showPickerNumber(Exercise exercise) {
    Picker(
      adapter: NumberPickerAdapter(
        data: [
          const NumberPickerColumn(
            begin: 1,
            end: 10,
            jump: 1,
            initValue: 3,
          ),
          const NumberPickerColumn(
            begin: 1,
            end: 100,
            jump: 1,
            initValue: 5,
          ),
        ],
      ),
      delimiter: [
        PickerDelimiter(
          child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: const Icon(Icons.close),
          ),
        )
      ],
      hideHeader: true,
      title: const Text(ExercisesConstants.selectSetsAndReps),
      selectedTextStyle: const TextStyle(color: Colors.blue),
      onConfirm: (Picker picker, List value) {
        setState(
          () => {
            _trainings.add(
              Training(
                exercise,
                picker.getSelectedValues()[0] as int,
                picker.getSelectedValues()[1] as int,
              ),
            )
          },
        );
        Navigator.pop(context);
      },
    ).showDialog(context);
  }

  void _onPressSaveButton() {
    if (_controller.text.isEmpty || _trainings.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            _controller.text.isEmpty
                ? WorkoutConstants.dialogNoWorkoutNameTitle
                : WorkoutConstants.dialogNoExercisesTitle,
          ),
          content: Text(
            _controller.text.isEmpty
                ? WorkoutConstants.dialogNoWorkoutNameContent
                : WorkoutConstants.dialogNoExercisesContent,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(WorkoutConstants.dialogOk),
            ),
          ],
        ),
      );
    } else {
      widget.addWorkout(_controller.text, _trainings);
      Navigator.pop(context);
    }
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
                    child: _trainings.isNotEmpty
                        ? ListView.builder(
                            itemCount: _trainings.length,
                            itemBuilder: (context, index) {
                              return Container(
                                constraints: BoxConstraints(
                                  minHeight: Dimensions.cardMinHeight,
                                ),
                                child:
                                    TrainingCard(training: _trainings[index]),
                              );
                            },
                          )
                        : SizedBox(
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
                                Text(
                                  WorkoutConstants.noExercisesText,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Theme.of(context).highlightColor,
                      ),
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
                                      margin: const EdgeInsets.only(
                                        bottom: 15.0,
                                      ),
                                      child: IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ),
                                    ExercisesSearch(
                                      onTapItem: (Exercise exercise) {
                                        _showPickerNumber(exercise);
                                      },
                                    ),
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
                      onPressed: () {
                        _onPressSaveButton();
                      },
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
