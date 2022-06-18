import 'package:flutter/material.dart';

import 'package:mygymbro/constants.dart';
import 'package:mygymbro/data/exercises.dart';
import 'package:mygymbro/models/exercise.dart';
import 'package:mygymbro/utils/dimensions.dart';

class ExercisesSearch extends StatefulWidget {
  const ExercisesSearch({Key? key}) : super(key: key);

  @override
  State<ExercisesSearch> createState() => _ExercisesSearchState();
}

class _ExercisesSearchState extends State<ExercisesSearch> {
  final TextEditingController _controller = TextEditingController();
  late List<Exercise> _exerciseList = [];
  late List<Exercise> _filteredExerciseList = [];
  late List<Exercise> _finalExerciseList = [];
  late String _targetArea = ExercisesConstants.anyTarget;

  _setTargetArea(String area) {
    setState(() {
      _targetArea = area;
      _filteredExerciseList = _exerciseList
          .where(
            (Exercise exercise) =>
                exercise.targetArea == _targetArea ||
                _targetArea == ExercisesConstants.anyTarget,
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
    return Expanded(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: Dimensions.searchInputMarginBottom,
            ),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: ExercisesConstants.search,
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return Wrap(
                          children: [
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
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: _getTargetButton(
                                              ExercisesConstants.anyTarget,
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: _getTargetButton(
                                              ExercisesConstants.abs,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: _getTargetButton(
                                              ExercisesConstants.arms,
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: _getTargetButton(
                                              ExercisesConstants.back,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: _getTargetButton(
                                              ExercisesConstants.cardio,
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: _getTargetButton(
                                              ExercisesConstants.chest,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: _getTargetButton(
                                              ExercisesConstants.legs,
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: _getTargetButton(
                                              ExercisesConstants.shoulders,
                                            ),
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