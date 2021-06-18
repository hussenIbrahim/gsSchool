import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testgsschoolst/database.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/repo/constant.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/screens/events/services/event_model.dart';
import 'package:testgsschoolst/screens/subjects/services/subjects_services.dart';
import 'package:testgsschoolst/widget/alerts/login_status.dart';
import 'package:http/http.dart' as http;

class EventsServices {
  Future<EventModelResponse> getEventMiddleWare(  bool forceGet) async {
    if (forceGet == true) {
      myPrint("from api");
      return await _getEvents( );
    }

    EventModelResponse formLocal = await _readFromLocalDatabase();

    if (formLocal.data.length == 0) {
      myPrint("from api");
      return await _readFromLocalDatabase();
    } else {
      myPrint("from locao");
      return formLocal;
    }
  }

  Future<EventModelResponse> _getEvents( ) async {
    try {
      final url =
          "$URL/api/Events?_start=0&_end=1000";

      myPrint(url);
      http.Response customer = await http
          .get(Uri.parse(url), headers: getAppHeader())
          .timeout(DURATION_60);

      myPrint("Evetns ${customer.statusCode}");
      myPrint("Evetns ${customer.body}");
      if (customer.statusCode == 200) {
        EventModelResponse result = await compute(
            parseCustomerPayments,
            ResponseWithStudentId(
                response: customer.body, studentId: getUserId()));
        _saveEventToLoca(result.data);
        return result;
      } else if (customer.statusCode == 401) {
        faliedLogin(Translate.failed.trans(),
            Translate.canotCompleteThisActionReloginAndRetry.trans(), true);
      }
      return EventModelResponse(status: Status.error, data: []);
    } catch (e) {
      myPrint("error in get Evetns sv $e");
      if (e.toString().contains("TimeoutException") ||
          e.toString().contains("No address associated with hostname")) {
        return EventModelResponse(status: Status.newtworkError, data: []);
      }
      return EventModelResponse(status: Status.error, data: []);
    }
  }

  _saveEventToLoca(List<EventModel> list) async {
    final _db = await database;
    list.forEach((model) {
      try {
        _db.insert(EventsTable, model.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      } catch (e) {
        myPrint("error im save events to local $e");
      }
    });
  }

  Future<EventModelResponse> _readFromLocalDatabase() async {
    List<EventModel> list = [];
    try {
      final _db = await database;
      final List<Map<dynamic, dynamic>> data = await _db.query(EventsTable);

      myPrint("mapmapmap  $data");
      if (data.isEmpty) {
        return EventModelResponse(data: list, status: Status.noDataFound);
      }
      data.forEach((key) {
        EventModel temp =
            EventModel.fromJson(Map<String, dynamic>.from(key), true);
        list.add(temp);
      });
      return EventModelResponse(data: list, status: Status.dataFound);
    } catch (e) {
      myPrint("error in read events from database$e");
      return EventModelResponse(data: list, status: Status.error);
    }
  }
}

EventModelResponse parseCustomerPayments(ResponseWithStudentId responseBody) {
  myPrint(responseBody);
  List<EventModel> list = [];
  var body = jsonDecode(responseBody.response);
  for (var i = 0; i < body.length; i++) {
    EventModel documentsCostumers = EventModel.fromJson(body[i], false);

    list.add(documentsCostumers);
  }
  responseBody = null;
  myPrint("list length in get EventModel ${list.length}");
  body = null;
  if (list.length == 0) {
    return EventModelResponse(status: Status.noDataFound, data: list);
  }
  return EventModelResponse(status: Status.dataFound, data: list);
}
