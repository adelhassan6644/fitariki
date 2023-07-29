import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../../main_models/offer_model.dart';
import '../../feedback/model/feedback_model.dart';
import '../repo/offer_details_repo.dart';

class OfferDetailsProvider extends ChangeNotifier {
  OfferDetailsRepo repo;
  OfferDetailsProvider({required this.repo});

  bool get isLogin => repo.isLoggedIn();
  bool get isDriver => repo.isDriver();

  bool isLoading = false;
  OfferModel? offerDetails;

  getOfferDetails({
    required int offerId,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await repo.getOfferDetails(
        offerId: offerId,
      );
      response.fold((l) => null, (response) {
        offerDetails = OfferModel.fromJson(response.data["data"]["offer"]);
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
}
