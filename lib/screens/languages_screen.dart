import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import 'package:mygymbro/models/language.dart';
import 'package:mygymbro/widgets/custom_app_bar.dart';
import 'package:mygymbro/utils/localization.dart';

class LanguagesScreen extends StatefulWidget {
  final Language language;
  final void Function(String locale) changeLanguage;

  const LanguagesScreen({
    Key? key,
    required this.language,
    required this.changeLanguage,
  }) : super(key: key);

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
              ),
              child: Text(
                getTranslated(context, "language"),
                style: const TextStyle(
                  fontSize: 20.0,
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
                    tiles: Language.languageList.map((Language language) {
                      return SettingsTile(
                        title: Text(getTranslated(context, language.name)),
                        trailing: language.code == widget.language.code
                            ? Icon(
                                Icons.check,
                                color: Theme.of(context).primaryColor,
                              )
                            : null,
                        onPressed: (BuildContext context) {
                          widget.changeLanguage(language.code);
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
