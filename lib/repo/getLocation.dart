import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:testgsschoolst/localization/local_keys.dart';
import 'package:testgsschoolst/locator.dart';
import 'package:testgsschoolst/main.dart';
import 'package:testgsschoolst/repo/constant.dart';
import 'package:testgsschoolst/widget/alerts/faliedAlert.dart';
 
 import 'package:location/location.dart';
 import 'package:permission_handler/permission_handler.dart';
import 'package:testgsschoolst/widget/alerts/permsseion_not_allowed_alert.dart';

import '../locator.dart';
 class LatLng{LatLng(this.latitude ,this.longitude);
   double  latitude;
   double longitude ;
 }
class GetLOcationHalper {
  bool isAlertShowing = false;
  Future<LatLng> getNearByOfffers(bool isAlertOpen) async {
    if (position != null) {
      return position;
    }
    try {
      GooglePlayServicesAvailability availability = await GoogleApiAvailability
          .instance
          .checkGooglePlayServicesAvailability();
      myPrint("availability $availability");
      if ([
        GooglePlayServicesAvailability.serviceVersionUpdateRequired,
        GooglePlayServicesAvailability.success,
        GooglePlayServicesAvailability.serviceUpdating
      ].contains(availability)) {
        return await getGoogleServiceDeviceLocation(isAlertOpen);
      } else {
        return  null;
       }
    } catch (e) {
      close(isAlertOpen);
      failedAlert(
          error: Translate.canNotGetTheCurrentLocationRetryAgain.trans());
      return null;
    }
  }

  Future<LatLng> getGoogleServiceDeviceLocation(bool isAlertOpen) async {
    try {
      bool isGpsOn = false;
      bool isGranted =
          (await Permission.location.request().timeout(Duration(seconds: 25)))
              .isGranted;
      if (!isGranted) {
        close(isAlertOpen);
        if (isAlertShowing == false) {
          isAlertShowing = true;
          permissionNotAllowedAlert(
              Translate.appHasNotAccessToLocation.trans());
        }
        return null;
      }
      isGpsOn =
          await geolocator.serviceEnabled().timeout(Duration(seconds: 25));
      if (isGpsOn == false) {
        isGpsOn =
            await geolocator.requestService().timeout(Duration(seconds: 25));
      }
      myPrint("isGpsOn   $isGpsOn");
      if (isGpsOn == true) {
        final _position = await geolocator.getLocation().timeout(DURATION_60);
        position = LatLng(_position.latitude, _position.longitude);
        myPrint(
            "latitude  ${position.latitude}  longitude ${position.longitude}");
        close(isAlertOpen);
         return position;
      } else {
        close(isAlertOpen);
        failedAlert(error: Translate.pleaseEnableGpsToContinue.trans());
        myPrint("falied to save ");
        return position;
      }
    } on Exception catch (e) {
      close(isAlertOpen);
      failedAlert(
          error: Translate.canNotGetTheCurrentLocationRetryAgain.trans());
      myPrint("Exception    in get postion $e");
      return null;
    }
  }

  
  close(bool isAlertOpen) {
    if (isAlertOpen) {
      Navigator.pop(navigatorKey.currentContext);
    }
  }

  Location geolocator = Location();
  LatLng position;
}

double _distanceBetween(
    {double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude}) {
  try {
    var earthRadius = 6378137.0;
    var dLat = _toRadians(endLatitude - startLatitude);
    var dLon = _toRadians(endLongitude - startLongitude);
    myPrint(
        " $startLatitude,  $startLongitude,    $endLatitude,     $endLongitude  $dLon   $dLat");
    var a = pow(sin(dLat / 2), 2) +
        pow(sin(dLon / 2), 2) *
            cos(_toRadians(startLatitude)) *
            cos(_toRadians(endLatitude));
    var c = 2 * asin(sqrt(a));

    return earthRadius * c;
  } catch (e) {
    myPrint("error in _distanceBetween $e");
    return rng.nextInt(100).toDouble();
  }
}

var rng = new Random();

_toRadians(double degree) {
  return degree * pi / 180;
}

double getDistance(double latitude, double longitude, LatLng latLng) {
  if (latitude == 0.0 ||
      latitude == 0 ||
      longitude == 0.0 ||
      longitude == 0 ||
      latLng == null) {
    return rng.nextInt(100).toDouble();
  } else {
    myPrint("getDistanc $latitude,  $longitude,  $latLng");
    return _distanceBetween(
        startLatitude: latLng != null ? latLng.latitude : 36.216495365617504,
        startLongitude: latLng != null ? latLng.longitude : 44.0056583257475,
        endLatitude: latitude,
        endLongitude: longitude);
  }
}
