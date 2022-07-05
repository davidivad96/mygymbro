import 'package:flutter/material.dart';

import 'package:mygymbro/widgets/big_text.dart';

class StartWorkoutScreen extends StatefulWidget {
  final String workoutName;

  const StartWorkoutScreen({Key? key, required this.workoutName})
      : super(key: key);

  @override
  State<StartWorkoutScreen> createState() => _StartWorkoutScreenState();
}

class _StartWorkoutScreenState extends State<StartWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(text: widget.workoutName),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 2.0,
      ),
      body: const Text("Start workout screen"),
    );
  }
}
