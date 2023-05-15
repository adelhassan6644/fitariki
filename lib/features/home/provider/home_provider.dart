import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/main_models/offer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../repo/home_repo.dart';


class HomeProvider extends ChangeNotifier{
  HomeRepo homeRepo;
  HomeProvider({required this.homeRepo});

  bool isLoading = false;
  List<OfferModel>? offer;
  getOffers() async {
    try{
      offer = [];
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await homeRepo.getOffer();
      response.fold((l) => null, (response) {
        offer = List<OfferModel>.from(response.data["data"]["offers"]!.map((x) => OfferModel.fromJson(x)));
        isLoading = false;
        notifyListeners();
      });
    }catch (e) {
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