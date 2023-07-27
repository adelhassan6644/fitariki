import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:fitariki/app/localization/localization/language_constant.dart';
import 'package:fitariki/features/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/methods.dart';
import '../../../components/loading_dialog.dart';
import '../../../data/config/di.dart';
import '../../../main_models/offer_model.dart';
import '../../../main_providers/schedule_provider.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../maps/models/location_model.dart';
import '../../success/model/success_model.dart';
import '../repo/post_offer_repo.dart';

class PostOfferProvider extends ChangeNotifier {
  PostOfferRepo postOfferRepo;
  final ScheduleProvider scheduleProvider;
  PostOfferProvider({
    required this.postOfferRepo,
    required this.scheduleProvider,
  });

  bool get isLogin => postOfferRepo.isLoggedIn();
  bool get isDriver => postOfferRepo.isDriver();

  bool sameHomeLocation = false;
  void onSelect(bool value) {
    sameHomeLocation = value;
    if (value) {
      startLocation = sl<ProfileProvider>().startLocation;
    } else {
      startLocation = null;
    }
    notifyListeners();
  }

  LocationModel? startLocation;
  onSelectStartLocation(v) {
    startLocation = v;
    notifyListeners();
  }

  bool sameDestination = false;
  void onSelect1(bool value) {
    sameDestination = value;
    if (value) {
      endLocation = sl<ProfileProvider>().endLocation;
    } else {
      endLocation = null;
    }
    notifyListeners();
  }

  OfferModel? offerModel;
  LocationModel? endLocation;
  onSelectEndLocation(v) {
    endLocation = v;
    notifyListeners();
  }

  String? minPrice, maxPrice;

  // List<String> timeZones = ["morning", "night"];
  // String startTimeZone = "morning";
  // String endTimeZone = "morning";
  // void selectedStartTimeZone(String value) {
  //   startTimeZone = value;
  //   notifyListeners();
  // }
  //
  // void selectedEndTimeZone(String value) {
  //   endTimeZone = value;
  //   notifyListeners();
  // }

  DateTime startTime = DateTime.now();

  onSelectStartTime(v) {
    startTime = v;
    notifyListeners();
  }

  DateTime endTime = DateTime.now();

  onSelectEndTime(v) {
    endTime = v;
    notifyListeners();
  }

  DateTime startDate = DateTime.now();

  onSelectStartDate(v) {
    startDate = v;
    getDaysCount();
    notifyListeners();
  }

  DateTime endDate = DateTime.now();
  WeekdayCount? counts;
  onSelectEndDate(v) {
    endDate = v;

    /// get days count
    getDaysCount();

    notifyListeners();
  }

  void getDaysCount() {
    List<int> days = [];
    for (var element in scheduleProvider.selectedDays) {
      element.startTime = startTime.dateFormat(format: "kk:mm");
      element.endTime = endTime.dateFormat(format: "kk:mm");
      days.add(element.id!);
    }

    counts = Methods.getWeekdayCount(
        startDate: startDate, endDate: endDate, weekdays: days);
    notifyListeners();
  }

  bool addFollowers = false;
  onChange(v) {
    addFollowers = v;
    notifyListeners();
  }

  List<String> followers = [];
  List<String> selectedFollowers = [];
  onSelectFollow(v, index) {
    if (v) {
      selectedFollowers.add(followers[index]);
    } else {
      selectedFollowers.removeAt(index);
    }
    notifyListeners();
  }

  reset() {
    startLocation = null;
    endLocation = null;
    minPrice = null;
    maxPrice = null;
    startTime = DateTime.now();
    endTime = DateTime.now();
    startDate = DateTime.now();
    selectedFollowers.clear();
    sameHomeLocation = false;
    sameDestination = false;
    scheduleProvider.selectedDays.clear();
    onSelectEndDate(DateTime.now());
    sl<ProfileProvider>().getProfile();
  }

  checkData() {
    if (startLocation == null) {
      showToast("برجاء اختيار نقطة البدية!");

      return;
    }
    if (scheduleProvider.selectedDays.isEmpty) {
      showToast("برجاء اختيار الايام!");

      return;
    }
    if (startTime.isAtSameMomentAs(endTime)) {
      showToast(" وقت النهاية لا يجب ان يكون مثل وقت البداية!");

      return;
    }

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
    if (maxPrice == null || maxPrice == "") {
      showToast("برجاء اختيار الحد الاعلي للسعر!");

      return;
    }
    if (double.parse(minPrice!) >= double.parse(maxPrice!)) {
      showToast("الحد الاعلي للسعر يجب ان يكون اعلي من الحد الادني للسعر!");

      return;
    }
    if (endLocation == null) {
      showToast("برجاء اختيار نقطة النهاية!");

      return;
    }
    return true;
  }

  postOffer() async {
    try {
      offerModel = OfferModel(
        pickupLocation: endLocation,
        dropOffLocation: startLocation,
        startDate: startDate,
        endDate: endDate,
        minPrice: double.tryParse(minPrice!),
        maxPrice: double.tryParse(maxPrice!),
        offerDays: scheduleProvider.selectedDays,
        duration: counts!.count,

        // duration:
      );
      spinKitDialog();
      notifyListeners();
      final response = await postOfferRepo.postOffer(offerModel: offerModel!);
      response.fold((fail) {
        CustomNavigator.pop();
        showToast(fail.error);
        notifyListeners();
      }, (response) {
        reset();
        CustomNavigator.pop();
        CustomNavigator.pop();
        CustomNavigator.push(Routes.SUCCESS,
            replace: true,
            arguments: SuccessModel(
                isPopUp: true,
                isClean: true,
                routeName: Routes.DASHBOARD,
                argument: 0,
                description: !sl<ProfileProvider>().isDriver
                    ? getTranslated("sent_request_successfully",
                        CustomNavigator.navigatorState.currentContext!)
                    : getTranslated("sent_offer_successfully",
                        CustomNavigator.navigatorState.currentContext!)));
      });
      notifyListeners();
    } catch (e) {
      CustomNavigator.pop();
      showToast(e);
      notifyListeners();
    }
  }
}
