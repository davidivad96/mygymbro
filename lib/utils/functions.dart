import 'dart:convert';

Map<String, dynamic> transformSnapshot(Object? snapshot) =>
    jsonDecode(jsonEncode(snapshot));
