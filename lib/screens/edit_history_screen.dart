import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/models/history.dart';
import 'package:mygymbro/utils/dimensions.dart';
import 'package:mygymbro/utils/functions.dart';
import 'package:mygymbro/widgets/big_text.dart';
import 'package:mygymbro/widgets/main_button.dart';

class EditHistoryScreen extends StatefulWidget {
  final History history;
  final void Function() editHistory;

  const EditHistoryScreen({
    Key? key,
    required this.history,
    required this.editHistory,
  }) : super(key: key);

  @override
  State<EditHistoryScreen> createState() => _EditHistoryScreenState();
}

class _EditHistoryScreenState extends State<EditHistoryScreen> {
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

  bool _isCheckboxDisabled(int i, int j) {
    return widget.history.trainingResults[i].sets[j].kgs == null ||
        widget.history.trainingResults[i].sets[j].reps == null ||
        (j == 0
            ? false
            : widget.history.trainingResults[i].sets[j - 1].done == false);
  }

  void _onPressSaveButton() async {
    final bool noWorkDone = widget.history.trainingResults.every(
      (trainingResult) => trainingResult.sets.every((set) => set.done == false),
    );
    if (noWorkDone) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            WorkoutsConstants.dialogSaveTrainingNoWorkDoneTitle,
          ),
          content: const Text(
            WorkoutsConstants.dialogSaveTrainingNoWorkDoneContent,
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
          ],
        ),
      );
    } else {
      widget.editHistory();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Column(
            children: [
              BigText(text: widget.history.workoutName),
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "—",
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 2.0,
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const Divider(height: 5.0),
                  itemCount: widget.history.trainingResults.length,
                  itemBuilder: (context, trainingIndex) {
                    final training = widget.history.trainings[trainingIndex];
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
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "0.0",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r"^\d+\.?\d{0,3}"),
                                  ),
                                ],
                                initialValue: widget
                                    .history
                                    .trainingResults[trainingIndex]
                                    .sets[setIndex]
                                    .kgs
                                    ?.toString(),
                                onChanged: (value) {
                                  setState(() {
                                    if (value == "") {
                                      widget
                                          .history
                                          .trainingResults[trainingIndex]
                                          .sets[setIndex]
                                          .kgs = null;
                                    } else {
                                      widget
                                          .history
                                          .trainingResults[trainingIndex]
                                          .sets[setIndex]
                                          .kgs = double.parse(value);
                                    }
                                    hasChanged = true;
                                  });
                                },
                              ),
                            ),
                            Center(
                              child: TextFormField(
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
                                initialValue: widget
                                    .history
                                    .trainingResults[trainingIndex]
                                    .sets[setIndex]
                                    .reps
                                    ?.toString(),
                                onChanged: (value) {
                                  setState(() {
                                    if (value == "") {
                                      widget
                                          .history
                                          .trainingResults[trainingIndex]
                                          .sets[setIndex]
                                          .reps = null;
                                    } else {
                                      widget
                                          .history
                                          .trainingResults[trainingIndex]
                                          .sets[setIndex]
                                          .reps = int.parse(value);
                                    }
                                    hasChanged = true;
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
                                value: widget
                                    .history
                                    .trainingResults[trainingIndex]
                                    .sets[setIndex]
                                    .done,
                                onChanged: _isCheckboxDisabled(
                                  trainingIndex,
                                  setIndex,
                                )
                                    ? null
                                    : (bool? value) {
                                        setState(() {
                                          widget
                                              .history
                                              .trainingResults[trainingIndex]
                                              .sets[setIndex]
                                              .done = value!;
                                          if (value == false) {
                                            for (int i = setIndex;
                                                i <
                                                    widget
                                                        .history
                                                        .trainingResults[
                                                            trainingIndex]
                                                        .sets
                                                        .length;
                                                i++) {
                                              widget
                                                  .history
                                                  .trainingResults[
                                                      trainingIndex]
                                                  .sets[i]
                                                  .done = false;
                                            }
                                          }
                                          hasChanged = true;
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
                                margin: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 20.0,
                                ),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'Add notes...',
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  onChanged: (value) {
                                    setState(() {
                                      widget
                                          .history
                                          .trainingResults[trainingIndex]
                                          .notes = value;
                                      hasChanged = true;
                                    });
                                  },
                                  initialValue: widget.history
                                      .trainingResults[trainingIndex].notes,
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
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.screenPaddingHorizontal,
                  right: Dimensions.screenPaddingHorizontal,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: MainButton(
                        text: GeneralConstants.save,
                        onPressed: _onPressSaveButton,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
