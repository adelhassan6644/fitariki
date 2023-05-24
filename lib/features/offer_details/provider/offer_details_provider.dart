import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/main_models/offer_model.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/svg_images.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../../main_models/offer_details_model.dart';
import '../../maps/models/location_model.dart';
import '../repo/offer_details_repo.dart';

class OfferDetailsProvider extends ChangeNotifier {
  OfferDetailsRepo repo;
  OfferDetailsProvider({required this.repo});



  bool isLoading = false;
  OfferDetailsModel? offerDetails;
  List<String> days=[];
  String? day;
  getOfferDetails({int? offerId,}) async {
    try {

      isLoading = true;
      notifyListeners();
      days=[];
      Either<ServerFailure, Response> response = await repo.getOfferDetails(
      offerID: offerId);
      response.fold((l) => null, (response) {
        offerDetails=OfferDetailsModel.fromJson(response.data["data"]["offer"]);
        offerDetails!.offerDays!.forEach((element) {
          days.add(element.dayName!);
        });
        day =days.toString().replaceAll("[", '').replaceAll(']', '');
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
