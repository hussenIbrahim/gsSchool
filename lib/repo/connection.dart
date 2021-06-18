import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:testgsschoolst/locator.dart';

class ConnectionNotifer extends ChangeNotifier {
  bool isConnected = false;
  bool isFirstOpen = true;
  ConnectionNotifer() {
    _checConnectionFirstTIme();
  }

  StreamSubscription<ConnectivityResult> _connectivityResult;
  startListen() async {
    await _connectivityResult?.cancel();
    checConnection();
    _connectivityResult = Connectivity().onConnectivityChanged.listen(onData);
  }

  onData(ConnectivityResult t) {
    myPrint("onConnectivityChanged  $t");
    checConnection();
  }

  checConnection() async {
    try {
      ConnectivityResult value = await Connectivity()
          .checkConnectivity()
          .timeout(Duration(seconds: 5));
      myPrint("checkConnectivity $value");
      if (value == ConnectivityResult.mobile ||
          value == ConnectivityResult.wifi) {
        isConnected = true;
        showToast();
      } else {
        isConnected = false;
        showToast();
      }
      notifyListeners();
    } catch (e) {
      isConnected = false;
      showToast();
      notifyListeners();
      myPrint("$e");
    }
    myPrint("isConnected  $isConnected");
  }

  showToast() {
    if (isFirstOpen == true || isConnected == true) {
      isFirstOpen = false;
      return;
    }
    showSimpleNotification(
      Text(isConnected == false
          ? "You Have not internet connection, Local data will be displayed"
          : "internet connection was back please refresh to see new data"),
      background: Colors.green,
      autoDismiss: false,
      trailing: Builder(builder: (context) {
        return TextButton(
            onPressed: () {
              OverlaySupportEntry.of(context)?.dismiss();
            },
            child: Text('Ok', style: TextStyle(color: Colors.amber)));
      }),
    );
  }

  _checConnectionFirstTIme() async {
    try {
      ConnectivityResult value = await Connectivity()
          .checkConnectivity()
          .timeout(Duration(seconds: 5));

      if (value == ConnectivityResult.mobile ||
          value == ConnectivityResult.wifi) {
        isConnected = true;
      } else {
        isConnected = false;
      }
      notifyListeners();
    } catch (e) {
      isConnected = false;
      notifyListeners();
      myPrint("$e");
    }
    myPrint("isConnected  $isConnected");
  }
}
