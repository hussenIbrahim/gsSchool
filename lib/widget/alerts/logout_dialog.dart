import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../locator.dart';
import '../../main.dart';
import '../responsev.dart';
import 'loading_alert.dart';

Future<void> logoutDialog() async {
  Alert(
    type: AlertType.warning,
    context: navigatorKey.currentContext,
    style: AlertStyle(
        isCloseButton: false,
        descStyle: TextStyle(
          fontSize: Responsive().setSp(18),
        ),
        titleStyle: TextStyle(
          fontSize: Responsive().setSp(20),
        )),
    title:
     Translate.areYouSureToLogOut.trans(),
    buttons: [
      DialogButton(
        padding: EdgeInsets.all(8),
        height: Responsive().setHeight(50),
        child: Text(
     Translate.yes.trans(),
          style: TextStyle(
              fontSize: Responsive().setSp(20),
              height: 1,
              color:
                  Theme.of(navigatorKey.currentContext).secondaryHeaderColor),
        ),
        onPressed: () {
          Navigator.pop(navigatorKey.currentContext);
          showLoadingProgressAlert();
          Future.delayed(Duration(seconds: 1)).then((value) {
            signOut();
          });
        },
        width: 120,
      ),
      DialogButton(
        height: Responsive().setHeight(50),
        padding: EdgeInsets.all(8),
        child: Text(
    Translate.no.trans(),
          style: TextStyle(
              height: 1,
              fontSize: Responsive().setSp(20),
              color:
                  Theme.of(navigatorKey.currentContext).secondaryHeaderColor),
        ),
        onPressed: () {
          Navigator.pop(navigatorKey.currentContext);
        },
        width: 120,
      ),
    ],
  ).show();
}
