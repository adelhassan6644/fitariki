import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../navigation/custom_navigation.dart';


class AppPermissionHandlerService {
  //MANAGE BACKGROUND SERVICE PERMISSION
  Future<bool> handleBackgroundRequest() async {
    //check for permission

    return true;
  }

  //MANAGE LOCATION PERMISSION
  Future<bool> isLocationGranted() async {
    var status = await Permission.locationWhenInUse.status;
    return status.isGranted;
  }

  Future<bool> handleLocationRequest() async {
    var status = await Permission.locationWhenInUse.status;
    //check if location permission is not granted
    if (!status.isGranted) {


      //
      PermissionStatus status = await Permission.locationWhenInUse.request();
      if (status.isGranted) {


        //request for alway in use location
        status = await Permission.locationAlways.request();
        if (!status.isGranted) {
          permissionDeniedAlert();
          print("permissionDeniedAlert");
        }
      } else {
        print("permissionDeniedAlert");
        permissionDeniedAlert();
      }

      if (status.isPermanentlyDenied) {
        //When the user previously rejected the permission and select never ask again
        //Open the screen of settings
        await openAppSettings();
      }
    }
    //location permission is granted
    else {
      //In use is available, check the always in use
      var status = await Permission.locationAlways.status;
      if (!status.isGranted) {


        //request for alway in use location
        var status = await Permission.locationAlways.request();
        if (status.isGranted) {
          //Do some stuff
        } else {
          var status = await Permission.locationAlways.status;
          if (!status.isGranted) {
            print("locationAlways");
            permissionDeniedAlert();
          }
        }
      } else {
        //previously available, do some stuff or nothing
        return true;
      }
    }
    return true;
  }

  //
  void permissionDeniedAlert() async {
    //The user deny the permission
    await Fluttertoast.showToast(
      msg: "Permission denied",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
