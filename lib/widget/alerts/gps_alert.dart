import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/main.dart';
import 'package:location/location.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future<bool> showGpsOffFaliedAlert(String detalis) async {
  bool value = await showDialog<bool>(
      context: navigatorKey.currentContext,
      useSafeArea: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            "$detalis",
            textAlign: TextAlign.center,
            style: TextStyle(),
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DialogButton(
                  child: Center(
                    child: Text(
                      Translate.no.trans(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(navigatorKey.currentContext, false);
                  },
                  width: 120,
                ),
                DialogButton(
                  child: Center(
                    child: Text(
                     Translate.ok.trans(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  onPressed: () async {
                    Location locator = Location();
                    bool status = await locator.requestService();
                    Navigator.pop(navigatorKey.currentContext, status);
                  },
                  width: 120,
                ),
              ],
            )
          ],
        );
      });
  return value;
}
