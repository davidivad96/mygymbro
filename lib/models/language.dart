class Language {
  final String name;
  final String code;

  Language(this.name, this.code);

  static List<Language> languageList = [
    Language("spanish", "es"),
    Language("english", "en"),
  ];

  static Language defaultLanguage = languageList.first;
}
