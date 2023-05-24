import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/components/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/app_storage_keys.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/config/di.dart';
import '../../../data/error/failures.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
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
  requestOffer({tripID}) async {
    try {
      spinKitDialog();
      isLoading = true;
      notifyListeners();

      final data = {
        "request_offer": {
          "client_id": sl.get<SharedPreferences>().getString(AppStorageKey.userId),
          "start_date": startDate,
          "end_date": endDate,
          "duration": 10,
          "price": 250,
          if (sl.get<FollowersProvider>().addFollowers)
            "request_followers": List<dynamic>.from(sl
                .get<FollowersProvider>()
                .selectedFollowers
                .map((x) => x.toPostJson()))
        }
      };
print(data);
      Either<ServerFailure, Response> response =
          await addOfferRepo.requestOffer(body: data,tripID:tripID);
      response.fold((fail) {
        CustomNavigator.pop();
        showToast(fail.error);

        isLoading = false;
        notifyListeners();
      }, (response) async {
        CustomNavigator.pop();
        CustomNavigator.push(Routes.SUCCESS_POST,
            replace: true, arguments: "محمد");
        // CustomNavigator.pop();
        // CustomSnackBar.showSnackBar(
        //     notification: AppNotification(
        //         message: "تم تقديم العرض بنجاح !",
        //         isFloating: true,
        //         backgroundColor: ColorResources.ACTIVE,
        //         borderColor: Colors.transparent));
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
