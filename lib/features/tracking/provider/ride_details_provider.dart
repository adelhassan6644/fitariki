import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/components/loading_dialog.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../my_rides/model/my_rides_model.dart';
import '../repo/ride_details_repo.dart';

class RideDetailsProvider extends ChangeNotifier {
  RideDetailsRepo repo;
  RideDetailsProvider({required this.repo});

  bool get isDriver => repo.isDriver();
  late Timer timer;
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
  getRides(id) async {
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

  bool isChanging = false;
  changeStatus(
    id,
    status,
  ) async {
    try {
      ///Show Loading dialog
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
}
