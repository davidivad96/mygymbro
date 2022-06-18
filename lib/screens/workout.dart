import 'package:flutter/material.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/utils/dimensions.dart';

class Workout extends StatelessWidget {
  const Workout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("hello: ${Dimensions.height} ${Dimensions.width}");
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Dimensions.screenPaddingHorizontal,
        Dimensions.screenPaddingVertical,
        Dimensions.screenPaddingHorizontal,
        Dimensions.screenPaddingVertical,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: Dimensions.screenTitleMarginBottom),
            child: const Text(
              WorkoutConstants.title,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 1.0,
              ),
              scrollDirection: Axis.vertical,
              children: const [
                Card(
                  color: Colors.blue,
                  child: Center(child: Text("Workout 1")),
                ),
                Card(
                  color: Colors.red,
                  child: Center(child: Text("Workout 2")),
                ),
                Card(
                  color: Colors.green,
                  child: Center(child: Text("Workout 3")),
                ),
                Card(
                  color: Colors.orange,
                  child: Center(child: Text("Workout 4")),
                ),
                Card(
                  color: Color(0xFFF5F5F5),
                  child: Icon(Icons.add, size: 35.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
