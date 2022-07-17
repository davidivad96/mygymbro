// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) => Workout(
      json['id'] as String,
      json['name'] as String,
      (json['trainings'] as List<dynamic>)
          .map((e) => Training.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'trainings': instance.trainings.map((e) => e.toJson()).toList(),
    };
