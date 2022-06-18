import 'package:flutter/material.dart';

import 'package:mygymbro/models/training.dart';
import 'package:mygymbro/utils/dimensions.dart';

class TrainingCard extends StatelessWidget {
  final Training training;

  const TrainingCard({Key? key, required this.training}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(Dimensions.cardPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  training.exercise.name,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  child: const Icon(Icons.more_horiz),
                  onTap: () {},
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Num sets: ${training.numSets}"),
                Text("Num reps: ${training.numReps}"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
