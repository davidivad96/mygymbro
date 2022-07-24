import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/models/exercise.dart';
import 'package:mygymbro/models/training.dart';
import 'package:mygymbro/models/workout.dart';
import 'package:mygymbro/utils/dimensions.dart';
import 'package:mygymbro/widgets/big_text.dart';
import 'package:mygymbro/widgets/exercises_search.dart';
import 'package:mygymbro/widgets/main_button.dart';
import 'package:mygymbro/widgets/secondary_button.dart';
import 'package:mygymbro/widgets/training_card.dart';

class CreateWorkoutScreen extends StatefulWidget {
  final Workout? workout;
  final void Function(String name, List<Training> trainings)? addWorkout;
  final void Function(String name, List<Training> trainings)? editWorkout;

  const CreateWorkoutScreen({
    Key? key,
    this.workout,
    this.addWorkout,
    this.editWorkout,
  }) : super(key: key);

  @override
  State<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  final TextEditingController _controller = TextEditingController(
    text: WorkoutsConstants.workoutInitialName,
  );
  final List<Training> _trainings = [];
  bool hasChanged = false;

  Future<bool> _onWillPop() async {
    if (!hasChanged) {
      return true;
    }
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(GeneralConstants.dialogCloseWithoutSavingTitle),
            content: const Text(
              GeneralConstants.dialogCloseWithoutSavingContent,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  GeneralConstants.dialogGoBack,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  GeneralConstants.dialogDontSave,
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  void _addTraining(Exercise exercise) {
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
      selectedTextStyle: TextStyle(color: Theme.of(context).primaryColor),
      cancelTextStyle: TextStyle(color: Theme.of(context).primaryColor),
      confirmTextStyle: TextStyle(color: Theme.of(context).primaryColor),
      onConfirm: (Picker picker, List value) {
        setState(
          () => {
            _trainings.add(
              Training(
                exercise,
                picker.getSelectedValues()[0] as int,
                picker.getSelectedValues()[1] as int,
              ),
            ),
            hasChanged = true,
          },
        );
        Navigator.pop(context);
      },
    ).showDialog(context);
  }

  void _editTraining(int index) {
    Picker(
      adapter: NumberPickerAdapter(
        data: [
          NumberPickerColumn(
            begin: 1,
            end: 10,
            jump: 1,
            initValue: _trainings[index].numSets,
          ),
          NumberPickerColumn(
            begin: 1,
            end: 100,
            jump: 1,
            initValue: _trainings[index].numReps,
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
      selectedTextStyle: TextStyle(color: Theme.of(context).primaryColor),
      cancelTextStyle: TextStyle(color: Theme.of(context).primaryColor),
      confirmTextStyle: TextStyle(color: Theme.of(context).primaryColor),
      onConfirm: (Picker picker, List value) {
        setState(
          () => {
            _trainings[index] = Training(
              _trainings[index].exercise,
              picker.getSelectedValues()[0] as int,
              picker.getSelectedValues()[1] as int,
            ),
            hasChanged = true,
          },
        );
      },
    ).showDialog(context);
  }

  void _deleteTraining(int index) {
    setState(
      () => {
        _trainings.removeAt(index),
        hasChanged = true,
      },
    );
  }

  void _onPressSaveButton() async {
    if (_controller.text.isEmpty || _trainings.isEmpty) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            _controller.text.isEmpty
                ? WorkoutsConstants.dialogNoWorkoutNameTitle
                : WorkoutsConstants.dialogNoExercisesTitle,
          ),
          content: Text(
            _controller.text.isEmpty
                ? WorkoutsConstants.dialogNoWorkoutNameContent
                : WorkoutsConstants.dialogNoExercisesContent,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                GeneralConstants.dialogOk,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      if (widget.workout != null) {
        widget.editWorkout!(_controller.text, _trainings);
      } else {
        widget.addWorkout!(_controller.text, _trainings);
      }
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.workout != null) {
      _controller.text = widget.workout!.name;
      _trainings.addAll(widget.workout!.trainings);
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: BigText(
            text: widget.workout != null
                ? WorkoutsConstants.editWorkout
                : WorkoutsConstants.createWorkout,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: WorkoutsConstants.workoutNameHintText,
                  ),
                  onChanged: (text) {
                    setState(
                      () => hasChanged = true,
                    );
                  },
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 20.0,
                      bottom: 20.0,
                    ),
                    child: _trainings.isNotEmpty
                        ? ReorderableListView.builder(
                            itemCount: _trainings.length,
                            itemBuilder: (context, index) {
                              return Container(
                                key: Key(_trainings[index].exercise.name),
                                constraints: BoxConstraints(
                                  minHeight: Dimensions.cardMinHeight,
                                ),
                                child: TrainingCard(
                                  training: _trainings[index],
                                  editTraining: () {
                                    _editTraining(index);
                                  },
                                  deleteTraining: () {
                                    _deleteTraining(index);
                                  },
                                ),
                              );
                            },
                            onReorder: (int oldIndex, int newIndex) {
                              setState(() {
                                if (newIndex > oldIndex) {
                                  newIndex -= 1;
                                }
                                final Training item =
                                    _trainings.removeAt(oldIndex);
                                _trainings.insert(newIndex, item);
                                hasChanged = true;
                              });
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
                                  WorkoutsConstants.noExercisesText,
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
                    SecondaryButton(
                      text: WorkoutsConstants.addExercise,
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
                                      addTraining: (Exercise exercise) {
                                        _addTraining(exercise);
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
                    ),
                    MainButton(
                      text: GeneralConstants.save,
                      onPressed: _onPressSaveButton,
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
