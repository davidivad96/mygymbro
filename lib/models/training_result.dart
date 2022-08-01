import 'package:json_annotation/json_annotation.dart';

import 'package:mygymbro/models/exercise.dart';

part 'training_result.g.dart';

@JsonSerializable()
class TrainingSet {
  double? kgs;
  int? reps;
  bool done = false;

  TrainingSet(this.kgs, this.reps);

  factory TrainingSet.fromJson(Map<String, dynamic> json) =>
      _$TrainingSetFromJson(json);

  Map<String, dynamic> toJson() => _$TrainingSetToJson(this);
}

@JsonSerializable()
class TrainingResult {
  final Exercise exercise;
  final List<TrainingSet> sets;
  String notes;
  String historyId;

  TrainingResult(this.exercise, this.sets, this.notes, this.historyId);

  factory TrainingResult.fromJson(Map<String, dynamic> json) =>
      _$TrainingResultFromJson(json);

  Map<String, dynamic> toJson() => _$TrainingResultToJson(this);
}
