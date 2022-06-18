import 'package:mygymbro/models/training.dart';

class Workout {
  final String name;
  final List<Training> trainings;

  Workout(
    this.name,
    this.trainings,
  );
}
