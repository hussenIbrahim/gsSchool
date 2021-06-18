import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testgsschoolst/database.dart';
import 'package:testgsschoolst/repo/connection.dart';
import 'package:testgsschoolst/repo/constant.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/repo/getLocation.dart';
import 'package:testgsschoolst/repo/shared_pref_helper.dart';
import 'package:testgsschoolst/repo/theme.dart';
import 'package:testgsschoolst/screens/account/screens/select_image_profile.dart';
import 'package:testgsschoolst/screens/account/services/account_services.dart';
import 'package:testgsschoolst/screens/account/services/login_services.dart';
import 'package:testgsschoolst/screens/account/services/multi_account_services.dart';
import 'package:testgsschoolst/screens/account/services/personal_information_notifer.dart';
import 'package:testgsschoolst/screens/attendances/services/attendance_notifer.dart';
import 'package:testgsschoolst/screens/attendances/services/attendance_services.dart';
import 'package:testgsschoolst/screens/behave/services/behave_notifer.dart';
import 'package:testgsschoolst/screens/behave/services/behave_services.dart';
import 'package:testgsschoolst/screens/books/services/books_notifer.dart';
import 'package:testgsschoolst/screens/books/services/books_services.dart';
import 'package:testgsschoolst/screens/chat_screen/services/chat_notifer.dart';
import 'package:testgsschoolst/screens/chat_screen/services/chat_services.dart';
import 'package:testgsschoolst/screens/chat_screen/services/messages_notifer.dart';
import 'package:testgsschoolst/screens/dash_board/services/dash_board_notifer.dart';
import 'package:testgsschoolst/screens/dash_board/services/dash_board_services.dart';
import 'package:testgsschoolst/screens/events/services/event_notifer.dart';
import 'package:testgsschoolst/screens/events/services/event_services.dart';
import 'package:testgsschoolst/screens/exames/services/exam_notifer.dart';
import 'package:testgsschoolst/screens/exames/services/exames_services.dart';
import 'package:testgsschoolst/screens/homeworks/services/homeworks_notifer.dart';
import 'package:testgsschoolst/screens/homeworks/services/homeworks_services.dart';
import 'package:testgsschoolst/screens/online_quizs/services/online_quiz_notifer.dart';
import 'package:testgsschoolst/screens/online_quizs/services/online_quiz_services.dart';
import 'package:testgsschoolst/screens/prepare.dart';
import 'package:testgsschoolst/screens/schedule/services/schedule_notifer.dart';
import 'package:testgsschoolst/screens/schedule/services/schedule_services.dart';
import 'package:testgsschoolst/screens/student/services/student_notifer.dart';
import 'package:testgsschoolst/screens/student/services/student_services.dart';
import 'package:testgsschoolst/screens/subjects/services/subjects_notifer.dart';
import 'package:testgsschoolst/screens/subjects/services/subjects_services.dart';

const List<String> LessonImage = [
  "Arabic",
  "Science",
  "Computer",
  "English",
  "Mathematics"
];

AttachmentNotifier attachmentNotifier;
AttendanceNotifer attendanceNotifer;
BehaveNotifer behaveNotifer;
BooksNotifer booksNotifer;
// IconAndColorNotifer iconAndColorNotifer;
ChatNotifer chatNotifer;
MessagesNotifer messagesNotifer;
ConnectionNotifer connectionNotifer;
DashBoardNotifer dashBoardNotifer;
Future<Database> database;
ExamesNotifer examesNotifer;
EventsNotifer eventsNotifer;
HomeWorkNotifer homeWorkNotifer;
GetIt locator = GetIt.instance;
PersonalInfoNotifier personalInfoNotifier;
PrepareAppNotifier prepareAppNotifier;
ScheduleNotifer scheduleNotifer;
StudentNotifer studentNotifer;
SubJectsNotifer subJectsNotifer;
 OnlineQuizNotifer onlineQuizNotifer;
ThemeNotifier themeNotifier;
Map<String, String> getStudentHeader() {
  String _lang = locator<SharedPrefrenceHalper>().lang == "ku"
      ? "Kurdish"
      : locator<SharedPrefrenceHalper>().lang == "ar"
          ? "Arabic"
          : "English";

  return {
    'Accept': 'application/json',
    'Content-type': 'application/json',
    "Authorization":
        "Bearer ${personalInfoNotifier.accountModel.userType == Parent ? personalInfoNotifier.accountModel.token : studentNotifer.student.id}",
    "language": _lang,
  };
}

Map<String, String> getAppHeader({bool isImage}) {
  String _lang = locator<SharedPrefrenceHalper>().lang == "ku"
      ? "Kurdish"
      : locator<SharedPrefrenceHalper>().lang == "ar"
          ? "Arabic"
          : "English";
  if (isImage == true) {
    return {
      "accept": "text/plain",
      "Authorization":
          "Bearer ${personalInfoNotifier.accountModel.userType == Parent ? personalInfoNotifier.accountModel.token : locator<MultuAccountServices>().accountModel.token}",
      "language": _lang,
      "ratio": "1450"
    };
  } else {
    return {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      "Authorization":
          "Bearer ${locator<MultuAccountServices>().accountModel.token}",
      "language": _lang,
      "ratio": "1450"
    };
  }
}

String getUserId() {
  return personalInfoNotifier.accountModel?.userType == Parent
      ? studentNotifer.student?.id
      : personalInfoNotifier.accountModel.id;
}

bool isLogin() {
  String token = locator<MultuAccountServices>().accountModel.token;
  myPrint("${token != "" && token != "null" && token != null ? true : false}");
  return token != "" && token != "null" && token != null ? true : false;
}

myPrint(message) {
  if (!kReleaseMode) {
    log(message.toString());
  }
}

Future<void> setUpLocalDataBase() async {
  String dbPath = await getDatabasesPath();

  myPrint("dbPath $dbPath");
  database = openDatabase(
    join(dbPath, 'sg_student.db'),
    onConfigure: (
      db,
    ) async {
      await db.execute("PRAGMA foreign_keys = ON");
    },
    onUpgrade: _onUpgrade,
    onCreate: (db, version) async {
      var batch = db.batch();
      myPrint("db created");
      createTable(batch);
      final result = await batch.commit();
      myPrint("result  $result");
    },
    version: 11,
  );
}

void setUpLocator() async {
  locator.registerSingleton(MyTheme());
  locator.registerSingleton(SharedPrefrenceHalper());
  locator.registerSingleton(LoginServices());
  locator.registerSingleton(StudentServices());
  locator.registerSingleton(DashBoardServices());
  locator.registerSingleton(AccountServices());
  locator.registerSingleton(GetLOcationHalper());
  locator.registerSingleton(AttendanceServices());
  locator.registerSingleton(HomeWorksModelServices());
  locator.registerSingleton(ScheduleServices());
  locator.registerSingleton(ChatServices());
  locator.registerSingleton(EventsServices());
  locator.registerSingleton(BooksServices());
  locator.registerSingleton(BehaveServices());
  locator.registerSingleton(SubjectsServices());
  locator.registerSingleton(OnlineQuizServices());
  locator.registerSingleton(MultuAccountServices());
  locator.registerSingleton(ExamesServices());
}

setValuesToDefalut() {
  studentNotifer?.setToDef();
  chatNotifer?.setDashBoardState(Status.loading);
}

Future<void> signOut() async {
  // Navigator.pop(navigatorKey.currentContext);
  // await locator<SharedPrefrenceHalper>().clearAll();

  // Navigator.pushAndRemoveUntil(navigatorKey.currentContext,
  //     MaterialPageRoute(builder: (_) {
  //   return SignInScreen();
  // }), (route) => false);
}

void _onUpgrade(Database db, int oldVersion, int newVersion) {
  myPrint("newVersion $newVersion oldVersion $oldVersion");
  if (oldVersion < newVersion) {
    db.execute('''ALTER TABLE $HomeworksTable ADD COLUMN hasPdf  INTEGER''');
     db.execute('''ALTER TABLE $SubjectTable ADD COLUMN order INTEGER''');
  }
}
