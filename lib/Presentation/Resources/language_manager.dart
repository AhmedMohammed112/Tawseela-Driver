import 'dart:ui';

enum Languages { English, Spanish, Arabic }

const String ARABIC = "ar";
const String ENGLISH = "en";

Locale localEN = const Locale('en','US');
Locale localAR = const Locale('ar','SA');

String path = "assets/translations";

extension LanguagesExtension on Languages {
  String get getLanguage {
    switch (this) {
      case Languages.English:
        return ENGLISH;
      case Languages.Arabic:
        return ARABIC;
      default:
        return ENGLISH;
    }
  }
}