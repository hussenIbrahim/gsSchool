import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:testgsschoolst/database.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/constant.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/schedule/services/schedule_model.dart';
import 'package:testgsschoolst/screens/subjects/services/subjects_services.dart';
import 'package:testgsschoolst/widget/alerts/login_status.dart';

class ScheduleServices {
  Future<ScheduleModellResponse> getSchudleMiddleWare(
      String day, bool forceRefresh) async {
    if (forceRefresh == true) {
      return await _getSchudleFromAPI(day);
    }

    ScheduleModellResponse result = await _readFromLocalDatabase(day);
    if (result.data.length != 0) {
      return result;
    } else {
      return await _getSchudleFromAPI(day);
    }
  }

  _saveEventToLoca(List<ScheduleModel> list) async {
    final _db = await database;
    list.forEach((model) {
      try {
        _db.insert(SchedulesTable, model.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      } catch (e) {
        myPrint("error im save SubjectSchedule to local $e");
      }
    });
  }

  Future<ScheduleModellResponse> _getSchudleFromAPI(String day) async {
    try {
      final url = "$URL/api/Schedule?_start=0&_end=1000";

      myPrint(url);
      http.Response customer = await http
          .get(Uri.parse(url), headers: getAppHeader())
          .timeout(DURATION_60);

      myPrint("Evetns ${customer.statusCode}");
      myPrint("Evetns ${customer.body}");
      if (customer.statusCode == 200) {
        ScheduleModellResponse result = await compute(
            parseCustomerPayments,
            ResponseWithStudentId(
                response: customer.body, studentId: getUserId()));
        _saveEventToLoca(result.data);
        return result;
      } else if (customer.statusCode == 401) {
        faliedLogin(Translate.failed.trans(),
            Translate.canotCompleteThisActionReloginAndRetry.trans(), true);
      }
      return ScheduleModellResponse(status: Status.error, data: []);
    } catch (e) {
      myPrint("error in get Evetns sv $e");
      if (e.toString().contains("TimeoutException") ||
          e.toString().contains("No address associated with hostname")) {
        return ScheduleModellResponse(status: Status.newtworkError, data: []);
      }
      return ScheduleModellResponse(status: Status.error, data: []);
    }
  }

  Future<ScheduleModellResponse> _readFromLocalDatabase(String day) async {
    List<ScheduleModel> list = [];
    try {
      final _db = await database;
      final List<Map<dynamic, dynamic>> data = await _db.query(SchedulesTable,
          where: 'dayName ${day == 'all' ? '!=' : '='} ?', whereArgs: [day]);

      myPrint("mapmapmap  $data $day");
      if (data.isEmpty) {
        return ScheduleModellResponse(data: list, status: Status.noDataFound);
      }
      data.forEach((key) {
        ScheduleModel temp =
            ScheduleModel.fromJson(Map<String, dynamic>.from(key), true);
        list.add(temp);
      });
      return ScheduleModellResponse(data: list, status: Status.dataFound);
    } catch (e) {
      myPrint("error in read events from database$e");
      return ScheduleModellResponse(data: list, status: Status.error);
    }
  }
}

ScheduleModellResponse parseCustomerPayments(
    ResponseWithStudentId responseBody) {
  myPrint(responseBody);
  List<ScheduleModel> list = [];
  var body = jsonDecode(responseBody.response);
  for (var i = 0; i < body.length; i++) {
    ScheduleModel documentsCostumers = ScheduleModel.fromJson(
        {...body[i], "studentId": responseBody.studentId}, false);

    list.add(documentsCostumers);
  }
  responseBody = null;
  myPrint("list length in get ScheduleModel ${list.length}");
  body = null;
  if (list.length == 0) {
    return ScheduleModellResponse(status: Status.noDataFound, data: list);
  }
  return ScheduleModellResponse(status: Status.dataFound, data: list);
}
