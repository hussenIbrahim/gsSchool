import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/main.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/account/services/account_services.dart';
import 'package:testgsschoolst/screens/home_screen.dart';

class PrepareAppNotifier extends ChangeNotifier {
  Status checkPhoneNumberStatus = Status.initState;
  AccountServices accountServices = locator<AccountServices>();
  bool upDatePaasword = false;
  int dashboardIndex = 0;

  String appBarTitle = Translate.dashboard.trans();
  changeGetDataStatus(Status _getDataStatus) async {
    checkPhoneNumberStatus = _getDataStatus;
    notifyListeners();
  }

/*     0   FirstDashBoard(),
           
        1      HomeWorkScreen(),
         2     ScheduleScreen(),
          3    OnlineQuizScreen(),
           4   EventsScreen(),
            5  SchoolInfoScreen(),
             6 ExamesScreen(),
             7 BehaveScreen(),
             8 AttendanceScreen(),
             9 GpsTrackerScreen() */
  changeIndex(ScreenEnums newScreen) {
    if (newScreen == ScreenEnums.dashBoard) {
      appBarTitle = Translate.dashboard.trans();
      goToPage(0);
    } else if (newScreen == ScreenEnums.homeWOrk) {
      appBarTitle = Translate.homeworks.trans();
      goToPage(1);
    } else if (newScreen == ScreenEnums.schedule) {
      appBarTitle = Translate.schedule.trans();
      goToPage(2);
    } else if (newScreen == ScreenEnums.onlineQuiz) {
      appBarTitle = Translate.onlineQuizes.trans();
      goToPage(3);
    } else if (newScreen == ScreenEnums.events) {
      appBarTitle = Translate.events.trans();
      goToPage(4);
    } else if (newScreen == ScreenEnums.schoolInfo) {
      appBarTitle = Translate.schoolInfo.trans();
      goToPage(5);
    } else if (newScreen == ScreenEnums.exams) {
      appBarTitle = Translate.exams.trans();
      goToPage(6);
    } else if (newScreen == ScreenEnums.attendance) {
      appBarTitle = Translate.attendence.trans();
      goToPage(8);
    } else if (newScreen == ScreenEnums.gpsTracker) {
      appBarTitle = Translate.gPSTracker.trans();
      goToPage(9);
    } else if (newScreen == ScreenEnums.behave) {
      appBarTitle = Translate.behave.trans();
      goToPage(7);
    } else if (newScreen == ScreenEnums.books) {
      appBarTitle = Translate.books.trans();
      goToPage(10);
    } else if (newScreen == ScreenEnums.behaveAndAttendance) {
      appBarTitle =
          Translate.behave.trans() + " " + Translate.attendence.trans();
      goToPage(8);
    }
     else if (newScreen == ScreenEnums.subjects) {
      appBarTitle =
          Translate.subjects.trans();
      goToPage(11);
    }

    notifyListeners();
  }

  changeDashBoardIndex(int newIndex) {
    dashboardIndex = newIndex;
    notifyListeners();
  }

  int beahveAttenadanceIndex = 0;
  changeBeahveAttenadanceIndex(int newIndex) {
    beahveAttenadanceIndex = newIndex;
    notifyListeners();
  }

  checkForCurrentPhoneNumber() async {
    Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.pushAndRemoveUntil(navigatorKey.currentContext,
          MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
    });

    notifyListeners();
  }

  goToPage(int page) {
    homePageController.jumpToPage(page);
  }

  retry() {
    checkPhoneNumberStatus = Status.loading;
    notifyListeners();
  }

  setDataToDefalut() {
    checkPhoneNumberStatus = Status.loading;
    notifyListeners();
  }
}

enum ScreenEnums {
  dashBoard,
  schoolInfo,
  homeWOrk,
  subjects,
  chatPage,
  schedule,
  events,
  exams,
  books,
  gpsTracker,
  behave,
  behaveAndAttendance,
  onlineQuiz,
  attendance,
  supplierRecieves
}
