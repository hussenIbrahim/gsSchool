import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/widget/responsev.dart';



class NetWorkErrorWidget extends StatelessWidget {
  final Function onPress;
  final String text;
  const NetWorkErrorWidget({
    Key key,
    @required this.onPress,
    @required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextStyle boldTextStyle = TextStyle(
      fontSize: Responsive().setSp(
        20,
      ),
    );
    return Center(
      child: RefreshIndicator(
        onRefresh: onPress,
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
               height: MediaQuery.of(context).size.height -
                  (Responsive().statusBarHeight +
                      Responsive().statusBarHeight +
                      Responsive().statusBarHeight +
                      Responsive().statusBarHeight +
                      Responsive().statusBarHeight),
              width: Responsive().screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_off,
                    color: Colors.red,
                    size: Responsive().setSp(125),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                   "$text",
                    textAlign: TextAlign.center,
                    style: boldTextStyle,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                 Translate.pullToRefresh.trans(),
                    textAlign: TextAlign.center,
                    style: boldTextStyle,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
