import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/config/di.dart';
import '../../../data/error/failures.dart';
import '../../../navigation/custom_navigation.dart';
import '../../followers/followers/provider/followers_provider.dart';
import '../repo/add_offer_repo.dart';

class AddOfferProvider extends ChangeNotifier {
  AddOfferRepo addOfferRepo;
  AddOfferProvider({required this.addOfferRepo});

  String? minPrice, note;

  DateTime startDate = DateTime.now();
  onSelectStartDate(v) {
    startDate = v;
    notifyListeners();
  }

  DateTime endDate = DateTime.now();
  onSelectEndDate(v) {
    endDate = v;
    notifyListeners();
  }

  bool isLoading = true;
  addOffer() async {
    try {
      isLoading = true;
      notifyListeners();

      final data = {
        if (sl.get<FollowersProvider>().addFollowers)
          "followers": sl.get<FollowersProvider>().selectedFollowers
      };

      Either<ServerFailure, Response> response =
          await addOfferRepo.addOffer(body: data);
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
      }, (response) async {
        CustomNavigator.pop();
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "تم تقديم العرض بنجاح !",
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
