import 'package:flutter/material.dart';

class StartWorkoutScreen extends StatefulWidget {
  const StartWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<StartWorkoutScreen> createState() => _StartWorkoutScreenState();
}

class _StartWorkoutScreenState extends State<StartWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "hello",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 2.0,
      ),
      body: const Text("Start workout screen"),
    );
  }
}
