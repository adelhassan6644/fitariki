import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../model/my_offer.dart';
import '../repo/my_offers_repo.dart';

class MyOffersProvider extends ChangeNotifier {
  MyOffersRepo myOffersRepo;
  MyOffersProvider({required this.myOffersRepo});

  bool get isLogin => myOffersRepo.isLoggedIn();
  bool get isDriver => myOffersRepo.isDriver();

  MyOffersModel? myOffers;
  bool isLoading = false;

  getMyOffer() async {
    try {
      isLoading = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await myOffersRepo.getMyOffer();
      response.fold((l) => null, (response) {
        myOffers = MyOffersModel.fromJson(response.data["data"]);
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }
  }
}
