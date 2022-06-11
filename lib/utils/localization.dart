import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mygymbro/localization/app_localization.dart';
import 'package:mygymbro/models/language.dart';

String getTranslated(BuildContext context, String key) {
  return AppLocalization.of(context).getTranslatedValue(key);
}

const String locale = "locale";
const String defaultLocale = "es";

Future<String> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(locale) ?? defaultLocale;
}

Future<bool> setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString(locale, languageCode);
}

Language getLanguage(String languageCode) =>
    Language.languageList.firstWhere((element) => element.code == languageCode);
