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
import '../repo/add_request_repo.dart';

class AddRequestProvider extends ChangeNotifier {
  AddRequestRepo addRequestRepo;
  AddRequestProvider({required this.addRequestRepo});

  // String?  note;

  TextEditingController minPrice = TextEditingController();

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
    minPrice.clear();
    // note = null;
    startDate = DateTime.now();
    onSelectEndDate(DateTime.now());
  }

  checkData({required double minOfferPrice,required double maxOfferPrice}) {
    if (startDate.isAtSameMomentAs(endDate)) {
      showToast(" تاريخ النهاية لا يجب ان يكون مثل تاريخ البداية!");

      return;
    }

    if (!startDate.isBefore(endDate)) {
      showToast(" تاريخ النهاية لا يجب ان يكون قبل تاريخ البداية!");

      return;
    }

    if (minPrice.text.trim().isEmpty ) {
      showToast("برجاء ادخال الحد الادني للسعر!");
      return;
    }

    if ( minOfferPrice > double.parse(minPrice.text.trim()) ) {
      showToast("برجاء ادخال الحد الادني للسعر اكبر من الحد الادني لسعر العرض!");
      return;
    }

    if ( maxOfferPrice < double.parse(minPrice.text.trim()) ) {
      showToast("برجاء ادخال الحد الادني للسعر اقل من الحد الاقصي لسعر العرض!");
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
          "start_at": startDate.defaultFormat2(),
          "end_date": endDate.defaultFormat2(),
          "end_at": endDate.defaultFormat2(),
          "duration": duration,
          "price": minPrice.text.trim(),
          if (sl.get<FollowersProvider>().addFollowers &&
              sl.get<FollowersProvider>().selectedFollowers.isNotEmpty&& !sl<ProfileProvider>().isDriver )
            "request_followers": List<dynamic>.from(sl
                .get<FollowersProvider>()
                .selectedFollowers
                .map((x) => x.toPostJson()))
        }
      };
      Either<ServerFailure, Response> response =
          await addRequestRepo.requestOffer(body: data, tripID: tripID);
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
                term: name,
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