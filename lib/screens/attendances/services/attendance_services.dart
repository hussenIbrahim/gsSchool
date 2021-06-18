import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/constant.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/attendances/services/attendance_model.dart';
import 'package:testgsschoolst/widget/alerts/login_status.dart';

class AttendanceServices {
  Future<AttendanceModelResponse> getChatPersons(int page) async {
    // if (connectionNotifer.isConnected == false) {
    //   return await _readFromLocalDatabase();
    // }
    try {
      myPrint(connectionNotifer.isConnected);
      final url =
          "$URL/api/StudentAttendences?_start=0&_end=1000";

      myPrint(url);
      http.Response customer = await http
          .get(Uri.parse(url), headers: getAppHeader())
          .timeout(DURATION_60);

      myPrint("attendanc ${customer.statusCode}");
      myPrint("attendanc ${customer.body}");
      if (customer.statusCode == 200) {
        AttendanceModelResponse result =
            await compute(parseCustomerPayments, customer.body);
        // _saveEventToLoca(result.data);
        return result;
      } else if (customer.statusCode == 401) {
        faliedLogin(Translate.failed.trans(),
            Translate.canotCompleteThisActionReloginAndRetry.trans(), true);
      }
      return AttendanceModelResponse(status: Status.error, data: []);
    } catch (e) {
      myPrint("error in get attendanc sv $e");
      if (e.toString().contains("TimeoutException") ||
          e.toString().contains("No address associated with hostname")) {
        return AttendanceModelResponse(status: Status.newtworkError, data: []);
      }
      return AttendanceModelResponse(status: Status.error, data: []);
    }
  }

  // _saveEventToLoca(List<AttendanceModel> list) async {
  //   final _db = await database;
  //   list.forEach((model) {
  //     try {
  //       _db.insert(SchedulesTable, model.toJson(),
  //           conflictAlgorithm: ConflictAlgorithm.replace);
  //     } catch (e) {
  //       myPrint("error im save SubjectSchedule to local $e");
  //     }
  //   });
  // }

  // Future<AttendanceModelResponse> _readFromLocalDatabase() async {
  //   List<AttendanceModel> list = [];
  //   // try {
  //   final _db = await database;
  //   final List<Map<dynamic, dynamic>> data = await _db.query(SchedulesTable);

  //   myPrint("mapmapmap  $data ");
  //   if (data.isEmpty) {
  //     return AttendanceModelResponse(data: list, status: Status.noDataFound);
  //   }
  //   data.forEach((key) {
  //     AttendanceModel temp =
  //         AttendanceModel.fromJson(Map<String, dynamic>.from(key), true);
  //     list.add(temp);
  //   });
  //   return AttendanceModelResponse(data: list, status: Status.dataFound);
  //   // } catch (e) {
  //   //   myPrint("error in read events from database$e");
  //   //   return AttendanceModelResponse(data: list, status: Status.error);
  //   // }
  // }
}

AttendanceModelResponse parseCustomerPayments(String responseBody) {
  myPrint(responseBody);
  List<AttendanceModel> list = [];
  var body = jsonDecode(responseBody);
  for (var i = 0; i < body.length; i++) {
    AttendanceModel documentsCostumers =
        AttendanceModel.fromJson(body[i], false);

    list.add(documentsCostumers);
  }
  responseBody = null;
  myPrint("list length in get AttendanceModel ${list.length}");
  body = null;
  if (list.length == 0) {
    return AttendanceModelResponse(status: Status.noDataFound, data: list);
  }
  return AttendanceModelResponse(status: Status.dataFound, data: list);
}
