import 'package:json_annotation/json_annotation.dart';

import 'package:mygymbro/models/training.dart';

part 'workout.g.dart';

@JsonSerializable()
class Workout {
  final String id;
  final String name;
  final List<Training> trainings;

  Workout(
    this.id,
    this.name,
    this.trainings,
  );

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutToJson(this);
}
