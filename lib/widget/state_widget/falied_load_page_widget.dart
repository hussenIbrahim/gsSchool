import 'package:flutter/material.dart';
import 'package:testgsschoolst/widget/responsev.dart';

class FaliedLoadPageWIdget extends StatelessWidget {
  final Function onPress;
  final String text;
  const FaliedLoadPageWIdget({
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
                    Icons.error,
                    color: Colors.grey,
                    size: Responsive().setSp(150),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    //T
                    "$text",
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
