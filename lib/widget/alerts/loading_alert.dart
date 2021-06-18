import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/widget/responsev.dart';

import '../../main.dart';

Future<void> showLoadingProgressAlert() async {
  showDialog<void>(
    context: navigatorKey.currentContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: WillPopScope(
          onWillPop: () async => false,
          child: Container(
            child: Row(
              children: <Widget>[
                CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
                SizedBox(width: 25),
                Text(Translate.loading.trans(),
                    style: TextStyle(
                      fontSize: Responsive().setSp(
                        16,
                      ),
                    )),
              ],
            ),
          ),
        ),
      );
    },
  );
}
