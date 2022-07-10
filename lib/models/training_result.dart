import 'package:mygymbro/models/exercise.dart';

class TrainingSet {
  double? kgs;
  int? reps;
  bool done = false;

  TrainingSet();
}

class TrainingResult {
  final Exercise exercise;
  final List<TrainingSet> sets;
  String notes = "";

  TrainingResult(this.exercise, this.sets);
}
