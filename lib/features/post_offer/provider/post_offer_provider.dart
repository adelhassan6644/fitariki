import 'package:fitariki/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../app/core/utils/methods.dart';
import '../../../main_models/offer_details_model.dart';
import '../../../main_providers/schedule_provider.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../maps/models/location_model.dart';
import '../repo/post_offer_repo.dart';

class PostOfferProvider extends ChangeNotifier {
  PostOfferRepo postOfferRepo;
  final ScheduleProvider scheduleProvider;
  PostOfferProvider({
    required this.postOfferRepo,
    required this.scheduleProvider,
  });

  LocationModel? startLocation;
  onSelectStartLocation(v) {
    startLocation = v;

    notifyListeners();
  }

  OfferDetailsModel? offerModel;
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
    notifyListeners();
  }

  DateTime endDate = DateTime.now();
  WeekdayCount? counts;
  onSelectEndDate(v) {
    endDate = v;

    /// get days count
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

  bool addFollowers = true;
  onChange(v) {
    addFollowers = v;
    notifyListeners();
  }

  List<String> followers = ["محمد احمد", "لؤي احمد", "محمد الفيصل"];
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
    scheduleProvider.selectedDays.clear();
    onSelectEndDate(DateTime.now());
  }

  checkData() {
    if (startLocation == null) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء اختيار الصورةالشخصية!",
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (scheduleProvider.selectedDays.isEmpty) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء اختيار الايام!",
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (startTime == null) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء ادخال الاسم الثلاثي!",
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (endTime != startTime) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء اختيار العمر!",
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (startDate != null) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء اختيار العمر!",
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (endDate != startDate) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء اختيار العمر!",
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (minPrice != null) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء اختيار العمر!",
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (maxPrice != null) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء اختيار العمر!",
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    if (endLocation == null) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "برجاء اختيار الحنسية!",
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      return;
    }
    return true;
  }

  bool isLoading = false;
  postOffer() async {
    offerModel = OfferDetailsModel(
      pickLocation: endLocation,
      endLocation: startLocation,
      startDate: startDate,
      endDate: endDate,
      minPrice: double.tryParse(minPrice!),
      maxPrice: double.tryParse(maxPrice!),
      offerDays: scheduleProvider.selectedDays,
      duration: counts!.count,

      // duration:
    );
    isLoading = true;
    notifyListeners();
    final response = await postOfferRepo.postOffer(offerModel: offerModel!);
    response.fold((fail) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: fail.error,
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
    }, (response) {
      CustomNavigator.push(Routes.SUCCESS_POST, clean: true, arguments: "");
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: "Success",
              isFloating: true,
              backgroundColor: ColorResources.ACTIVE,
              borderColor: Colors.transparent));
    });
    isLoading = false;
    notifyListeners();
  }
}
