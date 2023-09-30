import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/navigation/routes.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../components/loading_dialog.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../../main_models/offer_model.dart';
import '../../../navigation/custom_navigation.dart';
import '../../request_details/model/offer_request_details_model.dart';
import '../model/my_offer.dart';
import '../repo/my_offers_repo.dart';

class MyOffersProvider extends ChangeNotifier {
  MyOffersRepo myOffersRepo;
  MyOffersProvider({required this.myOffersRepo});

  bool get isLogin => myOffersRepo.isLoggedIn();
  bool get isDriver => myOffersRepo.isDriver();

  List<String> taps = [
    "delivery_offers",
    "delivery_requests",
  ];
  int currentTap = 0;

  onSelectTap(index) {
    currentTap = index;
    if (isLogin) {
      switch (index) {
        case 0:
          return getPendingTrips();
        case 1:
          return getMyOffers();
      }
    }
    notifyListeners();
  }

  bool isGetPendingTrips = false;
  List<OfferRequestDetailsModel>? pendingTrips;
  getPendingTrips() async {
    try {
      isGetPendingTrips = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await myOffersRepo.getMyRequests();
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(l),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
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
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isGetPendingTrips = false;
      notifyListeners();
    }
  }

  MyOffersModel? myOffers;
  bool isLoading = false;
  getMyOffers() async {
    try {
      isLoading = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await myOffersRepo.getMyOffers();
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
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }
  }

  bool isOfferDetailsLoading = false;
  OfferModel? myOfferDetails;
  int? offerId;
  updateOfferId(v) {
    offerId = v;
  }

  getMyOfferDetails() async {
    try {
      myOfferDetails = null;
      isOfferDetailsLoading = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await myOffersRepo.getMyOfferDetails(id: offerId!);
      response.fold(
          (l) => CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: l.error,
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.transparent)), (response) {
        myOfferDetails = OfferModel.fromJson(response.data["data"]['offer']);
        isOfferDetailsLoading = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isOfferDetailsLoading = false;
      notifyListeners();
    }
  }

  bool isDelete = false;
  deleteMyOffer(id) async {
    try {
      spinKitDialog();
      isDelete = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await myOffersRepo.deleteMyOffer(id);
      response.fold((l) {
        CustomNavigator.pop();
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: l.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        isDelete = false;
        notifyListeners();
      }, (response) {
        getMyOffers();
        CustomNavigator.push(Routes.DASHBOARD, arguments: 3, clean: true);
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: getTranslated(
                    isDriver
                        ? "offer_deleted_successfully"
                        : "request_deleted_successfully",
                    CustomNavigator.navigatorState.currentContext!),
                isFloating: true,
                backgroundColor: Styles.ACTIVE,
                borderColor: Colors.transparent));
        isDelete = false;
        notifyListeners();
      });
    } catch (e) {
      CustomNavigator.pop();
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isDelete = false;
      notifyListeners();
    }
  }
}
