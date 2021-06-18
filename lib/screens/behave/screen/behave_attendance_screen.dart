import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/screens/attendances/screen/attendance_screen.dart';
import 'package:testgsschoolst/screens/behave/screen/behave_screen.dart';

import 'package:testgsschoolst/screens/prepare.dart';

class BehaveAbdAttendanceScreen extends StatefulWidget {
  @override
  _BehaveAbdAttendanceScreenState createState() =>
      _BehaveAbdAttendanceScreenState();
}

class _BehaveAbdAttendanceScreenState extends State<BehaveAbdAttendanceScreen> {
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: [BehaveScreen(), AttendanceScreen()],
      ),
      bottomNavigationBar:
          Consumer<PrepareAppNotifier>(builder: (context, myType, child) {
        return BottomNavigationBar(
          onTap: (int index) {
            controller.jumpToPage(index);
            myType.changeBeahveAttenadanceIndex(index);
          },
          currentIndex: myType.beahveAttenadanceIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: Translate.behave.trans()),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: Translate.attendence.trans()),
          ],
        );
      }),
    );
  }
}
