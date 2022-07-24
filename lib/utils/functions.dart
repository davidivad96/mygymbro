import 'dart:convert';
import 'package:intl/intl.dart';

Map<String, dynamic> transformSnapshot(Object? snapshot) =>
    jsonDecode(jsonEncode(snapshot));

String formatDate(DateTime? date) =>
    date == null ? "" : DateFormat("EEEE MMM d - hh:mm a").format(date);

String formatDuration(int duration) {
  if (duration >= 3600) {
    return "${(duration / 3600).floor()}h ${(duration % 3600) ~/ 60}m ${duration % 60}s";
  } else if (duration >= 60) {
    return "${(duration ~/ 60).floor()}m ${duration % 60}s";
  } else {
    return "${duration}s";
  }
}
