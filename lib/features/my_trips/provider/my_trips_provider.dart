import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../model/my_trips_model.dart';
import '../repo/my_trips_repo.dart';

class MyTripsProvider extends ChangeNotifier {
  MyTripsRepo myTripsRepo;
  MyTripsProvider({required this.myTripsRepo});

  List<String> taps = [
    "past",
    "current",
    "pending",
  ];
  int currentTap = 0;

  onSelectTap(index) {
    currentTap = index;
    getMYTrips();
    notifyListeners();
  }

  bool isLoading = false;
  List<MyTripModel>? myTrips;

  getMYTrips() async {
    try {
      isLoading = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await myTripsRepo.getMyTrips(taps[currentTap]);
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(l),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        myTrips = [];
        isLoading = false;
        notifyListeners();
      }, (response) {
        myTrips = response.data["data"][taps[currentTap]] == null ||
                response.data["data"][taps[currentTap]] == []
            ? []
            : List<MyTripModel>.from(response.data["data"][taps[currentTap]]
                .map((x) => MyTripModel.fromJson(x)));

        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }
  }
}
