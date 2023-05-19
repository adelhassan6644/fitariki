import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../app/core/utils/app_snack_bar.dart';
import '../../../../app/core/utils/color_resources.dart';
import '../../../../app/core/utils/svg_images.dart';
import '../../../../components/loading_dialog.dart';
import '../../../../data/error/failures.dart';
import '../../../../navigation/custom_navigation.dart';
import '../../../maps/models/location_model.dart';
import '../model/follower_model.dart';
import '../repo/follower_details_repo.dart';

class FollowerDetailsProvider extends ChangeNotifier {
  FollowerDetailsRepo followerDetailsRepo;
  FollowerDetailsProvider({required this.followerDetailsRepo});

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


  updateFollowerDetails()async {
    try {
      spinKitDialog();
      isLoading = true;
      notifyListeners();

      final data = {
        "follower": {
          "name": followerFullName.text.trim(),
          "gender": gender,
          "age": age.text.trim(),
          "drop_off_location": endLocation!.toJson(),
          "pickup_location": startLocation!.toJson(),
        }
      };

      log(data.toString());
      Either<ServerFailure, Response> response =
      await followerDetailsRepo.updateFollowerDetails(body: data);
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


  ///Get Follower Details
  bool isLoading = false;
  FollowerModel? followerModel;
  getFollowerDetails() async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
      await followerDetailsRepo.getFollowerDetails();
      response.fold((l){
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: l.toString(),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        isLoading = false;
        notifyListeners();
      }, (response) {
        followerModel = FollowerModel.fromJson(response.data['data']);
        initFollowerData();
        isLoading = false;
        notifyListeners();
      });
    }catch (e){
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

  initFollowerData() {
    startLocation = followerModel?.pickupLocation;
    endLocation = followerModel?.dropOffLocation;
    followerFullName.text = followerModel?.fullName ?? "";
    age.text = followerModel?.age ?? "";
    _gender = followerModel?.gender ?? 0;
  }
}
