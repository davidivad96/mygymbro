import 'package:json_annotation/json_annotation.dart';

import 'package:mygymbro/models/training.dart';
import 'package:mygymbro/models/training_result.dart';

part 'history.g.dart';

@JsonSerializable()
class History {
  final String id;
  final String workoutName;
  final int duration;
  final String date;
  final List<Training> trainings;
  List<TrainingResult> trainingResults;

  History(
    this.id,
    this.workoutName,
    this.duration,
    this.date,
    this.trainings,
    this.trainingResults,
  );

  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryToJson(this);
}
