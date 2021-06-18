import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/repo/constant.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/screens/dash_board/services/models.dart';
import 'package:testgsschoolst/screens/exames/services/exames_mode.dart';
import 'package:testgsschoolst/screens/homeworks/services/homeworks_model.dart';
import 'package:testgsschoolst/screens/schedule/services/schedule_model.dart';
import 'package:testgsschoolst/widget/alerts/login_status.dart';
import 'package:http/http.dart' as http;

class DashBoardServices {
  Future<ScheduleTodayModelResponse> getOffers(
      bool foreRefresh, String studentId) async {
    try {
      List<http.Response> responses = await Future.wait([
        http
            .get(
              Uri.parse("$URL/api/Schedule"),
              headers: getAppHeader(),
            )
            .timeout(DURATION_60),
        http
            .get(
              Uri.parse("$URL/api/ExamSchedules"),
              headers: getAppHeader(),
            )
            .timeout(DURATION_60),
        http
            .get(
              Uri.parse("$URL/api/Homework"),
              headers: getAppHeader(),
            )
            .timeout(DURATION_60),
      ]);
      http.Response responses1 = responses[0];
      http.Response examesRes = responses[1];
      http.Response homeworskRes = responses[2];
      myPrint("offers1 ${responses1.statusCode}");
      myPrint("offers1 ${responses1.body}");
      myPrint("offers2 ${examesRes.statusCode}");
      myPrint("offers2 ${examesRes.body}");
      myPrint("offers3 ${homeworskRes.statusCode}");
      myPrint("offers3 ${homeworskRes.body}");
      if (responses1.statusCode == 200) {
        List<ScheduleModel> schdule =
            await compute(_parseScheduleModel, responses1.body);
        List<ExamesModel> exames =
            await compute(_parseExamesModel, examesRes.body);
        List<HomeWorksModel> homeworks =
            await compute(_parseHomeWorksModel, homeworskRes.body);
        return ScheduleTodayModelResponse(
            status: Status.error,
            schedules: schdule,
            exames: exames,
            homeworks: homeworks);
      } else if (responses1.statusCode == 401) {
        faliedLogin(Translate.failed.trans(),
            Translate.canotCompleteThisActionReloginAndRetry.trans(), true);
      }
      return ScheduleTodayModelResponse(
          status: Status.error, schedules: [], exames: [], homeworks: []);
    } catch (e) {
      myPrint("error in get offers sv $e");
      if (e.toString().contains("TimeoutException") ||
          e.toString().contains("No address associated with hostname")) {
        return ScheduleTodayModelResponse(
            status: Status.newtworkError,
            schedules: [],
            exames: [],
            homeworks: []);
      }
      return ScheduleTodayModelResponse(
          status: Status.error, schedules: [], exames: [], homeworks: []);
    }
  }
}

List<ScheduleModel> _parseScheduleModel(String responseBody) {
  myPrint(responseBody);
  List<ScheduleModel> list = [];
  var body = jsonDecode(responseBody);
  for (var i = 0; i < body.length; i++) {
    ScheduleModel documentsCostumers = ScheduleModel.fromJson(body[i], false);

    list.add(documentsCostumers);
  }
  responseBody = null;
  myPrint("list length in get TopicModel ${list.length}");
  body = null;
  return list;
}

List<HomeWorksModel> _parseHomeWorksModel(String responseBody) {
  myPrint(responseBody);
  List<HomeWorksModel> list = [];
  var body = jsonDecode(responseBody);
  for (var i = 0; i < body.length; i++) {
    HomeWorksModel documentsCostumers = HomeWorksModel.fromJson(body[i], false);

    list.add(documentsCostumers);
  }
  responseBody = null;
  myPrint("list length in get HomeWorksModel ${list.length}");
  body = null;
  return list;
}

List<ExamesModel> _parseExamesModel(String responseBody) {
  myPrint(responseBody);
  List<ExamesModel> list = [];
  var body = jsonDecode(responseBody);
  for (var i = 0; i < body.length; i++) {
    ExamesModel documentsCostumers = ExamesModel.fromJson(body[i]);

    list.add(documentsCostumers);
  }
  responseBody = null;
  myPrint("list length in get HomeWorksModel ${list.length}");
  body = null;
  return list;
}
