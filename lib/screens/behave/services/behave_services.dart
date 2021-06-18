import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/repo/constant.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/screens/behave/services/behave_model.dart';
import 'package:testgsschoolst/widget/alerts/login_status.dart';

class BehaveServices {
  Future<BehaveModelResponse> getChatPersons(int page) async {
    // if (connectionNotifer.isConnected == false) {
    //   return await _readFromLocalDatabase();
    // }
    try {
      myPrint(connectionNotifer.isConnected);
      final url =
          "$URL/api/StudentBehaves?_start=0&_end=1000";

      myPrint(url);
      http.Response customer = await http
          .get(Uri.parse(url), headers: getAppHeader())
          .timeout(DURATION_60);

      myPrint("Evetns ${customer.statusCode}");
      myPrint("Evetns ${customer.body}");
      if (customer.statusCode == 200) {
        BehaveModelResponse result =
            await compute(parseCustomerPayments, customer.body);
        // _saveEventToLoca(result.data);
        return result;
      } else if (customer.statusCode == 401) {
        faliedLogin(Translate.failed.trans(),
            Translate.canotCompleteThisActionReloginAndRetry.trans(), true);
      }
      return BehaveModelResponse(status: Status.error, data: []);
    } catch (e) {
      myPrint("error in get Evetns sv $e");
      if (e.toString().contains("TimeoutException") ||
          e.toString().contains("No address associated with hostname")) {
        return BehaveModelResponse(status: Status.newtworkError, data: []);
      }
      return BehaveModelResponse(status: Status.error, data: []);
    }
  }

  // _saveEventToLoca(List<BehaveModel> list) async {
  //   final _db = await database;
  //   list.forEach((model) {
  //     try {
  //       _db.insert(Behav, model.toJson(),
  //           conflictAlgorithm: ConflictAlgorithm.replace);
  //     } catch (e) {
  //       myPrint("error im save events to local $e");
  //     }
  //   });
  // }

  // Future<BehaveModelResponse> _readFromLocalDatabase() async {
  //   List<BehaveModel> list = [];
  //   // try {
  //   final _db = await database;
  //   final List<Map<dynamic, dynamic>> data = await _db.query(EventsTable);

  //   myPrint("mapmapmap  $data");
  //   if (data.isEmpty) {
  //     return BehaveModelResponse(data: list, status: Status.noDataFound);
  //   }
  //   data.forEach((key) {
  //     BehaveModel temp =
  //         BehaveModel.fromJson(Map<String, dynamic>.from(key), true);
  //     list.add(temp);
  //   });
  //   return BehaveModelResponse(data: list, status: Status.dataFound);
  //   // } catch (e) {
  //   //   myPrint("error in read events from database$e");
  //   //   return BehaveModelResponse(data: list, status: Status.error);
  //   // }
  // }
}

BehaveModelResponse parseCustomerPayments(String responseBody) {
  myPrint(responseBody);
  List<BehaveModel> list = [];
  var body = jsonDecode(responseBody);
  for (var i = 0; i < body.length; i++) {
    BehaveModel documentsCostumers = BehaveModel.fromJson(body[i], false);

    list.add(documentsCostumers);
  }
  responseBody = null;
  myPrint("list length in get BehaveModel ${list.length}");
  body = null;
  if (list.length == 0) {
    return BehaveModelResponse(status: Status.noDataFound, data: list);
  }
  return BehaveModelResponse(status: Status.dataFound, data: list);
}
