import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/models/training.dart';
import 'package:mygymbro/models/training_result.dart';
import 'package:mygymbro/utils/dimensions.dart';
import 'package:mygymbro/utils/functions.dart';
import 'package:mygymbro/widgets/big_text.dart';

class StartWorkoutScreen extends StatefulWidget {
  final String workoutName;
  final List<Training> trainings;
  final void Function(
    String workoutName,
    int duration,
    String date,
    List<Training> trainings,
    List<TrainingResult> trainingResults,
  ) addHistory;

  const StartWorkoutScreen({
    Key? key,
    required this.workoutName,
    required this.trainings,
    required this.addHistory,
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
        (_) => TrainingSet(null, null),
      ),
      "",
    ),
  );

  bool _isCheckboxDisabled(int i, int j) {
    return _trainingResults[i].sets[j].kgs == null ||
        _trainingResults[i].sets[j].reps == null ||
        (j == 0 ? false : _trainingResults[i].sets[j - 1].done == false);
  }

  void _onDiscard() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(WorkoutsConstants.dialogDiscardTrainingTitle),
        content: const Text(
          WorkoutsConstants.dialogDiscardTrainingContent,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              GeneralConstants.dialogGoBack,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.popUntil(
              context,
              (route) => route.isFirst,
            ),
            child: Text(
              GeneralConstants.dialogDiscard,
              style: TextStyle(
                color: Theme.of(context).errorColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSave() async {
    final bool noWorkDone = _trainingResults.every(
      (trainingResult) => trainingResult.sets.every((set) => set.done == false),
    );
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          noWorkDone
              ? WorkoutsConstants.dialogSaveTrainingNoWorkDoneTitle
              : WorkoutsConstants.dialogSaveTrainingTitle,
        ),
        content: Text(
          noWorkDone
              ? WorkoutsConstants.dialogSaveTrainingNoWorkDoneContent
              : WorkoutsConstants.dialogSaveTrainingContent,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              GeneralConstants.dialogGoBack,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          if (!noWorkDone)
            TextButton(
              onPressed: () {
                widget.addHistory(
                  widget.workoutName,
                  int.parse(
                    StopWatchTimer.getDisplayTime(
                      _stopWatchTimer.rawTime.value,
                      hours: false,
                      minute: false,
                      second: true,
                      milliSecond: false,
                    ),
                  ),
                  formatDate(DateTime.now()),
                  widget.trainings,
                  _trainingResults,
                );
                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                );
              },
              child: Text(
                GeneralConstants.dialogFinished,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  _disposeStopWatchTimer() async {
    await _stopWatchTimer.dispose();
  }

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  @override
  void dispose() async {
    _disposeStopWatchTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _onDiscard,
        ),
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
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    displayTime,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
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
            onPressed: _onSave,
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(height: 5.0),
          itemCount: widget.trainings.length,
          itemBuilder: (context, trainingIndex) {
            final training = widget.trainings[trainingIndex];
            final exercise = training.exercise;
            final numSets = training.numSets;
            final numReps = training.numReps;
            final tableRows = <TableRow>[];
            for (int setIndex = 0; setIndex < numSets; setIndex++) {
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
                              _trainingResults[trainingIndex]
                                  .sets[setIndex]
                                  .kgs = null;
                            } else {
                              _trainingResults[trainingIndex]
                                  .sets[setIndex]
                                  .kgs = double.parse(value);
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
                        fillColor: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> state) => getFillColor(
                            context,
                            state,
                          ),
                        ),
                        value:
                            _trainingResults[trainingIndex].sets[setIndex].done,
                        onChanged: _isCheckboxDisabled(trainingIndex, setIndex)
                            ? null
                            : (bool? value) {
                                setState(() {
                                  _trainingResults[trainingIndex]
                                      .sets[setIndex]
                                      .done = value!;
                                  if (value == false) {
                                    for (int i = setIndex;
                                        i <
                                            _trainingResults[trainingIndex]
                                                .sets
                                                .length;
                                        i++) {
                                      _trainingResults[trainingIndex]
                                          .sets[i]
                                          .done = false;
                                    }
                                  }
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
      ),
    );
  }
}
