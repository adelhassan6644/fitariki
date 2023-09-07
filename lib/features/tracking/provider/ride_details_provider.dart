import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:georange/georange.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../components/loading_dialog.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../../navigation/routes.dart';
import '../../my_rides/model/my_rides_model.dart';
import '../repo/ride_details_repo.dart';
import '../repo/tracking_repo.dart';

class RideDetailsProvider extends ChangeNotifier {
  RideDetailsRepo repo;
  TrackingRepo trackingRepo;
  RideDetailsProvider({required this.repo, required this.trackingRepo});

  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  bool get isDriver => repo.isDriver();

  late Timer timer;
  Timer? _dropOffTimer;
  Timer? _pickUpTimer;
  int count = 0;

  countTime() {
    count = 0;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      ++count;
      notifyListeners();
    });
  }

  MyRideModel? ride;
  bool isLoading = false;
  getRideDetails(id) async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await repo.getRideDetails(id);
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: l.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (response) {
        ride = MyRideModel.fromJson(response.data["data"]);

        pickUpLocationListener(LatLng(
            double.parse(ride?.pickupLocation?.latitude ?? "0"),
            double.parse(ride?.pickupLocation?.longitude ?? "0")));

        dropLocationListener(LatLng(
            double.parse(ride?.dropOffLocation?.latitude ?? "0"),
            double.parse(ride?.dropOffLocation?.longitude ?? "0")));

        changeStatusFireBase(id, ride?.status);

        changeStatusTripListener(id);
      });
      isLoading = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }
  }

  ///Start listening to Trip status changes
  void changeStatusTripListener(id) async {
    firebaseFireStore
        .collection("Rides")
        .doc("ride#$id")
        .snapshots()
        .listen((event) {
      if (!event.exists) {
        return;
      }

      if (event.data() != null) {
        ride?.status = event.data()!["status"];
        if (ride?.status == 3) {
          ///To stop tracking
          if (isDriver) {
            trackingRepo.stopPushLocation();
          }
          CustomNavigator.push(Routes.RATE_RIDE,
              arguments: {
                "id": id,
                "name": isDriver
                    ? ride?.client?.firstName ?? ""
                    : ride?.driver?.firstName ?? "",
                "number": ride?.remainingNumber ?? 0
              },
              clean: true);
          deleteRideFireBase(id);
        }
        notifyListeners();
      }
    });
  }

  ///To Add Ride from firebase store DB
  changeStatusFireBase(id, status) async {
    await firebaseFireStore
        .collection("Rides")
        .doc("ride#$id")
        .set({"id": id, "status": status});
  }

  ///To Delete Ride from firebase store DB
  deleteRideFireBase(id) async {
    await firebaseFireStore.collection("Rides").doc("ride#$id").delete();
  }

  bool isChanging = false;
  changeStatus(id, status) async {
    try {
      ///Show Loading dialog if client want to end ride
      if (!isDriver) {
        Future.delayed(Duration.zero, () => spinKitDialog());
      }

      isChanging = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await repo.changeRideStatus(id: id, status: status, count: count);
      response.fold((l) {
        showToast(l.error);
      }, (response) {
        showToast(response.data["message"] ?? "");
        ride?.status = status;
        changeStatusFireBase(id, status);

        if (status == 3) {
          ///To stop tracking
          if (isDriver) {
            trackingRepo.stopPushLocation();
          }
          CustomNavigator.push(Routes.RATE_RIDE,
              arguments: {
                "id": id,
                "name": isDriver
                    ? ride?.client?.firstName ?? ""
                    : ride?.driver?.firstName ?? "",
                "number": ride?.remainingNumber ?? 0
              },
              clean: true);
          deleteRideFireBase(id);
        }

        ///To start tracking
        if (status == 0) {
          trackingRepo.startPushLocation();
        }
      });

      ///Hide Loading dialog
      if (!isDriver) {
        CustomNavigator.pop();
      }
      isChanging = false;
      notifyListeners();
    } catch (e) {
      ///Hide Loading dialog
      if (!isDriver) {
        CustomNavigator.pop();
      }
      showToast(e);
      isChanging = false;
      notifyListeners();
    }
  }

  BehaviorSubject<String> dropLocationStream = BehaviorSubject<String>();
  dropLocationListener(LatLng latLng) async {
    _dropOffTimer?.cancel();
    _dropOffTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      calculatedETAToDropLocation(latLng);
    });
  }

  calculatedETAToDropLocation(LatLng dropOffLatLng) async {
    Position currentLocation = await Geolocator.getCurrentPosition();
    final startPoint = Point(
      latitude: currentLocation.latitude,
      longitude: currentLocation.longitude,
    );
    final endPoint = Point(
      latitude: dropOffLatLng.latitude,
      longitude: dropOffLatLng.longitude,
    );
    final distance = GeoRange().distance(startPoint, endPoint);
    double timeInHours = distance / ((currentLocation.speed * 3.6));
    final timeInMin = (timeInHours * 60).ceil();
    dropLocationStream.add("$timeInMin min - $distance km");
  }

  BehaviorSubject<String> pickUpLocationStream = BehaviorSubject<String>();
  pickUpLocationListener(LatLng latLng) async {
    _pickUpTimer?.cancel();
    _pickUpTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      calculatedETAToPickUpLocation(latLng);
    });
  }

  calculatedETAToPickUpLocation(LatLng pickUpLatLng) async {
    Position currentLocation = await Geolocator.getCurrentPosition();
    final startPoint = Point(
      latitude: currentLocation.latitude,
      longitude: currentLocation.longitude,
    );
    final endPoint = Point(
      latitude: pickUpLatLng.latitude,
      longitude: pickUpLatLng.longitude,
    );
    final distance = GeoRange().distance(startPoint, endPoint);
    print("distance$distance");
    double timeInHours = distance / ((currentLocation.speed * 3.6));
    final timeInMin = (timeInHours * 60).ceil();
    pickUpLocationStream.add("$timeInMin min - $distance km");
  }

  void disposeTimer() {
    _pickUpTimer?.cancel();
    _dropOffTimer?.cancel();
    timer.cancel();
    super.dispose();
  }
}
