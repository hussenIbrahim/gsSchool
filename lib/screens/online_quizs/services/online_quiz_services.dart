import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:testgsschoolst/database.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/constant.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/online_quizs/services/online_quiz_model.dart';
import 'package:testgsschoolst/widget/alerts/login_status.dart';

class OnlineQuizServices {
  Future<OnLineQuizModelResponse> getExamesMidleWares(
      {String studentId, bool isForce}) async {
    myPrint("isForce get subjevts $isForce");
    if (isForce == true) {
      return await _getFromAPI(isForce: isForce, studentId: studentId);
    } else {
      OnLineQuizModelResponse response =
          await _readFromLocalDatabase(studentId);
      myPrint("(response.data.length ${response.data.length} $studentId");
      if (response.data.length == 0) {
        return await _getFromAPI(isForce: isForce, studentId: studentId);
      } else {
        return response;
      }
    }
  }

  Future<OnLineQuizModelResponse> _getFromAPI(
      {String studentId, bool isForce}) async {
    // try {
    final url = "$URL/api/Subjects?_start=0&_end=1000";

    myPrint(url);
    http.Response customer = await http
        .get(Uri.parse(url), headers: getAppHeader())
        .timeout(DURATION_60);

    myPrint("Subject ${customer.statusCode}");
    myPrint("Subject ${customer.body}");
    if (customer.statusCode == 200) {
      OnLineQuizModelResponse result = await compute(
          _parseCustomerPayments,
          ResponseWithStudentId(
              studentId: getUserId(), response: customer.body));
      _saveEventToLoca(result.data);
      return result;
    } else if (customer.statusCode == 401) {
      faliedLogin(Translate.failed.trans(),
          Translate.canotCompleteThisActionReloginAndRetry.trans(), true);
    }
    return OnLineQuizModelResponse(status: Status.error, data: []);
    // } catch (e) {
    //   myPrint("error in get Subject sv $e");
    //   if (e.toString().contains("TimeoutException") ||
    //       e.toString().contains("No address associated with hostname")) {
    //     return OnLineQuizModelResponse(status: Status.newtworkError, data: []);
    //   }
    //   return OnLineQuizModelResponse(status: Status.error, data: []);
    // }
  }

  _saveEventToLoca(List<OnLineQuizModel> list) async {
    final _db = await database;
    list.forEach((model) {
      try {
        _db.insert(SubjectTable, model.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      } catch (e) {
        myPrint("error im save events to local $e");
      }
    });
  }

  Future<OnLineQuizModelResponse> _readFromLocalDatabase(
      String studentId) async {
    List<OnLineQuizModel> list = [];
    try {
      final _db = await database;
      final List<Map<dynamic, dynamic>> data = await _db
          .query(SubjectTable, where: "studentId=?", whereArgs: [studentId]);

      myPrint("mapmapmap  $data");
      if (data.isEmpty) {
        return OnLineQuizModelResponse(data: list, status: Status.noDataFound);
      }
      data.forEach((key) {
        OnLineQuizModel temp =
            OnLineQuizModel.fromJson(Map<String, dynamic>.from(key), true);
        list.add(temp);
      });
      return OnLineQuizModelResponse(data: list, status: Status.dataFound);
    } catch (e) {
      myPrint("error in read events from database$e");
      return OnLineQuizModelResponse(data: list, status: Status.error);
    }
  }
}

OnLineQuizModelResponse _parseCustomerPayments(
    ResponseWithStudentId responseBody) {
  myPrint(responseBody);
  List<OnLineQuizModel> list = [];
  var body = jsonDecode(responseBody.response);
  for (var i = 0; i < body.length; i++) {
    OnLineQuizModel documentsCostumers = OnLineQuizModel.fromJson(
        {...body[i], "studentId": responseBody.studentId}, false);

    list.add(documentsCostumers);
  }
  responseBody = null;
  myPrint("list length in get OnLineQuizModel ${list.length}");
  body = null;
  if (list.length == 0) {
    return OnLineQuizModelResponse(status: Status.noDataFound, data: list);
  }
  return OnLineQuizModelResponse(status: Status.dataFound, data: list);
}

class ResponseWithStudentId {
  String response;
  String studentId;
  ResponseWithStudentId({
    @required this.response,
    @required this.studentId,
  });
}
