import 'package:json_annotation/json_annotation.dart';

import 'package:mygymbro/models/exercise.dart';

part 'training.g.dart';

@JsonSerializable()
class Training {
  final Exercise exercise;
  final int numSets;
  final int numReps;

  Training(
    this.exercise,
    this.numSets,
    this.numReps,
  );

  factory Training.fromJson(Map<String, dynamic> json) =>
      _$TrainingFromJson(json);

  Map<String, dynamic> toJson() => _$TrainingToJson(this);
}
