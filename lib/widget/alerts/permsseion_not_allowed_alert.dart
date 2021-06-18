import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/main.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


Future<void> permissionNotAllowedAlert(String feature) async {
  Alert(
    type: AlertType.warning,
    context: navigatorKey.currentContext,
    style: AlertStyle(
      isCloseButton: false,
    ),
    title: "$feature",
    buttons: [
      DialogButton(
        child: Text(
       Translate.ok.trans(),
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(navigatorKey.currentContext);
        },
        width: 120,
      ),
    ],
  ).show();
}
