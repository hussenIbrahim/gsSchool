import 'package:fluttertoast/fluttertoast.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/widget/responsev.dart';

showToast(String title,
    {ToastGravity toastGravity = ToastGravity.BOTTOM}) async {
  myPrint("_isToastOpen = false;  $_isToastOpen ");
  if (_isToastOpen) {
    await Fluttertoast.cancel();
    _isToastOpen = await Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_SHORT,
        
        gravity: toastGravity,
        timeInSecForIosWeb: 1,
        fontSize: Responsive().setSp(18));
  } else {
    _isToastOpen = await Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_SHORT,
        gravity: toastGravity,
        timeInSecForIosWeb: 1,
        fontSize: Responsive().setSp(18));
  }
}

bool _isToastOpen = false;
