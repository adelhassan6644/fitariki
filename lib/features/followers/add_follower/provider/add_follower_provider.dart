import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';

import '../../../../app/core/utils/app_snack_bar.dart';
import '../../../../app/core/utils/color_resources.dart';
import '../../../../app/core/utils/svg_images.dart';
import '../../../../data/error/api_error_handler.dart';
import '../../../../data/error/failures.dart';
import '../../../maps/models/address_model.dart';
import '../../follower_details/model/follower_model.dart';
import '../../followers/provider/followers_provider.dart';
import '../repo/add_follower_repo.dart';

class AddFollowerProvider extends ChangeNotifier {
  AddFollowersRepo addFollowersRepo;
  FollowerProvider followerProvider;
  AddFollowerProvider(
      {required this.addFollowersRepo, required this.followerProvider});

  FollowerModel followerModel = FollowerModel();

  String? age, followerFullName;
  List<String> genders = ["male", "female"];
  List<String> genderIcons = [SvgImages.maleIcon, SvgImages.femaleIcon];
  int _gender = 0;
  int get gender => _gender;
  selectedGender(int value) {
    _gender = value;
    notifyListeners();
  }

  bool sameHomeLocation = true;
  void onSelect(bool value) {
    sameHomeLocation = value;
    notifyListeners();
  }

  // LocationModel? startLocation;
  onSelectStartLocation(v) {
    // startLocation = v;
    followerModel.copyWith(pickLocation: v);
    notifyListeners();
  }

  // LocationModel? endLocation;
  onSelectEndLocation(v) {
    // endLocation = v;
    followerModel.copyWith(endLocation: v);
    notifyListeners();
  }

  bool sameDestination = true;
  void onSelect1(bool value) {
    sameDestination = value;
    notifyListeners();
  }

  reset() {
    followerModel.copyWith(fullName: null,age: null,gender: 0,);
    followerFullName = null;
    age = null;
    _gender = 0;
    // startLocation = null;
    // endLocation = null;
    sameDestination = true;
    sameHomeLocation = true;
  }

  bool isLoading = false;
  addFollower() async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> res =
          await addFollowersRepo.addFollower();
      res.fold((fail) {
        CustomNavigator.pop();
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        isLoading = false;
        notifyListeners();
      }, (success) {
        followerProvider.getFollowers();
        CustomNavigator.pop();
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: success.data["data"].toString(),
                isFloating: true,
                backgroundColor: ColorResources.ACTIVE,
                borderColor: Colors.transparent));
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      log(e.toString());
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
    }
  }
}
