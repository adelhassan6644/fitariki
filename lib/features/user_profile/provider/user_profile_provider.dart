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

  clear() {
    userProfileModel = null;
    userOffers = null;
    userFollowers = null;
  }

  bool isLoadProfile = false;
  ProfileModel? userProfileModel;

  bool isLoadOffers = false;
  MyOffersModel? userOffers;
  getUserProfile({required int userId, bool myProfile = false}) async {
    try {
      clear();
      isLoadProfile = true;
      isLoadOffers = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await userProfileRepo.getUserProfile(
        userID: userId,
        myProfile: myProfile,
      );
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(l),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        isLoadProfile = false;
        isLoadOffers = false;
        notifyListeners();
      }, (response) {
        final String role;
        if (myProfile) {
          role = isDriver ? "driver" : "client";
        } else {
          role = isDriver ? "client" : "driver";
        }
        userProfileModel = ProfileModel.fromJson(response.data["data"]);
        userOffers = MyOffersModel.fromJson(response.data["data"][role]);
        isLoadProfile = false;
        isLoadOffers = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoadProfile = false;
      isLoadOffers = false;

      notifyListeners();
    }
  }

  bool isLoadFollowers = false;
  FollowersModel? userFollowers;
  getUserFollowers({required int id, bool myProfile = false}) async {
    try {
      clear();
      isLoadFollowers = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await userProfileRepo.getUserFollowers(id: id);
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(l),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
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
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoadFollowers = false;
      notifyListeners();
    }
  }
}
