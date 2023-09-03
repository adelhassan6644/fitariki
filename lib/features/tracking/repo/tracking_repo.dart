import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_location/fl_location.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:georange/georange.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/core/utils/app_storage_keys.dart';
import '../../../app/core/utils/app_strings.dart';
import '../../../app/location_services/app_permission_handler.service.dart';
import '../../../data/config/di.dart';
import '../../../data/dio/dio_client.dart';

class TrackingRepo {
  SharedPreferences sharedPreferences = sl.get<SharedPreferences>();

  // TrackingRepo({required this.dioClient, required this.sharedPreferences});
  isDriver() {
    return sharedPreferences.getString(AppStorageKey.role) == "driver";
  }

  //
  GeoRange georange = GeoRange();

  Location? currentLocationData;
  Location? currentLocation;
  bool? serviceEnabled;
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  BehaviorSubject<bool> locationDataAvailable =
      BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<double> driverLocationEarthDistance =
      BehaviorSubject<double>.seeded(0.00);
  int lastUpdated = 0;
  StreamSubscription? locationUpdateStream;

  //
  Future<void> prepareLocationListener() async {
    //handle missing permission
    await handlePermissionRequest();
    _startLocationListner();
  }

  Future<bool> handlePermissionRequest({bool background = false}) async {
    if (!await FlLocation.isLocationServicesEnabled) {
      throw "Location service is disabled. Please enable it and try again";
    }

    var locationPermission = await FlLocation.checkLocationPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      // Cannot request runtime permission because location permission is denied forever.
      throw "Location permission denied permanetly. Please check on location permission on app settings";
    } else if (locationPermission == LocationPermission.denied) {
      // Ask the user for location permission.
      locationPermission = await FlLocation.requestLocationPermission();
      if (locationPermission == LocationPermission.denied ||
          locationPermission == LocationPermission.deniedForever) {
        throw "Location permission denied. Please check on location permission on app settings";
      }
    }

    // Location permission must always be allowed (LocationPermission.always)
    // to collect location data in the background.
    if (background == true &&
        locationPermission == LocationPermission.whileInUse) {
      return false;
    }

    // Location services has been enabled and permission have been granted.
    return true;
  }

  Stream getNewLocationStream() {
    return FlLocation.getLocationStream(
      interval: AppStrings.timePassLocationUpdate,
      distanceFilter: AppStrings.distanceCoverLocationUpdate,
    ).handleError((error) {
      print("Location listen error => $error");
    });
  }

  void _startLocationListner() async {
    //

    //listen
    locationUpdateStream?.cancel();
    locationUpdateStream = getNewLocationStream().listen((currentPosition) {
      //
      if (currentPosition != null) {
        print("Location changed ==> $currentPosition");
        // Use current location
        if (currentLocation == null) {
          currentLocationData = currentPosition;
          locationDataAvailable.add(true);
        }

        currentLocationData = currentPosition;
        //
        syncLocationWithFirebase(currentPosition);
      }
    });
  }

//
  syncCurrentLocFirebase() {
    if (currentLocationData != null) {
      syncLocationWithFirebase(currentLocationData!);
    }
  }

  //
  syncLocationWithFirebase(Location currentLocation) async {
    final driverId = sharedPreferences.getString(AppStorageKey.userId);
    //
    {
      log("Send to fcm");
      Point driverLocation = Point(
        latitude: currentLocation.latitude ?? 0.00,
        longitude: currentLocation.longitude ?? 0.00,
      );
      Point earthCenterLocation = Point(
        latitude: 0.00,
        longitude: 0.00,
      );
      //
      var earthDistance =
          georange.distance(earthCenterLocation, driverLocation);

      //
      final driverLocationDocs =
          await firebaseFireStore.collection("drivers").doc(driverId).get();

      //
      final docRef = driverLocationDocs.reference;

      if (driverLocationDocs.data() == null) {
        docRef.set(
          {
            "id": driverId,
            "lat": currentLocation.latitude,
            "long": currentLocation.longitude,
            "rotation": currentLocation.heading,
            "earth_distance": earthDistance,
          },
        );
      } else {
        docRef.update(
          {
            "id": driverId,
            "lat": currentLocation.latitude,
            "long": currentLocation.longitude,
            "rotation": currentLocation.heading,
            "earth_distance": earthDistance,
          },
        );
      }

      driverLocationEarthDistance.add(earthDistance);
      lastUpdated = DateTime.now().millisecondsSinceEpoch;
    }
  }

  startPushLocation() async {
    final permitted =
        await AppPermissionHandlerService().handleLocationRequest();
    if (!permitted) {
      return;
    }
    await TrackingRepo().prepareLocationListener();

    //
    if (Platform.isAndroid) {
      //
      const androidConfig = FlutterBackgroundAndroidConfig(
        notificationTitle: "Background service",
        notificationText: "Background notification to keep app running",
        notificationImportance: AndroidNotificationImportance.Default,
        notificationIcon: AndroidResource(
          name: 'notification_icon',
          defType: 'drawable',
        ), // Default is ic_launcher from folder mipmap
      );

      //check for permission
      //CALL THE PERMISSION HANDLER
      final allowed =
          await AppPermissionHandlerService().handleBackgroundRequest();
      //
      if (allowed) {
        await FlutterBackground.initialize(androidConfig: androidConfig);
        await FlutterBackground.enableBackgroundExecution();
      }
    }
  }

  void stopPushLocation() {
    // Platform.isAndroid
    if (Platform.isAndroid) {
      bool enabled = FlutterBackground.isBackgroundExecutionEnabled;
      if (enabled) {
        FlutterBackground.disableBackgroundExecution();
      }
    }
    locationUpdateStream?.cancel();

  }
}
