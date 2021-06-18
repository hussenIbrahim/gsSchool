import 'package:flutter/material.dart';
import 'package:testgsschoolst/locator.dart';
 import 'package:testgsschoolst/repo/shared_pref_helper.dart';
import 'package:flutter/cupertino.dart';

class MyTheme {
  final OutlineInputBorder textFormField = OutlineInputBorder(
      borderSide: BorderSide(  width: 1.0),
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
          bottomRight: Radius.circular(25)));
}

class ThemeNotifier with ChangeNotifier {
  final prefs = locator<SharedPrefrenceHalper>();
  String lang = locator<SharedPrefrenceHalper>().lang;
  changeLang(String newLang) {
    lang = newLang;
    prefs.setLang(newLang);
    notifyListeners();
  }

  bool isDark = true;
  ThemeNotifier() {
    isDark = prefs.isDarkMode ?? false;
  }
  changeThemeMod(bool mod) async {
    isDark = mod;
    notifyListeners();
    prefs.setMode(mod);
    notifyListeners();
  }
}
