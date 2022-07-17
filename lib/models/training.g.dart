// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Training _$TrainingFromJson(Map<String, dynamic> json) => Training(
      Exercise.fromJson(json['exercise'] as Map<String, dynamic>),
      json['numSets'] as int,
      json['numReps'] as int,
    );

Map<String, dynamic> _$TrainingToJson(Training instance) => <String, dynamic>{
      'exercise': instance.exercise.toJson(),
      'numSets': instance.numSets,
      'numReps': instance.numReps,
    };
