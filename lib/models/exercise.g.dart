// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
      json['id'] as String,
      json['name'] as String,
      json['description'] as String,
      json['targetArea'] as String,
      $enumDecode(_$ExerciseTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'targetArea': instance.targetArea,
      'type': _$ExerciseTypeEnumMap[instance.type]!,
    };

const _$ExerciseTypeEnumMap = {
  ExerciseType.weight: 'weight',
  ExerciseType.duration: 'duration',
  ExerciseType.distance: 'distance',
};
