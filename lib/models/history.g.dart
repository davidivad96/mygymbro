// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

History _$HistoryFromJson(Map<String, dynamic> json) => History(
      json['id'] as String,
      json['workoutName'] as String,
      json['duration'] as String,
      json['date'] as String,
      (json['trainings'] as List<dynamic>)
          .map((e) => Training.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['trainingResults'] as List<dynamic>)
          .map((e) => TrainingResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['workoutId'] as String,
    );

Map<String, dynamic> _$HistoryToJson(History instance) => <String, dynamic>{
      'id': instance.id,
      'workoutName': instance.workoutName,
      'duration': instance.duration,
      'date': instance.date,
      'trainings': instance.trainings.map((e) => e.toJson()).toList(),
      'trainingResults':
          instance.trainingResults.map((e) => e.toJson()).toList(),
      'workoutId': instance.workoutId,
    };
