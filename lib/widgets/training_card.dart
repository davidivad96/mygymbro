import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/models/training.dart';
import 'package:mygymbro/utils/dimensions.dart';

class TrainingCard extends StatelessWidget {
  final Training training;

  const TrainingCard({Key? key, required this.training}) : super(key: key);

  /* _showPickerNumber(BuildContext context) {
    Picker(
      adapter: NumberPickerAdapter(
        data: [
          const NumberPickerColumn(begin: 1, end: 10, jump: 1),
        ],
      ),
      hideHeader: true,
      title: const Text("Please Select"),
      selectedTextStyle: const TextStyle(color: Colors.blue),
      onConfirm: (Picker picker, List value) {
        print(value.toString());
        print(picker.getSelectedValues());
      },
    ).showDialog(context);
  } */

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
            /* Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          right: 10.0,
                        ),
                        child: const Text(
                          ExercisesConstants.numSets,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                          _showPickerNumber(context);
                        },
                        child: Icon(Icons.abc),
                          ),
                    ],
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          right: 10.0,
                        ),
                        child: const Text(
                          ExercisesConstants.numReps,
                        ),
                      ),
                       GestureDetector(
                          onTap: () {
                          _showPickerNumber(context);
                        },
                        child: Icon(Icons.abc),
                          ),
                    ],
                  ),
                ),
              ],
            ) */
          ],
        ),
      ),
    );
  }
}
