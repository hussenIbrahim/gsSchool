import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/connection.dart';
import 'package:testgsschoolst/screens/account/screens/signin_screen.dart';
import 'package:testgsschoolst/screens/account/services/multi_account_services.dart';
import 'package:testgsschoolst/screens/account/services/personal_information_notifer.dart';
import 'package:testgsschoolst/screens/attendances/services/attendance_notifer.dart';
import 'package:testgsschoolst/screens/behave/services/behave_notifer.dart';
import 'package:testgsschoolst/screens/home_screen.dart';
import 'package:testgsschoolst/screens/subjects/services/subjects_notifer.dart';
import 'package:testgsschoolst/widget/responsev.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      connectionNotifer =
          Provider.of<ConnectionNotifer>(context, listen: false);
      behaveNotifer = Provider.of<BehaveNotifer>(context, listen: false);
      subJectsNotifer = Provider.of<SubJectsNotifer>(context, listen: false);
      attendanceNotifer =
          Provider.of<AttendanceNotifer>(context, listen: false);
      connectionNotifer.checConnection();
      connectionNotifer.startListen();
      Future.delayed(Duration(seconds: 5)).then((value) {
    
        Widget widget;
        personalInfoNotifier =
            Provider.of<PersonalInfoNotifier>(context, listen: false);
        if (locator<MultuAccountServices>().accountModel.token == null) {
          widget = SignInScreen();
        } else {
          widget = HomeScreen();
        }
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => widget), (route) => false);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isFirstHomeOpen) {
      Responsive.init(context, designSize: Size(411.4, 843.4));
      isFirstHomeOpen = true;
    }
    return Scaffold(
        body: Container(
            child: Stack(
      children: [
        // Image.asset(
        //   "assets/logs/splash_screen.jpg",
        //   width: MediaQuery.of(context).size.width,
        //   fit: BoxFit.fitWidth,
        // ),
      ],
    )));
  }
}

bool isFirstHomeOpen = false;
