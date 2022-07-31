import 'package:json_annotation/json_annotation.dart';

import 'package:mygymbro/models/exercise.dart';

part 'graph.g.dart';

@JsonSerializable()
class Data {
  final DateTime x;
  final double? y;

  Data(this.x, this.y);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Graph {
  final Exercise exercise;
  final List<Data> data;

  Graph(this.exercise, this.data);

  factory Graph.fromJson(Map<String, dynamic> json) => _$GraphFromJson(json);

  Map<String, dynamic> toJson() => _$GraphToJson(this);
}
