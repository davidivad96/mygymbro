import 'package:json_annotation/json_annotation.dart';

part 'exercise.g.dart';

enum ExerciseType {
  weight,
  duration,
  distance,
}

@JsonSerializable()
class Exercise {
  final String id;
  final String name;
  final String description;
  final String targetArea;
  final ExerciseType type;

  Exercise(this.id, this.name, this.description, this.targetArea, this.type);

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}
