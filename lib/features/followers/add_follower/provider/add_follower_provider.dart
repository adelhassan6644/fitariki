
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';

import '../../../../app/core/utils/app_snack_bar.dart';
import '../../../../app/core/utils/color_resources.dart';
import '../../../../app/core/utils/svg_images.dart';
import '../../../../components/loading_dialog.dart';
import '../../../../data/error/failures.dart';
import '../../../maps/models/location_model.dart';
import '../../followers/provider/followers_provider.dart';
import '../repo/add_follower_repo.dart';

class AddFollowerProvider extends ChangeNotifier {
  AddFollowersRepo addFollowersRepo;
  FollowersProvider followerProvider;
  AddFollowerProvider(
      {required this.addFollowersRepo, required this.followerProvider});

  TextEditingController followerFullName = TextEditingController();
  TextEditingController age = TextEditingController();

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

  LocationModel? startLocation;
  onSelectStartLocation(v) {
    startLocation = v;
    notifyListeners();
  }

  LocationModel? endLocation;
  onSelectEndLocation(v) {
    endLocation = v;
    notifyListeners();
  }

  bool sameDestination = true;
  void onSelect1(bool value) {
    sameDestination = value;
    notifyListeners();
  }


  reset() {
    followerFullName.clear();
    age.clear();
    _gender=0;
    startLocation=null;
    endLocation = null;
    notifyListeners();
  }

  bool isLoading = false;
  updateFollowerDetails() async {
    try {
      spinKitDialog();
      isLoading = true;
      notifyListeners();

      final data = {
        "data": {
          "name": followerFullName.text.trim(),
          "gender": gender,
          "age": age.text.trim(),
          "drop_off_location": endLocation!.toJson(),
          "pickup_location": startLocation!.toJson(),
        }
      };

      log(data.toString());
      Either<ServerFailure, Response> response =
      await addFollowersRepo.addFollower(body: data);
      response.fold((fail) {
        CustomNavigator.pop();
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        isLoading = false;
        notifyListeners();
      }, (response) {
        CustomNavigator.pop();
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "تم تحديث بياناتك بنجاح !",
                isFloating: true,
                backgroundColor: ColorResources.ACTIVE,
                borderColor: Colors.transparent));
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      CustomNavigator.pop();
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
