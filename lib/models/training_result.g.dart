// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrainingSet _$TrainingSetFromJson(Map<String, dynamic> json) => TrainingSet(
      (json['kgs'] as num?)?.toDouble(),
      json['reps'] as int?,
    )..done = json['done'] as bool;

Map<String, dynamic> _$TrainingSetToJson(TrainingSet instance) =>
    <String, dynamic>{
      'kgs': instance.kgs,
      'reps': instance.reps,
      'done': instance.done,
    };

TrainingResult _$TrainingResultFromJson(Map<String, dynamic> json) =>
    TrainingResult(
      Exercise.fromJson(json['exercise'] as Map<String, dynamic>),
      (json['sets'] as List<dynamic>)
          .map((e) => TrainingSet.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['notes'] as String,
    );

Map<String, dynamic> _$TrainingResultToJson(TrainingResult instance) =>
    <String, dynamic>{
      'exercise': instance.exercise.toJson(),
      'sets': instance.sets.map((e) => e.toJson()).toList(),
      'notes': instance.notes,
    };
