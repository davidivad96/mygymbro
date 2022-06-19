import 'package:flutter/material.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/models/training.dart';
import 'package:mygymbro/utils/dimensions.dart';

class TrainingCard extends StatefulWidget {
  final Training training;
  final void Function() editTraining;
  final void Function() deleteTraining;

  const TrainingCard({
    Key? key,
    required this.training,
    required this.editTraining,
    required this.deleteTraining,
  }) : super(key: key);

  @override
  State<TrainingCard> createState() => _TrainingCardState();
}

class _TrainingCardState extends State<TrainingCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(Dimensions.cardPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.training.exercise.name,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PopupMenuButton(
                    onSelected: (value) {
                      if (value == WorkoutsConstants.delete) {
                        widget.deleteTraining();
                      }
                    },
                    child: const Icon(Icons.more_horiz),
                    itemBuilder: (context) => [
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.editTraining,
                    child: Text(
                      "${widget.training.numSets.toString()}x${widget.training.numReps.toString()}",
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
