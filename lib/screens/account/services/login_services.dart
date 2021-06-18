import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/main.dart';
import 'package:testgsschoolst/repo/constant.dart';
import 'package:testgsschoolst/screens/account/services/account_model.dart';
import 'package:testgsschoolst/screens/account/services/multi_account_services.dart';
import 'package:testgsschoolst/screens/home_screen.dart';
import 'package:testgsschoolst/widget/alerts/faliedAlert.dart';
import 'package:testgsschoolst/widget/alerts/login_status.dart';
import 'package:testgsschoolst/widget/alerts/success_alert.dart';

class LoginServices {
  Future<void> logIn({String username, String password}) async {
    myPrint("username #$username#  password #$password#");
    try {
         DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      String deviceModel = "";
      String paltform = "";
      if (Platform.isAndroid) {
        paltform = "Android";
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceModel = "${androidInfo.model}";
      } else if (Platform.isIOS) {
        paltform = "iOS";
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceModel = "${iosInfo.model}";
      }
      String url =
          "$URL/api/Accounts/authenticate?platform=$paltform&device=$deviceModel";

      myPrint(url);
      final Response response = await http
          .post(Uri.parse(url),
              headers: {
                'Accept': 'text/plain',
                'Content-type': "application/json",
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Methods":
                    "POST, GET, OPTIONS, PUT, DELETE, HEAD",
              },
              body: json.encode({
                "userName": username,
                "password": password,
                "rememberMe": true,
                "fcmNotificationToken": "string"
              }))
          .timeout(Duration(seconds: 15));
      myPrint(response.statusCode);
      myPrint(response.body);
      Navigator.pop(navigatorKey.currentContext);
      if (response.statusCode == 200) {
try{
        final body = jsonDecode(response.body);
        myPrint("body  $body   ${response.statusCode}");
        AccountModel userClass =
            AccountModel.fromJson({...body, "userName": username}, false);
        MultuAccountServices loginServices = locator<MultuAccountServices>();
        loginServices.upDateStudent(userClass);
        personalInfoNotifier.upDateAccountModel(userClass);
        Navigator.pushAndRemoveUntil(navigatorKey.currentContext,
            MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
}catch(e){
myPrint("error in login parse $e");
}
      } else if (response.statusCode == 401) {
        faliedLogin("failed", "wrong username or password", false);
      } else {
        faliedLogin("failed", "Login failed duo to unknown error", false);
      }
    } on TimeoutException catch (e) {
      //recordError(e);
      Navigator.pop(navigatorKey.currentContext);

      myPrint(e);

      faliedLogin(
          "failed", "check your internet connection and retry again", false);
    } on Exception catch (e) {
      //recordError(e);
      Navigator.pop(navigatorKey.currentContext);

      myPrint(e);
      faliedLogin("failed", "retry again", false);
    }
  }

  Future<void> addNewAccount({String username, String password}) async {
    myPrint("username #$username#  password #$password#");
    try {
      String url = "$URL/login";
      myPrint(url);
      final Response response = await http
          .post(Uri.parse(url),
              headers: {
                'Accept': 'text/plain',
                'Content-type': "application/json",
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Methods":
                    "POST, GET, OPTIONS, PUT, DELETE, HEAD",
              },
              body: json.encode({
                "userName": username,
                "password": password,
                "rememberMe": true,
                "fcmNotificationToken": "string"
              }))
          .timeout(Duration(seconds: 15));
      myPrint(response.statusCode);
      myPrint(response.body);
      Navigator.pop(navigatorKey.currentContext);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        myPrint("body  $body   ${response.statusCode}");
        AccountModel userClass =
            AccountModel.fromJson({...body, "userName": username}, false);
        MultuAccountServices loginServices = locator<MultuAccountServices>();
        loginServices.saveStudents([userClass..isPrimary = false]);
        personalInfoNotifier.addAccountModel(userClass..isPrimary = false);
        successAlert(message: "account was added");
      } else if (response.statusCode == 401) {
        faliedLogin("failed", "wrong username or password", false);
      } else {
        faliedLogin("failed", "Login failed duo to unknown error", false);
      }
    } on TimeoutException catch (e) {
      //recordError(e);
      Navigator.pop(navigatorKey.currentContext);

      myPrint(e);

      faliedLogin(
          "failed", "check your internet connection and retry again", false);
    } on Exception catch (e) {
      //recordError(e);
      Navigator.pop(navigatorKey.currentContext);

      myPrint(e);
      faliedLogin("failed", "retry again", false);
    }
  }

  Future<bool> changePasswordMiddleWare({Map<String, dynamic> data}) async {
    try {
      myPrint(data);
      String url = "$URL/api/Accounts/ChangePassword";
      final Response response = await http
          .post(Uri.parse(url),
              headers: getAppHeader(), body: json.encode(data))
          .timeout(DURATION_60);
      myPrint(response.statusCode);
      myPrint(response.body);
      Navigator.pop(navigatorKey.currentContext);
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        Navigator.pop(navigatorKey.currentContext);
        successAlert(message: "your password was updated");

        return true;
      } else if (response.statusCode == 401) {
        faliedLogin("failed", "Login again and retry", false);
        return false;
      } else {
        try {
          failedAlert(
              error:
                  "${json.decode(response.body)['message'] ?? 'failed to update passwrod'}");
          return false;
        } catch (e) {
          //recordError(e);
          failedAlert(error: 'failed to update passwrod');
          return false;
        }
      }
    } on Exception catch (e) {
      //recordError(e);
      Navigator.pop(navigatorKey.currentContext);

      myPrint(e.toString());
      if (e.toString().contains("TimeoutException")) {
        failedAlert(
            error:
                "Failed to update password,\ncheck you internet connection and retry");
        return false;
      }
      failedAlert(error: "Failed to update password");
      return false;
    }
  }

  Future<void> resetPassword({String phoneNumber}) async {
    myPrint("phoneNumber #$phoneNumber#  ");
    try {
      String url = "$URL/api/Accounts/authenticate";

      final Response response = await http
          .post(Uri.parse(url),
              headers: {
                'Accept': 'text/plain',
                'Content-type': "application/json",
                "Access-Control_Allow_Origin": "*"
              },
              body: json.encode({"phoneNumber": phoneNumber}))
          .timeout(Duration(seconds: 15));
      myPrint(response.statusCode);
      myPrint(response.body);
      Navigator.pop(navigatorKey.currentContext);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        myPrint("body  $body   ${response.statusCode}");
      } else if (response.statusCode == 401) {
        failedAlert(
          error: "Can't send reset password code",
        );
      } else {
        try {
          failedAlert(
              error:
                  "${json.decode(response.body)['message'] ?? 'failed to reset passwrod'}");
        } catch (e) {
          //recordError(e);
          failedAlert(error: 'failed to reset passwrod');
        }
      }
    } on TimeoutException catch (e) {
      //recordError(e);
      Navigator.pop(navigatorKey.currentContext);

      myPrint(e);

      failedAlert(
        error:
            "Can't send reset password code.\ncheck your internet connection and retry again",
      );
    } on Exception catch (e) {
      //recordError(e);
      Navigator.pop(navigatorKey.currentContext);

      myPrint(e);
      failedAlert(
        error: "Can't send reset password code",
      );
    }
  }

  Future<bool> sendCode({String phone}) async {
    try {
      String url = "$URL/api/Accounts/SendVerificationCode?phoneNumber=$phone";

      final Response response = await http
          .post(Uri.parse(url),
              headers: {
                'Accept': 'text/plain',
                'Content-type': "application/json"
              },
              body: json.encode({
                "phone": phone,
              }))
          .timeout(Duration(seconds: 15));
      myPrint(response.statusCode);
      myPrint(response.body);
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        final body = jsonDecode(response.body);
        myPrint("body  $body   ${response.statusCode}");

        return true;
      } else if (response.statusCode == 401) {
        faliedLogin("failed", "wrong username or password", false);
        return false;
      } else {
        faliedLogin("failed", "wrong username or password", false);
        return false;
      }
    } on TimeoutException catch (e) {
      //recordError(e);
      myPrint(e);

      faliedLogin(
          "failed", "check your internet connection and retry again", false);
      return false;
    } on Exception catch (e) {
      //recordError(e);
      myPrint(e);
      faliedLogin("failed", "retry again", false);
      return false;
    }
  }
}
