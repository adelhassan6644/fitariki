import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../followers/followers/model/followers_model.dart';
import '../../my_offers/model/my_offer.dart';
import '../../profile/model/profile_model.dart';
import '../repo/user_profile_repo.dart';

class UserProfileProvider extends ChangeNotifier {
  UserProfileRepo userProfileRepo;
  UserProfileProvider({required this.userProfileRepo});

  bool get isDriver => userProfileRepo.isDriver();

  bool isLoadProfile = false;
  ProfileModel? userProfileModel;
  getUserProfile({required int userId}) async {
    try {
      isLoadProfile = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await userProfileRepo.getUserProfile(
        userID: userId,
      );
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(l),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        isLoadProfile = false;
        notifyListeners();
      }, (response) {
        userProfileModel = ProfileModel.fromJson(response.data["data"]);
        isLoadProfile = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoadProfile = false;
      notifyListeners();
    }
  }

  bool isLoadOffers = false;
  MyOffersModel? userOffers;
  getUserOffers({required int id}) async {
    try {
      userOffers = null;
      isLoadOffers = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await userProfileRepo.getUserOffers(id: id);
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(l),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        isLoadOffers = false;
        notifyListeners();
      }, (response) {
        userOffers = MyOffersModel.fromJson(response.data["data"]);
        isLoadOffers = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoadOffers = false;
      notifyListeners();
    }
  }

  bool isLoadFollowers = false;
  FollowersModel? userFollowers;
  getUserFollowers({required int id}) async {
    try {
      userFollowers = null;
      isLoadFollowers = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await userProfileRepo.getUserFollowers(id: id);
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(l),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        isLoadFollowers = false;
        notifyListeners();
      }, (response) {
        userFollowers = FollowersModel.fromJson(response.data);
        isLoadFollowers = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoadFollowers = false;
      notifyListeners();
    }
  }
}
