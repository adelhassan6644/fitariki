import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../profile/model/profile_model.dart';
import '../repo/user_profile_repo.dart';

class UserProfileProvider extends ChangeNotifier {
  UserProfileRepo userProfileRepo;
  UserProfileProvider({required this.userProfileRepo});

  bool isLoading = false;
  ProfileModel? userProfileModel;

  getUserProfile({required int userId,required userType}) async {
    try {
      print("====>${userType}");
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await userProfileRepo.getUserProfile(userID: userId,userType: userType);
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(l),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        isLoading = false;
        notifyListeners();
      }, (response) {
        userProfileModel = ProfileModel.fromJson(response.data["data"]);
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }
  }
}
