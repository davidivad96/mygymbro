import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/models/history.dart';
import 'package:mygymbro/utils/dimensions.dart';
import 'package:mygymbro/utils/functions.dart';

class HistoryCard extends StatefulWidget {
  final History history;
  final void Function() onSelectDeleteHistory;

  const HistoryCard({
    Key? key,
    required this.history,
    required this.onSelectDeleteHistory,
  }) : super(key: key);

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
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
                    widget.history.workoutName,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    if (value == GeneralConstants.edit) {
                    } else if (value == GeneralConstants.delete) {
                      widget.onSelectDeleteHistory();
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
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text(
                widget.history.date,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[500],
                ),
              ),
              subtitle: Text(
                "Duration: ${formatDuration(widget.history.duration)}",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[500],
                ),
              ),
              iconColor: Theme.of(context).primaryColor,
              children: [
                const Divider(
                  height: 30.0,
                  color: Colors.grey,
                ),
                for (int i = 0; i < widget.history.trainingResults.length; i++)
                  if (widget.history.trainingResults[i].sets
                      .any((set) => set.done == true))
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          widget.history.trainingResults[i].exercise.name,
                          style: const TextStyle(fontSize: 17.0),
                        ),
                        const SizedBox(height: 6.0),
                        if (widget.history.trainingResults[i].notes != "") ...[
                          Text(
                            widget.history.trainingResults[i].notes,
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                        ],
                        for (int j = 0;
                            j < widget.history.trainingResults[i].sets.length;
                            j++)
                          if (widget.history.trainingResults[i].sets[j].done)
                            Row(
                              children: [
                                Badge(
                                  badgeColor: Theme.of(context).primaryColor,
                                  badgeContent: Text(
                                    (j + 1).toString(),
                                    style: TextStyle(
                                      color: Theme.of(context).highlightColor,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6.0),
                                Text(
                                  "${widget.history.trainingResults[i].sets[j].reps} reps x ${widget.history.trainingResults[i].sets[j].kgs} kgs",
                                ),
                              ],
                            ),
                        const SizedBox(height: 15.0),
                      ],
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
