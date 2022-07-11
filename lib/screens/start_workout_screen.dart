import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'package:mygymbro/models/training.dart';
import 'package:mygymbro/models/training_result.dart';
import 'package:mygymbro/utils/dimensions.dart';
import 'package:mygymbro/widgets/big_text.dart';

class StartWorkoutScreen extends StatefulWidget {
  final String workoutName;
  final List<Training> trainings;

  const StartWorkoutScreen({
    Key? key,
    required this.workoutName,
    required this.trainings,
  }) : super(key: key);

  @override
  State<StartWorkoutScreen> createState() => _StartWorkoutScreenState();
}

class _StartWorkoutScreenState extends State<StartWorkoutScreen> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );
  late final List<TrainingResult> _trainingResults = List.generate(
    widget.trainings.length,
    (i) => TrainingResult(
      widget.trainings[i].exercise,
      List.generate(
        widget.trainings[i].numSets,
        (_) => TrainingSet(),
      ),
    ),
  );

  Color _getFillColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return Colors.grey;
    }
    return Theme.of(context).primaryColor;
  }

  bool _isCheckboxDisabled(int i, int j) {
    return _trainingResults[i].sets[j].kgs == null ||
        _trainingResults[i].sets[j].reps == null;
  }

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Column(
          children: [
            BigText(text: widget.workoutName),
            StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: _stopWatchTimer.rawTime.value,
              builder: (context, snap) {
                final value = snap.data!;
                final displayTime = StopWatchTimer.getDisplayTime(
                  value,
                  hours: false,
                  minute: true,
                  second: true,
                  milliSecond: false,
                );
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        displayTime,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 2.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => {},
          ),
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          height: 15.0,
          color: Colors.transparent,
        ),
        itemCount: widget.trainings.length,
        itemBuilder: (context, trainingIndex) {
          final training = widget.trainings[trainingIndex];
          final exercise = training.exercise;
          final numSets = training.numSets;
          final numReps = training.numReps;
          var tableRows = <TableRow>[];
          for (var setIndex = 0; setIndex < numSets; setIndex++) {
            tableRows.add(
              TableRow(
                children: [
                  Center(
                    child: Text(
                      '${setIndex + 1}',
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "0.0",
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r"^\d+\.?\d{0,3}"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          if (value == "") {
                            _trainingResults[trainingIndex].sets[setIndex].kgs =
                                null;
                          } else {
                            _trainingResults[trainingIndex].sets[setIndex].kgs =
                                double.parse(value);
                          }
                        });
                      },
                    ),
                  ),
                  Center(
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: numReps.toString(),
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        setState(() {
                          if (value == "") {
                            _trainingResults[trainingIndex]
                                .sets[setIndex]
                                .reps = null;
                          } else {
                            _trainingResults[trainingIndex]
                                .sets[setIndex]
                                .reps = int.parse(value);
                          }
                        });
                      },
                    ),
                  ),
                  Center(
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      fillColor:
                          MaterialStateProperty.resolveWith(_getFillColor),
                      value:
                          _trainingResults[trainingIndex].sets[setIndex].done,
                      onChanged: _isCheckboxDisabled(trainingIndex, setIndex)
                          ? null
                          : (bool? value) {
                              setState(() {
                                _trainingResults[trainingIndex]
                                    .sets[setIndex]
                                    .done = value!;
                              });
                            },
                    ),
                  ),
                ],
              ),
            );
          }
          return Material(
            color: Theme.of(context).backgroundColor,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(Dimensions.cardPadding),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        exercise.name,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Add notes...',
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onChanged: (value) {
                          setState(() {
                            _trainingResults[trainingIndex].notes = value;
                          });
                        },
                      ),
                    ),
                    Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        const TableRow(
                          children: [
                            Center(
                              child: Text(
                                'SET',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'KGS',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'REPS',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'DONE',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ...tableRows,
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      ),
    );
  }
}
