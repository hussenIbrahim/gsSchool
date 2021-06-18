import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/main.dart';
import 'package:testgsschoolst/repo/constant.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/widget/alerts/faliedAlert.dart';
import 'package:testgsschoolst/widget/alerts/login_status.dart';
import 'package:testgsschoolst/widget/alerts/success_alert.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

class AccountServices {
  Future<bool> editPersonalInfoMiddleWare(
      {String firstName, String middleName, String lastName}) async {
    try {
      //Change EndPoint
      String url = "$URL/api/Accounts/ChangeAccountInfo";
      myPrint({
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName
      });
      final http.Response response = await http
          .post(Uri.parse(url),
              headers: getAppHeader(),
              body: json.encode({
                "firstName": firstName,
                "middleName": middleName,
                "lastName": lastName
              }))
          .timeout(DURATION_60);

      print(response.statusCode);
      print(response.body);
      Navigator.pop(navigatorKey.currentContext);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        Navigator.pop(navigatorKey.currentContext);

        successAlert(message: Translate.personalInformationWasUpdated.trans());

        personalInfoNotifier.upDateName(
            model: personalInfoNotifier.accountModel
              ..firstName = firstName
              ..lastName = lastName
              ..middleName = middleName);
        return true;
      } else if (response.statusCode == 401) {
        faliedLogin(Translate.failed.trans(),
            Translate.unKnownErrorPleaseRelogin.trans(), true);
        return false;
      } else {
        failedAlert(
            error:
                "${json.decode(response.body)['message'] ?? Translate.faliedUpdatePersonalInformation.trans()}");
        return false;
      }
    } on TimeoutException catch (e) {
      Navigator.pop(navigatorKey.currentContext);

      myPrint("error in update personal info $e");
      failedAlert(
          error:
              Translate.faliedUpdatePersonalInfoCheckNetAndRetryAgain.trans());
      return false;
    } on Exception catch (e) {
      Navigator.pop(navigatorKey.currentContext);

      myPrint("error in update personal info $e");

      failedAlert(error: Translate.faliedUpdatePersonalInformation.trans());

      return false;
    }
  }

  Future<void> updateImages({
    String path,
  }) async {
    String url = "$URL/api/Accounts/UploadProfileImage";
    try {
      final response = await dio.Dio().post(
        url,
        options: dio.Options(
            contentType: "multipart/form-data",
            headers: getAppHeader(isImage: true)),
        data: await _formData(path),
        onSendProgress: (received, total) {
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + "%");
          }
        },
      ).timeout(DURATION_60);
      myPrint(response.statusCode.toString());
      myPrint(response.data);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Navigator.pop(navigatorKey.currentContext);

        successAlert(message: Translate.personalInformationWasUpdated.trans());
        personalInfoNotifier.upDateName(
            model: personalInfoNotifier.accountModel
              ..image = "$URL\/" +
                  (response.data
                      .toString()
                      .replaceAll("\\ProfilePics\\", "\/ProfilePics\/")));
        personalInfoNotifier.changeFileImage(null);
        return true;
      } else if (response.statusCode == 401) {
        faliedLogin(Translate.failed.trans(),
            Translate.unKnownErrorPleaseRelogin.trans(), true);
        return false;
      } else {
        failedAlert(
            error:
                "${json.decode(response.data)['message'] ?? Translate.failedUpdateProfilePicRetryAgain.trans()}");
        return false;
      }
    } on dio.DioError catch (e) {
      Navigator.pop(navigatorKey.currentContext);

      final response = e.response;
      print(response.data);
      print(response.statusCode);
      print(response.statusMessage);
      if (response == null) {
        failedAlert(error: Translate.failedUpdateProfilePicRetryAgain.trans());
      } else if (response.statusCode == 401) {
        faliedLogin(Translate.failed.trans(),
            Translate.unKnownErrorPleaseRelogin.trans(), true);
      } else if (response.statusCode == 500) {
        failedAlert(
            error:
                "${json.decode(response.data)['message'] ?? 'Failed to update Image profile'}");
      } else {
        failedAlert(error: Translate.failedUpdateProfilePicRetryAgain.trans());
      }
    } on Exception catch (e) {
      Navigator.pop(navigatorKey.currentContext);

      myPrint(e);
      if (e.toString().contains("TimeoutException")) {
        failedAlert(error: Translate.failedUpdateProfilePicRetryAgain.trans());
      }
      failedAlert(error: Translate.failedUpdateProfilePicRetryAgain.trans());
    }
  }

  Future<dio.FormData> _formData(String path) async {
    return dio.FormData.fromMap({
      "file": await dio.MultipartFile.fromFile("$path",
          filename: "${path.split('/').last}"),
    });
  }
}
