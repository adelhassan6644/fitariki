import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../request_details/model/offer_request_details_model.dart';
import '../model/my_trips_model.dart';
import '../repo/my_trips_repo.dart';

class MyTripsProvider extends ChangeNotifier {
  MyTripsRepo myTripsRepo;
  MyTripsProvider({required this.myTripsRepo}) {
    if (isLogin) {
      getCurrentTrips();
      getPreviousTrips();
      getPendingTrips();
    }
  }

  bool get isLogin => myTripsRepo.isLoggedIn();

  List<String> taps = [
    "previous",
    "current",
    "pending",
  ];
  int currentTap = 1;

  onSelectTap(index) {
    currentTap = index;
    if (isLogin) {
      switch (index) {
        case 0:
          return getPreviousTrips();
        case 1:
          return getCurrentTrips();
        case 2:
          return getPendingTrips();
      }
    }
    notifyListeners();
  }

  bool isGetCurrentTrips = false;
  List<MyTripModel>? currentTrips;
  getCurrentTrips() async {
    try {
      isGetCurrentTrips = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await myTripsRepo.getMyTrips("current");
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(l),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        currentTrips = [];
        isGetCurrentTrips = false;
        notifyListeners();
      }, (response) {
        currentTrips = response.data["data"]["current"] == null ||
                response.data["data"]["current"] == []
            ? []
            : List<MyTripModel>.from(response.data["data"]["current"]
                .map((x) => MyTripModel.fromJson(x)));

        isGetCurrentTrips = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      isGetCurrentTrips = false;
      notifyListeners();
    }
  }

  bool isGetPreviousTrips = false;
  List<MyTripModel>? previousTrips;
  getPreviousTrips() async {
    try {
      isGetPreviousTrips = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await myTripsRepo.getMyTrips("past");
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(l),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        previousTrips = [];
        isGetPreviousTrips = false;
        notifyListeners();
      }, (response) {
        previousTrips = response.data["data"]["past"] == null ||
                response.data["data"]["past"] == []
            ? []
            : List<MyTripModel>.from(response.data["data"]["past"]
                .map((x) => MyTripModel.fromJson(x)));

        isGetPreviousTrips = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      isGetPreviousTrips = false;
      notifyListeners();
    }
  }

  bool isGetPendingTrips = false;
  List<OfferRequestDetailsModel>? pendingTrips;
  getPendingTrips() async {
    try {
      isGetPendingTrips = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await myTripsRepo.getMyTrips("pending");
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(l),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        pendingTrips = [];
        isGetPendingTrips = false;
        notifyListeners();
      }, (response) {
        pendingTrips = response.data["data"]["pending"] == null ||
                response.data["data"]["pending"] == []
            ? []
            : List<OfferRequestDetailsModel>.from(response.data["data"]
                    ["pending"]
                .map((x) => OfferRequestDetailsModel.fromJson(x)));

        isGetPendingTrips = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      isGetPendingTrips = false;
      notifyListeners();
    }
  }
}
