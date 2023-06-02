import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/components/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/app_storage_keys.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/methods.dart';
import '../../../data/config/di.dart';
import '../../../data/error/failures.dart';
import '../../../main_providers/calender_provider.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../followers/followers/provider/followers_provider.dart';
import '../../offer_details/provider/offer_details_provider.dart';
import '../../profile/provider/profile_provider.dart';
import '../../success/model/success_model.dart';
import '../repo/add_offer_repo.dart';

class AddOfferProvider extends ChangeNotifier {
  AddOfferRepo addOfferRepo;
  AddOfferProvider({required this.addOfferRepo});

  String? minPrice, note;

  DateTime startDate = DateTime.now();
  int duration = 0;

  onSelectStartDate(v) {
    startDate = v;
    sl<CalenderProvider>()
        .getEventsList(startDate: startDate, endDate: endDate);
    duration = Methods.getWeekdayCount(
            startDate: startDate,
            endDate: endDate,
            weekdays: sl
                .get<OfferDetailsProvider>()
                .offerDetails!
                .offerDays!
                .map((e) => e.id)
                .toList())
        .days;
    notifyListeners();
  }

  DateTime endDate = DateTime.now();
  onSelectEndDate(v) {
    endDate = v;
    sl<CalenderProvider>()
        .getEventsList(startDate: startDate, endDate: endDate);
    duration = Methods.getWeekdayCount(
            startDate: startDate,
            endDate: endDate,
            weekdays: sl
                .get<OfferDetailsProvider>()
                .offerDetails!
                .offerDays!
                .map((e) => e.id)
                .toList())
        .days;
    notifyListeners();
  }

  reset() {
    minPrice = null;
    note = null;
    startDate = DateTime.now();
    onSelectEndDate(DateTime.now());
  }

  checkData() {
    if (startDate.isAtSameMomentAs(endDate)) {
      showToast(" تاريخ النهاية لا يجب ان يكون مثل تاريخ البداية!");

      return;
    }

    if (!startDate.isBefore(endDate)) {
      showToast(" تاريخ النهاية لا يجب ان يكون قبل تاريخ البداية!");

      return;
    }

    if (minPrice == null || minPrice == "") {
      showToast("برجاء اختيار الحد الادني للسعر!");
      return;
    }
    return true;
  }

  bool isLoading = true;
  requestOffer({tripID, String? name}) async {
    try {
      spinKitDialog();
      isLoading = true;
      notifyListeners();

      final data = {
        "request_offer": {
          sl<ProfileProvider>().isDriver ? 'driver_id' : "client_id":
              sl.get<SharedPreferences>().getString(AppStorageKey.userId),
          "start_date": startDate.defaultFormat2(),
          "end_date": endDate.defaultFormat2(),
          "duration": duration,
          "price": minPrice,
          if (sl.get<FollowersProvider>().addFollowers &&
              sl.get<FollowersProvider>().selectedFollowers.isNotEmpty)
            "request_followers": List<dynamic>.from(sl
                .get<FollowersProvider>()
                .selectedFollowers
                .map((x) => x.toPostJson()))
        }
      };
      Either<ServerFailure, Response> response =
          await addOfferRepo.requestOffer(body: data, tripID: tripID);
      response.fold((fail) {
        CustomNavigator.pop();
        showToast(fail.error);
        isLoading = false;
        notifyListeners();
      }, (response) async {
        CustomNavigator.pop();
        reset();
        CustomNavigator.push(Routes.SUCCESS,
            replace: true,
            arguments: SuccessModel(
                isCongrats: true,
                routeName: Routes.DASHBOARD,
                argument: 1,
                title: name,
                isClean: true,
                btnText: getTranslated(
                    "my_trips", CustomNavigator.navigatorState.currentContext!),
                description: sl<ProfileProvider>().isDriver
                    ? "تم ارسال عرضك على الراكب $name  \nفعل التنبيهات ليصلك تنبيه عند قبولها!"
                    : "تم ارسال عرضك على الكابتن $name  \nفعل التنبيهات ليصلك تنبيه عند قبولها!"));
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
