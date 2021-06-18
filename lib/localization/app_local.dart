import 'dart:async';

import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/dictionary.dart';
import 'package:testgsschoolst/main.dart';
// import 'package:businessy/localization/dictionare.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  var _localizedStrings;

  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder

    _localizedStrings = LOCALE_TRANSLATE_MAP.map((key, value) {
      return MapEntry(key, value[locale.languageCode].toString());
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    return _localizedStrings[key];
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'ar', 'ku', 'pa', 'tr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

//Todo call this
//for alerts dont pass context
// for screens must pass context
String translateFun(String str, {BuildContext context}) {
  if (context != null) {
    return AppLocalizations.of(context).translate("$str");
  } else {
    return AppLocalizations.of(navigatorKey.currentContext).translate("$str");
  }
}
