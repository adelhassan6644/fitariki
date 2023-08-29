import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/failures.dart';
import '../../my_rides/model/my_rides_model.dart';
import '../repo/ride_details_repo.dart';

class RideDetailsProvider extends ChangeNotifier {
  RideDetailsRepo repo;
  RideDetailsProvider({required this.repo});

  bool get isDriver => repo.isDriver();

  MyRideModel? ride;
  bool isLoading = false;
  getRides() async {
    // try {
    isLoading = true;
    notifyListeners();
    Either<ServerFailure, Response> response =
        await repo.getRideDetails(type: "Go", id: 1);
    response.fold((l) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: l.error,
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
    }, (response) {
      ride = MyRideModel.fromJson(response.data["data"]);
    });
    isLoading = false;
    notifyListeners();
    // } catch (e) {
    //   CustomSnackBar.showSnackBar(
    //       notification: AppNotification(
    //           message: ApiErrorHandler.getMessage(e),
    //           isFloating: true,
    //           backgroundColor: Styles.IN_ACTIVE,
    //           borderColor: Colors.transparent));
    //   isLoading = false;
    //   notifyListeners();
    // }
  }

  bool isChanging = false;
  changeStatus(id, status) async {
    // try {
    isChanging = true;
    notifyListeners();
    Either<ServerFailure, Response> response =
        await repo.changeRideStatus(id, status);
    response.fold((l) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: l.error,
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
    }, (response) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: response.data["message"] ?? "",
              isFloating: true,
              backgroundColor: Styles.ACTIVE,
              borderColor: Colors.transparent));
    });
    isChanging = false;
    notifyListeners();
    // } catch (e) {
    //   CustomSnackBar.showSnackBar(
    //       notification: AppNotification(
    //           message: ApiErrorHandler.getMessage(e),
    //           isFloating: true,
    //           backgroundColor: Styles.IN_ACTIVE,
    //           borderColor: Colors.transparent));
    //   isChanging = false;
    //   notifyListeners();
    // }
  }
}
