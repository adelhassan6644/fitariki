import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/features/followers/followers/model/followers_model.dart';
import 'package:fitariki/features/followers/followers/repo/followers_repo.dart';
import 'package:flutter/material.dart';

import '../../../../app/core/utils/app_snack_bar.dart';
import '../../../../app/core/utils/color_resources.dart';
import '../../../../data/error/api_error_handler.dart';
import '../../../../data/error/failures.dart';

class FollowerProvider extends ChangeNotifier {
  FollowersRepo followersRepo;
  FollowerProvider({required this.followersRepo});

  bool isLoading = false;

  FollowersModel? data;

  getFollowers() async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await followersRepo.getFollowers();
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
        data = FollowersModel.fromJson(response.data);
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
