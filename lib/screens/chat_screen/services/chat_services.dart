import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/repo/constant.dart';
import 'package:testgsschoolst/repo/enums.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/screens/chat_screen/services/person_model.dart';
import 'package:testgsschoolst/widget/alerts/login_status.dart';
import 'package:http/http.dart' as http;

class ChatServices {
  Future<ChatPersonsModelResponse> getSelectedPersonMessages(
      int page, String searchQuery) async {
    try {
      final url =
          "$URL/api/Messages?_start=0&_end=1000";
      myPrint(url);
      http.Response customer = await http
          .get(
            Uri.parse(url),
            headers: getAppHeader(),
          )
          .timeout(DURATION_60);

      myPrint("offers ${customer.statusCode}");
      myPrint("offers ${customer.body}");
      if (customer.statusCode == 200) {
        ChatPersonsModelResponse result =
            await compute(parseCustomerPayments, customer.body);
        return result;
      } else if (customer.statusCode == 401) {
        faliedLogin(Translate.failed.trans(),
            Translate.canotCompleteThisActionReloginAndRetry.trans(), true);
      }
      return ChatPersonsModelResponse(status: Status.error, data: []);
    } catch (e) {
      myPrint("error in get offers sv $e");
      if (e.toString().contains("TimeoutException") ||
          e.toString().contains("No address associated with hostname")) {
        return ChatPersonsModelResponse(status: Status.newtworkError, data: []);
      }
      return ChatPersonsModelResponse(status: Status.error, data: []);
    }
  }
    Future<ChatPersonsModelResponse> getChatPersons(
      int page, String searchQuery) async {
    try {
      final url =
          "$URL/api/Messages?_start=0&_end=1000";
      myPrint(url);
      http.Response customer = await http
          .get(
            Uri.parse(url),
            headers: getAppHeader(),
          )
          .timeout(DURATION_60);

      myPrint("offers ${customer.statusCode}");
      myPrint("offers ${customer.body}");
      if (customer.statusCode == 200) {
        ChatPersonsModelResponse result =
            await compute(parseCustomerPayments, customer.body);
        return result;
      } else if (customer.statusCode == 401) {
        faliedLogin(Translate.failed.trans(),
            Translate.canotCompleteThisActionReloginAndRetry.trans(), true);
      }
      return ChatPersonsModelResponse(status: Status.error, data: []);
    } catch (e) {
      myPrint("error in get offers sv $e");
      if (e.toString().contains("TimeoutException") ||
          e.toString().contains("No address associated with hostname")) {
        return ChatPersonsModelResponse(status: Status.newtworkError, data: []);
      }
      return ChatPersonsModelResponse(status: Status.error, data: []);
    }
  }
}

ChatPersonsModelResponse parseCustomerPayments(String responseBody) {
  myPrint(responseBody);
  List<Messages> list = [];
  var body = jsonDecode(responseBody);
  for (var i = 0; i < body.length; i++) {
    Messages documentsCostumers =
        Messages.fromJson(body[i], MessageStatus.sent);

    list.add(documentsCostumers);
  }
  responseBody = null;
  myPrint("list length in get TopicModel ${list.length}");
  body = null;
  if (list.length == 0) {
    return ChatPersonsModelResponse(status: Status.noDataFound, data: list);
  }
  return ChatPersonsModelResponse(status: Status.dataFound, data: list);
}
