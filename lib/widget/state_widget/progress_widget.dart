import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../responsev.dart';

class ProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
     height: MediaQuery.of(context).size.height -
                  (Responsive().statusBarHeight +
                      Responsive().statusBarHeight +
                      Responsive().statusBarHeight +
                      Responsive().statusBarHeight +
                      Responsive().statusBarHeight),
        width: Responsive().screenWidth,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor),
          ),
        ));
  }
}
