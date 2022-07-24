import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Map<String, dynamic> transformSnapshot(Object? snapshot) =>
    jsonDecode(jsonEncode(snapshot));

String formatDate(DateTime? date) =>
    date == null ? "" : DateFormat("EEEE MMM d - hh:mm a").format(date);

String formatDuration(String duration) {
  final List<String> parts = duration.split(":");
  final int hours = int.parse(parts[0]);
  final int minutes = int.parse(parts[1]);
  final int seconds = int.parse(parts[2]);
  final int totalSeconds = hours * 3600 + minutes * 60 + seconds;
  final int hoursPart = totalSeconds ~/ 3600;
  final int minutesPart = (totalSeconds - hoursPart * 3600) ~/ 60;
  final int secondsPart = totalSeconds - hoursPart * 3600 - minutesPart * 60;
  return "${hoursPart != 0 ? "${hoursPart.toString()}hr " : ""}${minutesPart != 0 ? "${minutesPart.toString().padLeft(2)}min " : ""}${secondsPart.toString()}sec";
}

Color getFillColor(BuildContext context, Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return Colors.grey.withOpacity(0.3);
  }
  if (states.contains(MaterialState.selected)) {
    return Theme.of(context).primaryColor;
  }
  return Colors.grey;
}
