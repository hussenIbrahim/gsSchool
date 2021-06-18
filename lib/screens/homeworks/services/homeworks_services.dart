import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:testgsschoolst/database.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/constant.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/homeworks/services/homeworks_model.dart';
import 'package:testgsschoolst/screens/subjects/services/subjects_services.dart';
import 'package:testgsschoolst/widget/alerts/login_status.dart';

class HomeWorksModelServices {
  Future<HomeWorksModellResponse> getHomeWorksMiddleWare(
      bool forceGet, String day) async {
    if (forceGet == true) {
      return await _getFromAPI(day);
    }

    HomeWorksModellResponse result =
        await _readFromLocalDatabase(day, getUserId());
    if (result.data.length > 0) {
      return result;
    } else {
      return await _getFromAPI(day);
    }
  }

  Future<HomeWorksModellResponse> _getFromAPI(String day) async {
    try {
      myPrint(connectionNotifer.isConnected);
      final url = "$URL/api/Homeworks";

      myPrint(url);
      http.Response customer = await http
          .get(Uri.parse(url), headers: getAppHeader())
          .timeout(DURATION_60);

      myPrint("Evetns ${customer.statusCode}");
      myPrint("Evetns ${customer.body}");
      if (customer.statusCode == 200) {
        HomeWorksModellResponse result = await compute(
            parseCustomerPayments,
            ResponseWithStudentId(
                response: customer.body, studentId: getUserId()));
        _saveEventToLoca(result.data);
        return result;
      } else if (customer.statusCode == 401) {
        faliedLogin(Translate.failed.trans(),
            Translate.canotCompleteThisActionReloginAndRetry.trans(), true);
      }
      return HomeWorksModellResponse(status: Status.error, data: []);
    } catch (e) {
      myPrint("error in get Evetns sv $e");
      if (e.toString().contains("TimeoutException") ||
          e.toString().contains("No address associated with hostname")) {
        return HomeWorksModellResponse(status: Status.newtworkError, data: []);
      }
      return HomeWorksModellResponse(status: Status.error, data: []);
    }
  }

  _saveEventToLoca(List<HomeWorksModel> list) async {
    final _db = await database;
    list.forEach((model) {
      try {
        _db.insert(HomeworksTable, model.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      } catch (e) {
        myPrint("error im save SubjectSchedule to local $e");
      }
    });
  }

  Future<HomeWorksModellResponse> _readFromLocalDatabase(
      String day, String studentId) async {
    List<HomeWorksModel> list = [];
    try {
      final _db = await database;
      final List<Map<dynamic, dynamic>> data = await _db.query(HomeworksTable,
          where: 'dayName ${day == 'all' ? '!=' : '='} ? AND studentId==',
          whereArgs: [day, studentId]);

      myPrint("mapmapmap  $data $day");
      if (data.isEmpty) {
        return HomeWorksModellResponse(data: list, status: Status.noDataFound);
      }
      data.forEach((key) {
        HomeWorksModel temp =
            HomeWorksModel.fromJson(Map<String, dynamic>.from(key), true);
        list.add(temp);
      });
      return HomeWorksModellResponse(data: list, status: Status.dataFound);
    } catch (e) {
      myPrint("error in read events from database$e");
      return HomeWorksModellResponse(data: list, status: Status.error);
    }
  }
}

HomeWorksModellResponse parseCustomerPayments(
    ResponseWithStudentId responseBody) {
  myPrint(responseBody);
  List<HomeWorksModel> list = [];
  var body = jsonDecode(responseBody.response);
  for (var i = 0; i < body.length; i++) {
    HomeWorksModel documentsCostumers = HomeWorksModel.fromJson(
        {...body[i], "studentId": responseBody.studentId}, false);

    list.add(documentsCostumers);
  }
  responseBody = null;
  myPrint("list length in get HomeWorksModel ${list.length}");
  body = null;
  if (list.length == 0) {
    return HomeWorksModellResponse(status: Status.noDataFound, data: list);
  }
  return HomeWorksModellResponse(status: Status.dataFound, data: list);
}
