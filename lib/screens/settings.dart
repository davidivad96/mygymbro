import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import 'package:mygymbro/main.dart';
import 'package:mygymbro/screens/languages.dart';
import 'package:mygymbro/utils/localization.dart';
import 'package:mygymbro/models/language.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Language _language = Language.defaultLanguage;

  @override
  void initState() {
    super.initState();
    getLocale().then((locale) {
      setState(() {
        _language = getLanguage(locale);
      });
    });
  }

  void _changeLanguage(String locale) async {
    setState(() {
      _language = getLanguage(locale);
    });
    MyApp.setLocale(context, locale);
    await setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
            left: 25.0,
            right: 25.0,
          ),
          child: Text(
            getTranslated(context, "settings"),
            style: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: SettingsList(
            lightTheme: SettingsThemeData(
              settingsListBackground: Theme.of(context).backgroundColor,
            ),
            sections: [
              SettingsSection(
                title: Text(getTranslated(context, "preferences")),
                tiles: [
                  SettingsTile.navigation(
                    title: Text(getTranslated(context, "language")),
                    value: Text(
                      getTranslated(context, _language.name),
                    ),
                    leading: const Icon(Icons.language),
                    onPressed: (BuildContext context) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Languages(
                            language: _language,
                            changeLanguage: _changeLanguage,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
