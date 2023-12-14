import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../model/my_trips_model.dart';
import '../repo/my_trips_repo.dart';

class CurrentTripDetailsProvider extends ChangeNotifier {
  MyTripsRepo repo;
  CurrentTripDetailsProvider({required this.repo});

  bool get isDriver => repo.isDriver();

  bool isLoading = false;
  MyTripModel? tripDetails;
  getCurrentTripDetails(id) async {
    try {
      tripDetails = null;
      isLoading = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await repo.getCurrentTripDetails(id);
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(l),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (response) {
        tripDetails = MyTripModel.fromJson(response.data["data"]);
      });

      isLoading = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }
  }
}
