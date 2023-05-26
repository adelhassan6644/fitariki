import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/features/my_offers/model/my_offer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../../main_models/offer_model.dart';
import '../repo/my_offers_repo.dart';

class MyOffersProvider extends ChangeNotifier {
  MyOffersRepo myOffersRepo;
  MyOffersProvider({required this.myOffersRepo});

  List<MyOfferModle>? offer;
  bool isLoading = false;
  List<String> days=[];
  String? day;
  getMyOffer() async {
    try {
      offer = [];
      isLoading = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await myOffersRepo.getMyOffer();
      response.fold((l) => null, (response) {
        offer = List<MyOfferModle>.from(response.data["data"]["offers"]!
            .map((x) => MyOfferModle.fromJson(x)));
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