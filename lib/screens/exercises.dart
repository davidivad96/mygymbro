import 'package:flutter/material.dart';

import 'package:mygymbro/data/exercises.dart';
import 'package:mygymbro/models/exercise.dart';
import 'package:mygymbro/utils/localization.dart';

class Exercises extends StatefulWidget {
  const Exercises({Key? key}) : super(key: key);

  @override
  State<Exercises> createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  late List<Exercise> exerciseList = [];
  late List<Exercise> filteredExerciseList = [];

  final TextEditingController _controller = TextEditingController();

  _onSearchChanged(String query) {
    setState(() {
      filteredExerciseList = exerciseList
          .where(
            (Exercise exercise) =>
                exercise.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    exerciseList = exercises;
    exerciseList.sort((a, b) => a.name.compareTo(b.name));
    filteredExerciseList = exerciseList;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            getTranslated(context, "exercises"),
            style: const TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredExerciseList.length,
              itemBuilder: (context, index) {
                final exercise = filteredExerciseList[index];
                return ListTile(
                  title: Text(exercise.name),
                  subtitle: Text(exercise.bodyArea),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
