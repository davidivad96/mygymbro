import 'package:flutter/material.dart';

import 'package:mygymbro/models/exercise.dart';
import 'package:mygymbro/utils/localization.dart';

class Exercises extends StatefulWidget {
  final List<Exercise> finalExerciseList;
  final String targetArea;
  final void Function(String area) setTargetArea;
  final void Function(String query) onSearchChanged;

  const Exercises({
    Key? key,
    required this.finalExerciseList,
    required this.targetArea,
    required this.setTargetArea,
    required this.onSearchChanged,
  }) : super(key: key);

  @override
  State<Exercises> createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    widget.onSearchChanged("");
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
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.search),
                hintText: getTranslated(context, "search"),
              ),
              onChanged: widget.onSearchChanged,
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
                                            child: TargetButton(
                                              widget: widget,
                                              controller: _controller,
                                              text: "Any target",
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: TargetButton(
                                              widget: widget,
                                              controller: _controller,
                                              text: "Arms",
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TargetButton(
                                              widget: widget,
                                              controller: _controller,
                                              text: "Abs",
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: TargetButton(
                                              widget: widget,
                                              controller: _controller,
                                              text: "Back",
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TargetButton(
                                              widget: widget,
                                              controller: _controller,
                                              text: "Cardio",
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: TargetButton(
                                              widget: widget,
                                              controller: _controller,
                                              text: "Chest",
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TargetButton(
                                              widget: widget,
                                              controller: _controller,
                                              text: "Legs",
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: TargetButton(
                                              widget: widget,
                                              controller: _controller,
                                              text: "Shoulders",
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
                  child: Text(widget.targetArea),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.finalExerciseList.length,
              itemBuilder: (context, index) {
                final exercise = widget.finalExerciseList[index];
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

class TargetButton extends StatelessWidget {
  const TargetButton({
    Key? key,
    required this.widget,
    required TextEditingController controller,
    required this.text,
  })  : _controller = controller,
        super(key: key);

  final Exercises widget;
  final TextEditingController _controller;
  final String text;

  @override
  Widget build(BuildContext context) {
    if (text == widget.targetArea) {
      return ElevatedButton(
        child: Text(text),
        onPressed: () {
          widget.setTargetArea(text);
          _controller.clear();
          Navigator.of(context).pop();
        },
      );
    }
    return OutlinedButton(
      child: Text(text),
      onPressed: () {
        widget.setTargetArea(text);
        _controller.clear();
        Navigator.of(context).pop();
      },
    );
  }
}
