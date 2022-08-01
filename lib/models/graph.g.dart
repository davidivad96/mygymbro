// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graph.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      DateTime.parse(json['x'] as String),
      (json['y'] as num?)?.toDouble(),
      json['historyId'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'x': instance.x.toIso8601String(),
      'y': instance.y,
      'historyId': instance.historyId,
    };

Graph _$GraphFromJson(Map<String, dynamic> json) => Graph(
      Exercise.fromJson(json['exercise'] as Map<String, dynamic>),
      (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GraphToJson(Graph instance) => <String, dynamic>{
      'exercise': instance.exercise.toJson(),
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
