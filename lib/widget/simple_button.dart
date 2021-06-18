import 'package:flutter/material.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/shared_pref_helper.dart';
import 'package:testgsschoolst/widget/responsev.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton({
    Key key,
    @required this.text,
    @required this.fontSize,
     this.txtColor,
    @required this.onPres,
    this.color,
    this.imagePath,
    this.width = 374,
    this.rad = 38,
    this.border = false,
    @required this.hight,
  }) : super(key: key);
  final bool border;
  final String text;
  final Function onPres;
  final Color color;
  final Color txtColor;
  final double hight;
  final double fontSize;
  final double width;
  final double rad;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final isDark = locator<SharedPrefrenceHalper>().isDarkMode;
    return MaterialButton(
      shape: RoundedRectangleBorder(
          side: border == true ? BorderSide(color: color) : BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(rad),
          )),
      color: border == true
          ? isDark == true
              ? Colors.transparent
              : Colors.white
          : color != null
              ? color
              : Theme.of(context).primaryColor,
      onPressed: onPres,
      height: Responsive().setHeight(hight),
      minWidth: Responsive().setWidth(width),
      child: Row(
        mainAxisAlignment: imagePath == null
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          imagePath == null
              ? SizedBox()
              : Image.asset(
                  imagePath,
                  height: Responsive().setHeight(24.06),
                  width: Responsive().setHeight(24.06),
                ),
          imagePath == null
              ? SizedBox()
              : SizedBox(
                  width: 15,
                ),
          Text(
            "$text",
            style: TextStyle(color: txtColor, fontSize: fontSize),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
