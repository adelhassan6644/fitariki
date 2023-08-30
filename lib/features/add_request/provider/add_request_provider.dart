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
import '../../followers/followers/provider/followers_provider.dart';
import '../../my_trips/provider/my_trips_provider.dart';
import '../../profile/provider/profile_provider.dart';
import '../repo/add_request_repo.dart';

class AddRequestProvider extends ChangeNotifier {
  AddRequestRepo addRequestRepo;
  AddRequestProvider({required this.addRequestRepo});

  List<String> rideTypes = ["go", "back"];
  List<int> selectedRideTypes = [];
  int? selectedRideType;

  onSelectRideTypes(v) {
    if (selectedRideTypes.contains(v)) {
      selectedRideTypes.remove(v);
    } else {
      selectedRideTypes.add(v);
    }

    if (selectedRideTypes.length > 1) {
      selectedRideType = 3;
    } else {
      if (selectedRideTypes.isNotEmpty) {
        selectedRideType = selectedRideTypes.first;
      } else {
        selectedRideType = null;
      }
    }
    notifyListeners();
  }

  TextEditingController minPrice = TextEditingController();

  DateTime startDate = DateTime.now();
  int duration = 0;

  List<int>? days;
  updateOfferDays(v) {
    days = v;
    notifyListeners();
  }

  onSelectStartDate(v) {
    startDate = v;
    getDaysCount();
    notifyListeners();
  }

  DateTime endDate = DateTime.now();
  onSelectEndDate(v) {
    endDate = v;
    getDaysCount();
    notifyListeners();
  }

  void getDaysCount() {
    if (days != null) {
      duration = Methods.getWeekdayCount(
              startDate: startDate, endDate: endDate, weekdays: days!)
          .days;

      sl<CalenderProvider>().updateDays(days);
      sl<CalenderProvider>()
          .getEventsList(startDate: startDate, endDate: endDate);

      notifyListeners();
    }
  }

  reset() {
    minPrice.clear();
    selectedRideTypes.clear();
    selectedRideType = null;
    startDate = DateTime.now();
    endDate = DateTime.now();
    duration = 0;
    sl<CalenderProvider>()
        .getEventsList(startDate: DateTime.now(), endDate: DateTime.now());
    sl.get<FollowersProvider>().selectedFollowers.clear();
  }

  checkData(
      {required double minOfferPrice,
      required double maxOfferPrice,
      required bool isSpecialOffer}) {
    if (selectedRideTypes.isEmpty) {
      showToast("برجاء اختيار نوع المشوار!");

      return;
    }

    if (endDate.isBefore(startDate)) {
      showToast("تاريخ النهاية لا يجب ان يكون قبل تاريخ البداية!");
      return;
    }

    if (endDate.isAtSameMomentAs(startDate)) {
      showToast(" تاريخ النهاية لا يجب ان يكون مثل تاريخ البداية!");
      return;
    }

    if (!isSpecialOffer) {
      if (minPrice.text.trim().isEmpty) {
        showToast("برجاء ادخال الحد الادني للسعر!");
        return;
      }

      if (minOfferPrice > double.parse(minPrice.text.trim())) {
        showToast(
            "برجاء ادخال الحد الادني للسعر اكبر من الحد الادني لسعر العرض!");
        return;
      }

      if (maxOfferPrice < double.parse(minPrice.text.trim())) {
        showToast(
            "برجاء ادخال الحد الادني للسعر اقل من الحد الاقصي لسعر العرض!");
        return;
      }
    }
    return true;
  }

  bool isLoading = true;
  requestOffer({id, String? name, required bool isSpecialOffer}) async {
    try {
      spinKitDialog();
      isLoading = true;
      notifyListeners();

      final data = {
        "request_offer": {
          '${sl.get<SharedPreferences>().getString(AppStorageKey.role)}_id':
              sl.get<SharedPreferences>().getString(AppStorageKey.userId),
          "offer_type": selectedRideType,
          "start_date": startDate.defaultFormat2(),
          "start_at": startDate.defaultFormat2(),
          "end_date": endDate.defaultFormat2(),
          "end_at": endDate.defaultFormat2(),
          "duration": duration,
          "price": minPrice.text.trim(),
          if (sl.get<FollowersProvider>().addFollowers &&
              sl.get<FollowersProvider>().selectedFollowers.isNotEmpty &&
              !sl<ProfileProvider>().isDriver)
            "request_followers": List<dynamic>.from(sl
                .get<FollowersProvider>()
                .selectedFollowers
                .map((x) => x.toPostJson()))
        }
      };
      Either<ServerFailure, Response> response = await addRequestRepo
          .requestOffer(body: data, id: id, isSpecialOffer: isSpecialOffer);
      response.fold((fail) {
        CustomNavigator.pop();
        showToast(fail.error);
      }, (response) async {
        sl<MyTripsProvider>().getPendingTrips();
        CustomNavigator.pop();
        CustomNavigator.pop();
        reset();
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: getTranslated(
                    "your_request_has_been_sent_successfully",
                    CustomNavigator.navigatorState.currentContext!),
                isFloating: true,
                backgroundColor: Styles.ACTIVE,
                borderColor: Colors.transparent));
      });

      isLoading = false;
      notifyListeners();
    } catch (e) {
      CustomNavigator.pop();
      showToast(e);
      isLoading = false;
      notifyListeners();
    }
  }
}
