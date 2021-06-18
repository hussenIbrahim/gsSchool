import 'package:shared_preferences/shared_preferences.dart';
import 'package:testgsschoolst/locator.dart';

class SharedPrefrenceHalper {
  SharedPreferences prefsObj;

  String lang = "en";
  bool isDarkMode = false;

  String fcmToken;
  Future<void> initData() async {
    prefsObj = await SharedPreferences.getInstance();
    await getLang();
    await getMode();
    await getToken();


    return true;
  }

 


  setToken(var newValue) async {
    fcmToken = newValue;
    await prefsObj.setString("fcmToken", "$newValue");
  }

  getToken() async {
    fcmToken = prefsObj.getString("fcmToken");
  }

  setMode(var newValue) async {
    isDarkMode = newValue;
    await prefsObj.setBool("isDark", isDarkMode);
  }

  getMode() async {
    isDarkMode = prefsObj.getBool("isDark");
    if (isDarkMode == null) {
      isDarkMode = false;
    }
  }

  setLang(var newValue) async {
    lang = newValue;
    await prefsObj.setString("lang", "$newValue");
  }

  getLang() async {
    lang = prefsObj.getString("lang");
    myPrint("lang  $lang");
    if (lang == null || lang == "null") {
      lang = "en";
    }
  }

 

  Future<void> clearAll() async {
    await prefsObj.clear();
  }
}
