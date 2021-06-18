import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/main.dart';
import 'package:testgsschoolst/repo/theme.dart';
import 'package:provider/provider.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

Future<void> successAlert({
  String message,
}) async {
  TextTheme textTheme = Theme.of(navigatorKey.currentContext).textTheme;
final themeNotifier = Provider.of<ThemeNotifier>( navigatorKey.currentContext, listen: false);

  var b = await Alert(
    style: AlertStyle(
      overlayColor: Colors.grey.withOpacity(0.4),
      isCloseButton: false,
      titleStyle: textTheme.headline5.copyWith(
          color: themeNotifier.isDark ? Colors.white : Colors.black87),
    ),
    context: navigatorKey.currentContext,
    title:Translate.success.trans(),
    onWillPopActive: false,
    image: Image.asset(
      "packages/rflutter_alert/assets/images/2.0x/icon_success.png",
      height: 50,
    ),
    content: Form(
      child: Column(
        children: [
          Text(
            message,
            style: textTheme.subtitle1.copyWith(
                color: themeNotifier.isDark ? Colors.white : Colors.black87),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
    buttons: [
      DialogButton(
        radius: BorderRadius.circular(20),
        child: Text(
        Translate.ok.trans(),
          style: textTheme.bodyText1.copyWith(color: Colors.white),
        ),
        onPressed: () {
          Navigator.pop(navigatorKey.currentContext);
        },
      ),
    ],
  ).show();
  return b;
}
