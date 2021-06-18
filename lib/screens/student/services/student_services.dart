import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testgsschoolst/database.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/constant.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/student/services/student_model.dart';
import 'package:http/http.dart' as http;
import 'package:testgsschoolst/widget/alerts/login_status.dart';

class StudentServices {
  saveStudents(List<StudentModel> list) async {
    final _db = await database;
    list.forEach((model) {
      _db.insert(StudentTable, model.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  upDateStudent(StudentModel model) async {
    final _db = await database;
    _db.insert(StudentTable, model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<StudentRequest> getStudents() async {
    try {
      final url = "$URL/api/Students";
      myPrint(url);
      http.Response customer = await http
          .get(Uri.parse(url), headers: getAppHeader())
          .timeout(DURATION_60);
      myPrint("student ${customer.statusCode}");
      myPrint("student ${customer.body}");
      if (customer.statusCode == 200) {
        StudentRequest result =
            await compute(parseCustomerPayments, customer.body);
        saveStudents(result.data);
        return result;
      } else if (customer.statusCode == 401) {
        faliedLogin(Translate.failed.trans(),
            Translate.canotCompleteThisActionReloginAndRetry.trans(), true);
      }
      return StudentRequest(
        status: Status.error,
        data: [],
      );
    } catch (e) {
      myPrint("error in get student sv $e");
      if (e.toString().contains("TimeoutException") ||
          e.toString().contains("No address associated with hostname")) {
        return StudentRequest(status: Status.newtworkError, data: []);
      }
      return StudentRequest(status: Status.error, data: []);
    }
  }
}

StudentRequest parseCustomerPayments(String responseBody) {
  myPrint(responseBody);
  List<StudentModel> list = [];
  var body = jsonDecode(responseBody);
  for (var i = 0; i < body.length; i++) {
    StudentModel documentsCostumers = StudentModel.fromJson(body[i]);

    list.add(documentsCostumers);
  }
  responseBody = null;
  myPrint("list length in get TopicModel ${list.length}");
  body = null;
  if (list.length == 0) {
    return StudentRequest(
      status: Status.noDataFound,
      data: [],
    );
  }
  return StudentRequest(
    status: Status.dataFound,
    data: list,
  );
}
