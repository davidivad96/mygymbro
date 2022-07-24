import 'package:flutter/material.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/models/history.dart';
import 'package:mygymbro/models/training_result.dart';
import 'package:mygymbro/utils/dimensions.dart';
import 'package:mygymbro/widgets/big_text.dart';
import 'package:mygymbro/widgets/history_card.dart';

class HistoryScreen extends StatefulWidget {
  final List<History> history;
  final void Function(
    String id,
    List<TrainingResult> trainingResults,
  ) updateHistory;
  final void Function(String id) removeHistory;

  const HistoryScreen({
    Key? key,
    required this.history,
    required this.updateHistory,
    required this.removeHistory,
  }) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  void _onSelectEditHistory(
    String id,
    List<TrainingResult> trainingResults,
  ) {
    widget.updateHistory(
      id,
      trainingResults,
    );
  }

  void _onSelectDeleteHistory(String id) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(HistoryConstants.dialogDeleteTrainingTitle),
        content: const Text(
          HistoryConstants.dialogDeleteTrainingContent,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              GeneralConstants.dialogNo,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              widget.removeHistory(id);
              Navigator.pop(context);
            },
            child: Text(
              GeneralConstants.dialogYes,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: Dimensions.screenTitleMarginBottom),
            child: const Text(
              HistoryConstants.title,
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: widget.history.isNotEmpty
                ? ListView.builder(
                    itemCount: widget.history.length,
                    itemBuilder: (BuildContext context, int index) {
                      History history = widget.history[index];
                      return Container(
                        key: Key(history.id),
                        constraints: BoxConstraints(
                          minHeight: Dimensions.cardMinHeight,
                        ),
                        child: HistoryCard(
                          history: history,
                          onSelectEditHistory: () => _onSelectEditHistory(
                            history.id,
                            history.trainingResults,
                          ),
                          onSelectDeleteHistory: () =>
                              _onSelectDeleteHistory(history.id),
                        ),
                      );
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
                            text: HistoryConstants.noHistoryTitle,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            HistoryConstants.noHistoryText,
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
    );
  }
}
