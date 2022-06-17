import 'package:flutter/material.dart';

import 'package:mygymbro/data/exercises.dart';
import 'package:mygymbro/models/exercise.dart';

class Exercises extends StatefulWidget {
  const Exercises({Key? key}) : super(key: key);

  @override
  State<Exercises> createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  final TextEditingController _controller = TextEditingController();
  late List<Exercise> _exerciseList = [];
  late List<Exercise> _filteredExerciseList = [];
  late List<Exercise> _finalExerciseList = [];
  late String _targetArea = "Any target";

  _setTargetArea(String area) {
    setState(() {
      _targetArea = area;
      _filteredExerciseList = _exerciseList
          .where(
            (Exercise exercise) =>
                exercise.targetArea == _targetArea ||
                _targetArea == "Any target",
          )
          .toList();
      _finalExerciseList = _filteredExerciseList;
    });
  }

  _onSearchChanged(String query) {
    setState(() {
      _finalExerciseList = _filteredExerciseList
          .where(
            (Exercise exercise) =>
                exercise.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  _getTargetButton(String text) {
    if (text == _targetArea) {
      return ElevatedButton(
        child: Text(text),
        onPressed: () {
          _setTargetArea(text);
          _controller.clear();
          Navigator.of(context).pop();
        },
      );
    }
    return OutlinedButton(
      child: Text(text),
      onPressed: () {
        _setTargetArea(text);
        _controller.clear();
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _exerciseList = exercises;
      _exerciseList.sort((a, b) => a.name.compareTo(b.name));
      _finalExerciseList = _filteredExerciseList = _exerciseList;
    });
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
          const Text(
            "Exercises",
            style: TextStyle(
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
                hintText: "Search",
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          // Button to add new exercise
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    showModalBottomSheet<void>(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return Wrap(
                          children: <Widget>[
                            Container(
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).highlightColor,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    20.0,
                                    20.0,
                                    20.0,
                                    30.0,
                                  ),
                                  child: Wrap(
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Expanded(
                                            child:
                                                _getTargetButton("Any target"),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: _getTargetButton("Abs"),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: _getTargetButton("Arms"),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: _getTargetButton("Back"),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: _getTargetButton("Cardio"),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: _getTargetButton("Chest"),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: _getTargetButton("Legs"),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child:
                                                _getTargetButton("Shoulders"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: Text(_targetArea),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _finalExerciseList.length,
              itemBuilder: (context, index) {
                final exercise = _finalExerciseList[index];
                return ListTile(
                  title: Text(exercise.name),
                  subtitle: Text(exercise.targetArea),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
