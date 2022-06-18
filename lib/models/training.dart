import 'package:mygymbro/models/exercise.dart';

class Training {
  final Exercise exercise;
  final int numSets;
  final int numReps;

  Training(
    this.exercise,
    this.numSets,
    this.numReps,
  );
}
