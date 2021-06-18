import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/main.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../responsev.dart';



Future<void> faliedLogin(String title ,String desc, bool isAuth) async {
  Alert(
    type: AlertType.warning,
   context: navigatorKey.currentContext,
    style: AlertStyle(
        isCloseButton: false,
        titleStyle: TextStyle(
          fontSize: Responsive().setSp(16, ),
        )),
    title:   "$title",
    content: Text("$desc",
        style: TextStyle(
          fontSize: Responsive().setSp(16, ),
        )),
    buttons: [
      DialogButton(
        child: Text(
         Translate.ok.trans(),
          style: TextStyle(
            fontSize: Responsive().setSp(15, ),
          ),
        ),
        onPressed: () => Navigator.pop(navigatorKey.currentContext),
        width: 120,
        height: 50,
      )
    ],
  ).show().whenComplete(() {
    if (isAuth == true) {
      signOut();
    }
  });
}
