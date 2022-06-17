import 'package:flutter/material.dart';

import 'package:mygymbro/constants.dart';

class Workout extends StatelessWidget {
  const Workout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            WorkoutConstants.title,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
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
