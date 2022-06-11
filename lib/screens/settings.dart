import 'package:flutter/material.dart';

import 'package:mygymbro/utils/localization.dart';
import 'package:mygymbro/models/language.dart';

class Settings extends StatefulWidget {
  final Language language;
  final void Function(String locale) changeLanguage;

  const Settings({
    Key? key,
    required this.language,
    required this.changeLanguage,
  }) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    "${getTranslated(context, "language")}:",
                    style: const TextStyle(fontSize: 15.0),
                  ),
                ),
                DropdownButton<Language>(
                  value: widget.language,
                  items: Language.languageList.map((Language language) {
                    return DropdownMenuItem<Language>(
                      value: language,
                      child: Text(getTranslated(context, language.name)),
                    );
                  }).toList(),
                  onChanged: (Language? value) {
                    widget.changeLanguage(value!.code);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
