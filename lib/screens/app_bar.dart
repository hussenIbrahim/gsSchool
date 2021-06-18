import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/main.dart';
import 'package:testgsschoolst/screens/prepare.dart';

AppBar myAppBar(
    {@required List<Widget> actions,
    bool showTitle,
    Widget title,
    Widget bottom}) {
  return AppBar(
    title: showTitle == false
        ? title
        : Consumer<PrepareAppNotifier>(
            builder: (context, PrepareAppNotifier _pre, child) {
            myPrint("_pre.appBarTitle  ${_pre.appBarTitle}");

            return Text(
              "${_pre.appBarTitle}",
            );
          }),
    centerTitle: true,
    actions: actions,
    bottom: PreferredSize(
      child: bottom ?? SizedBox(),
      preferredSize: Size(MediaQuery.of(navigatorKey.currentContext).size.width,
          bottom != null ? 60 : 0),
    ),
  );
}
