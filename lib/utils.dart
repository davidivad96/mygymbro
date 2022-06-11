import 'package:flutter/material.dart';

import 'package:mygymbro/localization/app_localization.dart';

String getTranslated(BuildContext context, String key) {
  return AppLocalization.of(context).getTranslatedValue(key);
}

Locale mapLanguageToLocale(String language) {
  switch (language) {
    case "Spanish":
      return const Locale("es");
    case "English":
      return const Locale("en");
    default:
      return const Locale("es");
  }
}
